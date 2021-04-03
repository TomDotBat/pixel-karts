
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

local PCS = PIXEL.Karts.Radio._PCS or {}
PIXEL.Karts.Radio._PCS = PCS

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
    local stat = PIXEL.Karts.RadioStations[station]
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

    fr:SetTitle("Radio Settings")
    fr:SetSize(PIXEL.Scale(180), PIXEL.Scale(88))
    fr:Center()

    local oldPaint = fr.Paint
    fr.Paint = function(s, w, h)
        oldPaint(s, w, h)
        PIXEL.DrawSimpleText("Volume", "Karts.RadioConfig", PIXEL.Scale(8), PIXEL.Scale(36), colors.PrimaryText)
        PIXEL.DrawSimpleText("Disable 3D Volume", "Karts.RadioConfig", PIXEL.Scale(36), PIXEL.Scale(62), colors.PrimaryText)
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

local ui = PIXEL.UI.UI3D2D
local function startCutOut(drawMask)
    render.ClearStencil()
    render.SetStencilEnable(true)
    render.SetStencilCompareFunction(STENCIL_ALWAYS)
    render.SetStencilPassOperation(STENCIL_REPLACE)
    render.SetStencilFailOperation(STENCIL_KEEP)
    render.SetStencilZFailOperation(STENCIL_KEEP)
    render.SetStencilWriteMask(1)
    render.SetStencilTestMask(1)
    render.SetStencilReferenceValue(1)
    render.OverrideColorWriteEnable(true, false)

    drawMask()

    render.OverrideColorWriteEnable(false, false)
    render.SetStencilCompareFunction(STENCIL_EQUAL)
end

PIXEL.RegisterFontUnscaled("Karts.Radio.Title", "Open Sans SemiBold", 24)
PIXEL.RegisterFontUnscaled("Karts.Radio.Station", "Open Sans SemiBold", 20)
PIXEL.RegisterFontUnscaled("Karts.Radio.StationSmall", "Open Sans SemiBold", 16)
PIXEL.RegisterFontUnscaled("Karts.Radio.Buttons", "Open Sans SemiBold", 20)

local rounding = 4
local hoverCol = PIXEL.OffsetColor(colors.Primary, -10)
local pressingCol = PIXEL.OffsetColor(colors.Primary, 5)

local function button(x, y, w, h, doClick)
    if ui.isHovering(x, y, w, h) then
        if ui.isPressing() then
            PIXEL.DrawRoundedBox(rounding, x, y, w, h, pressingCol)
            if ui.isPressed() and doClick then doClick() end
        else
            PIXEL.DrawRoundedBox(rounding, x, y, w, h, hoverCol)
        end

        return true
    end

    PIXEL.DrawRoundedBox(rounding, x, y, w, h, colors.Primary)
end

local function textButton(text, x, y, w, h, doClick)
    if button(x, y, w, h, doClick) then
        PIXEL.DrawSimpleText(text, "Karts.Radio.Buttons", x + w * .5, y + h * .5, colors.SecondaryText, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        return true
    end

    PIXEL.DrawSimpleText(text, "Karts.Radio.Buttons", x + w * .5, y + h * .5, colors.PrimaryText, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

local function imgurButton(imgurId, scale, x, y, w, h, doClick, extraX)
    extraX = extraX or 0
    local imgW, imgH = w * scale, h * scale
    if button(x, y, w, h, doClick) then
        PIXEL.DrawImgur(x + (w - imgW) * .5 + extraX, y + (h - imgH) * .5, imgW, imgH, imgurId, colors.SecondaryText)
        return true
    end

    PIXEL.DrawImgur(x + (w - imgW) * .5 + extraX, y + (h - imgH) * .5, imgW, imgH, imgurId, colors.PrimaryText)
end

local bgCol = PIXEL.Colors.Background
local headerCol = PIXEL.Colors.Header

local x, y, w, h = -100, -60, 200, 120
local uiPos, uiAng = Vector(0, 10, 31.5), Angle(0, 0, 80)
hook.Add("PostDrawTranslucentRenderables", "PIXEL.Karts.DrawRadios", function(skybox, depth)
    if depth then return end

    if not IsValid(localPly) then localPly = LocalPlayer() end
    if not IsValid(localKart) then return end

    local kart = localKart
    if kart:GetNWInt("PIXEL.Karts.Health", 0) < 1 then return end

    if not ui.startDraw(kart:LocalToWorld(uiPos), kart:LocalToWorldAngles(uiAng), 0.02, kart) then return end

    local curStation = kart:RadioGetChannel()
    local csName, csUrl

    local isOn = true
    local stereoChan
    do
        stereoChan = csName or csUrl or ""
        if stereoChan == "" then
            local station = PIXEL.Karts.RadioStations[curStation]
            if station then
                stereoChan = station.Name
            else
                stereoChan = ""
                isOn = false
            end
        end
    end

    local oldClipping = DisableClipping(true)
    startCutOut(function()
        surface.SetDrawColor(255, 255, 255)
        surface.DrawRect(x, y, w, h)
    end)

    PIXEL.DrawRoundedBox(rounding, x, y, w, h, bgCol)
    PIXEL.DrawRoundedBox(rounding, x, y, w, 34, headerCol)

    PIXEL.DrawSimpleText("Kart Radio", "Karts.Radio.Title", x + 10, y + 5, colors.PrimaryText)
    imgurButton("IXSuV4w", .75, x + w - 28, y + 6, 22, 22, function()
        PIXEL.Karts.Radio.OpenSettingsMenu()
    end, 1) --Settings

    if isOn then
        local font = "Karts.Radio.Station"
        if #stereoChan > 16 then
            font = "Karts.Radio.StationSmall"
        end
        PIXEL.DrawSimpleText(stereoChan, font, 0, 0, colors.PrimaryText, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        imgurButton("AakL2C3", .75, -90, -15, 30, 30, function()
            net.Start("PIXEL.Karts.Radio")
                net.WriteInt(-1, 8)
            net.SendToServer()
        end) --Previous

        imgurButton("BsOCHLf", .75, 90 - 30, -15, 30, 30, function()
            net.Start("PIXEL.Karts.Radio")
                net.WriteInt(1, 8)
            net.SendToServer()
        end) --Next

        textButton("Turn Off", -35, 24, 70, 25, function()
            net.Start("PIXEL.Karts.Radio")
                net.WriteInt(0, 8)
            net.SendToServer()
        end)
    else
        textButton("Turn On", -35, 4, 70, 25, function()
            net.Start("PIXEL.Karts.Radio")
                net.WriteInt(0, 8)
            net.SendToServer()
        end)
    end


    ui.drawCursor(x, y, w, h, 18)

    DisableClipping(oldClipping)
    render.SetStencilEnable(false)
    ui.endDraw()
end)

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