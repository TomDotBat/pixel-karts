local colors = PIXEL.Colors
PIXEL.Karts.Radio = {}

local cvarEnable = CreateConVar("pixel_karts_radio_enable", "1", FCVAR_ARCHIVE)
local cvarOutsideEnable = CreateConVar("pixel_karts_radio_outside_enable", "1", FCVAR_ARCHIVE)
local cvarOutsideDist = CreateConVar("pixel_karts_radio_outside_dist", "500", FCVAR_ARCHIVE)
local cvarVolume = CreateConVar("pixel_karts_radio_volume", "100", FCVAR_ARCHIVE)
local cvarNon3dVolMul = CreateConVar("pixel_karts_radio_non3d_volume", "0.5", FCVAR_ARCHIVE)
local cvarHtmlVolMul = CreateConVar("pixel_karts_radio_html_volume", "0.5", FCVAR_ARCHIVE)
local cvarNo3dSwitchReload = CreateConVar("pixel_karts_radio_no3d_switch_reload", "0", FCVAR_ARCHIVE)
local cvarDisable3d = CreateConVar("pixel_karts_radio_disable3d", "0", FCVAR_ARCHIVE)

function PIXEL.Karts.Radio.StopMedia(media)
    if media.Stop then
        media:Stop()
    else
        media:stop()
    end
end

function PIXEL.Karts.Radio.SetMediaVolume(media, vol)
    if media.SetVolume then
        media:SetVolume(vol)
    else
        media:setVolume(vol * cvarHtmlVolMul:GetFloat())
    end
end

local PCS = PIXEL.Karts.Radio.PCS or {}
PIXEL.Karts.Radio.PCS = PCS

local radioStations = PIXEL.Karts.Config.RadioStations

local localPly
local function radioThink(kart, localKart, thirdperson)
    if not IsValid(kart) or kart:IsDormant() then
        PCS[kart] = nil
        return
    end

    if not kart.GetBuiltInRadio then return end

    local isPlaying = IsValid(kart.RadioPlayer)
    local shouldPlay = cvarEnable:GetBool() and kart:GetBuiltInRadio()

    local station = kart:RadioGetChannel()
    local stat = radioStations[station]
    local url = stat and stat.Link

    if (not url or url == "") and not stat then
        shouldPlay = false

        PCS[kart] = nil
    end

    if not localKart and shouldPlay then
        local kartPos = kart:GetPos()
        local requiredDist = cvarOutsideDist:GetFloat()
        if not IsValid(localPly) then return end

        if not isPlaying then requiredDist = requiredDist - 100 end
        local playOutside = cvarOutsideEnable:GetBool() and kartPos:Distance(localPly:EyePos()) < requiredDist
        if not playOutside then
            shouldPlay = false
        end
    end

    if not shouldPlay then
        if isPlaying then kart:RadioStop() end
        return
    end

    local hasUrlChanged = kart.RadioUrl ~= url
    local should3D = not localKart or (thirdperson and not cvarDisable3d:GetBool())
    local has3DChanged = IsValid(kart.RadioPlayer) and not cvarNo3dSwitchReload:GetBool() and kart.RadioPlayer:Is3D() ~= should3D

    if isPlaying and not shouldPlay then
        kart:RadioStop()
    elseif shouldPlay and (hasUrlChanged or has3DChanged or not isPlaying) and not kart.RadioStarting then
        local only3DChanged = has3DChanged and not hasUrlChanged and isPlaying

        if IsValid(kart.RadioPlayer) and not only3DChanged then
            kart:RadioStop()
        end

        if hasUrlChanged then
            kart.RadioPlayAttempts = 0
        end

        if kart.RadioPlayAttempts >= 2 then
            return
        end

        kart.RadioStarting = true
        kart.RadioUrl = url

        local opts = should3D and "3d" or ""
        sound.PlayURL(url, opts, function(chan, err, errstr)
            if IsValid(kart.RadioPlayer) and only3DChanged then
                kart:RadioStop()
            end

            if not IsValid(chan) then
                kart.RadioPlayAttempts = (kart.RadioPlayAttempts or 0) + 1
                kart.RadioStarting = false
                return
            end
            if not IsValid(kart) then
                chan:Stop()
                return
            end

            kart.RadioStarting = false
            kart.RadioPlayer = chan
            kart.RadioPlayerCreated = CurTime()
            kart.RadioPlayAttempts = 0
        end)
    end

    if IsValid(kart.RadioPlayer) then
        local volumemul = 1

        if kart.RadioPlayer:Is3D() then
            if localKart then
                kart.RadioPlayer:SetPos(localPly:EyePos())
                kart.RadioPlayer:Set3DFadeDistance(200, 1000000000)
            else
                kart.RadioPlayer:SetPos(kart:GetPos())
                kart.RadioPlayer:Set3DFadeDistance(150, cvarOutsideDist:GetFloat())
            end
        else
            volumemul = volumemul * cvarNon3dVolMul:GetFloat()
        end

        if not localKart and kart.RadioPlayerCreated then
            volumemul = volumemul * math.min((CurTime() - kart.RadioPlayerCreated) * 2, 1)
        end

        local vol = cvarVolume:GetFloat() or 50
        vol = vol / 100
        vol = vol * volumemul
        vol = math.min(vol, 1)

        PIXEL.Karts.Radio.SetMediaVolume(kart.RadioPlayer, vol)
    end
end

hook.Add("EntityNetworkedVarChanged", "PIXEL.Karts.Radio.ChangeListener", function(ent, name, oldval, newval)
    if name ~= "PIXEL.Karts.RadioChannel" then return end
    PCS[ent] = true
end)

hook.Add("NetworkEntityCreated", "PIXEL.Karts.Radio.PCS.Add", function(ent)
    if not ent.IsPIXELKart then return end
    PCS[ent] = true
end)

hook.Add("NotifyShouldTransmit", "PIXEL.Karts.Radio.PCS.Updater", function(ent, shouldTransmit)
    if not (ent.IsPIXELKart and shouldTransmit) then return end
    PCS[ent] = true
end)

local localKart
hook.Add("Think", "PIXEL.Karts.Radio.Updater", function()
    local thirdperson
    if localKart then
        thirdperson = IsValid(localVeh) and (not localVeh.GetThirdPersonMode or localVeh:GetThirdPersonMode())
    end

    for kart, _ in pairs(PCS) do
        radioThink(kart, kart == localKart, thirdperson)
    end
end)

hook.Add("PIXEL.Karts.EnteredKart", "PIXEL.Karts.Radio.UpdateLocalKart", function(kart)
    if not kart:GetBuiltInRadio() then return end
    localKart = kart
end)

hook.Add("PIXEL.Karts.LeftKart", "PIXEL.Karts.Radio.UpdateLocalKart", function()
    localKart = nil
end)

--UI

PIXEL.RegisterFont("Karts.RadioConfig", "Open Sans SemiBold", 16)

function PIXEL.Karts.Radio.OpenSettingsMenu()
    if PIXEL.Karts.Radio.SettingsMenu then
        PIXEL.Karts.Radio.SettingsMenu:Remove()
    end

    PIXEL.Karts.Radio.SettingsMenu = vgui.Create("PIXEL.Frame")
    local fr = PIXEL.Karts.Radio.SettingsMenu

    local lang = gmodI18n.getAddon("pixelkarts")

    fr:SetTitle(lang:getString("radioSettings"))
    fr:SetSize(PIXEL.Scale(180), PIXEL.Scale(88))
    fr:Center()

    local oldPaint = fr.Paint
    fr.Paint = function(s, w, h)
        oldPaint(s, w, h)
        PIXEL.DrawSimpleText(lang:getString("radioVolume"), "Karts.RadioConfig", PIXEL.Scale(8), PIXEL.Scale(36), colors.PrimaryText)
        PIXEL.DrawSimpleText(lang:getString("radioDisable3dVolume"), "Karts.RadioConfig", PIXEL.Scale(36), PIXEL.Scale(62), colors.PrimaryText)
    end

    local slider = fr:Add("PIXEL.Slider")
    slider:SetPos(PIXEL.Scale(68), PIXEL.Scale(40))
    slider:SetSize(PIXEL.Scale(104), PIXEL.Scale(10))

    function slider:OnValueChanged(fraction)
        cvarVolume:SetFloat(fraction * 100)
    end

    local disable3d = fr:Add("PIXEL.Checkbox")
    disable3d:SetPos(PIXEL.Scale(8), PIXEL.Scale(60))
    disable3d:SetToggle(cvarDisable3d:GetBool())
    function disable3d:OnToggled(enabled)
        cvarDisable3d:SetBool(enabled)
    end

    fr:MakePopup()
end
concommand.Add("pixel_karts_radio_settings", PIXEL.Karts.Radio.OpenSettingsMenu)

PIXEL.Karts.KartTable = PIXEL.Karts.KartTable or {}

function PIXEL.Karts.KartTable:RadioStop()
    if not self.RadioPlayer then return end

    PIXEL.Karts.Radio.StopMedia(self.RadioPlayer)
    self.RadioPlayer = nil
    self.RadioPlayerCreated = nil
end

hook.Add("PIXEL.Karts.OnRemove", "PIXEL.Karts.StopRadioOnRemove", function(kart)
    kart:RadioStop()
end)