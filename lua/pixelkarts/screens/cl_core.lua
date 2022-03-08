PIXEL.Karts.SteeringWheelScreens = PIXEL.Karts.SteeringWheelScreens or {}
local screens = PIXEL.Karts.SteeringWheelScreens

local scrW, scrH = 395, 304
local headerH = 55
PIXEL.RegisterFontUnscaled("Karts.Header", "Open Sans SemiBold", 38)

local ui = PIXEL.UI.UI3D2D
local defaultRound = 8
local defaultCol = PIXEL.Colors.Primary
local defaultHoverCol = PIXEL.OffsetColor(PIXEL.Colors.Primary, -10)
local defaultPressingCol = PIXEL.OffsetColor(PIXEL.Colors.Primary, 5)

function PIXEL.Karts.DrawButton(round, x, y, w, h, doClick, col, hoverCol, pressingCol)
    if ui.isHovering(x, y, w, h) then
        if ui.isPressing() then
            PIXEL.DrawRoundedBox(round or defaultRound, x, y, w, h, pressingCol or defaultPressingCol)
            if ui.isPressed() and doClick then doClick() end
        else
            PIXEL.DrawRoundedBox(round or defaultRound, x, y, w, h, hoverCol or defaultHoverCol)
        end

        return true
    end

    PIXEL.DrawRoundedBox(round or defaultRound, x, y, w, h, col or defaultCol)
end

function PIXEL.Karts.DrawTextButton(text, font, round, x, y, w, h, doClick, col, hoverCol, pressingCol, textCol, textHoverCol)
    if PIXEL.Karts.DrawButton(round, x, y, w, h, doClick, col, hoverCol, pressingCol) then
        PIXEL.DrawSimpleText(text, font, x + w * .5, y + h * .5, textHoverCol or PIXEL.Colors.SecondaryText, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        return true
    end

    PIXEL.DrawSimpleText(text, font, x + w * .5, y + h * .5, textCol or PIXEL.Colors.PrimaryText, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

function PIXEL.Karts.DrawImgurButton(imgurId, scale, round, x, y, w, h, doClick, extraOffset, col, hoverCol, pressingCol, imgurCol, imgurHoverCol)
    extraOffset = extraOffset or 0
    local imgW, imgH = w * scale, h * scale
    if PIXEL.Karts.DrawButton(round, x, y, w, h, doClick, col, hoverCol, pressingCol) then
        PIXEL.DrawImgur(x + (w - imgW) * .5 + extraOffset, y + (h - imgH) * .5, imgW, imgH, imgurId, imgurHoverCol or PIXEL.Colors.SecondaryText)
        return true
    end

    PIXEL.DrawImgur(x + (w - imgW) * .5 + extraOffset, y + (h - imgH) * .5, imgW, imgH, imgurId, imgurCol or PIXEL.Colors.PrimaryText)
end

local function drawHeader(screen, kart, w, h, localPly)
    PIXEL.DrawRoundedBoxEx(22, 0, 0, w, headerH, PIXEL.Colors.Header, true, true)

    local offsetX, offsetY = 10, headerH * .5
    local iconSize = headerH * .75
    local spacing = 10

    if screen:getId() ~= "dashboard" then
        PIXEL.Karts.DrawImgurButton("wuj141s", .8, 4, offsetX, offsetY - iconSize * .5, iconSize, iconSize, function()
            PIXEL.Karts.SelectSteeringWheelScreen("dashboard")
        end)
        offsetX = offsetX + iconSize + spacing
    end

    PIXEL.DrawSimpleText(screen:getName(), "Karts.Header", offsetX, offsetY, PIXEL.Colors.PrimaryText, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
end

function PIXEL.Karts.SteeringWheelScreen(id, name, drawFunc, showCursor, hideHeader, persistData)
    local tbl = {}

    function tbl:getId() return id end
    function tbl:setId(newId) id = newId end

    function tbl:getName() return name end
    function tbl:setName(newName) name = newName end

    if hideHeader then
        function tbl:draw(kart, localPly)
            drawFunc(self, kart, 0, scrW, scrH, localPly, scrH)
        end
    else
        local bodyH = scrH - headerH
        function tbl:draw(kart, localPly)
            if not IsValid(kart) then return end
            drawFunc(self, kart, headerH, scrW, bodyH, localPly, scrH)
            drawHeader(self, kart, scrW, scrH, localPly)
        end
    end

    function tbl:getShowCursor() return showCursor end
    function tbl:setShowCursor(newShowState) showCursor = newShowState end

    local data
    function tbl:getData() return data end
    function tbl:setData(newData) data = newData end
    function tbl:resetData()
        if not (persistData and data) then
            data = {}
        end
    end

    function tbl:getDataKey(key) return data[key] end
    function tbl:setDataKey(key, val) data[key] = val end

    screens[id] = tbl
    return tbl
end

function PIXEL.Karts.GetSteeringWheelScreen(id)
    return screens[id]
end

local curScreen = "startup"
function PIXEL.Karts.SelectSteeringWheelScreen(id)
    if not screens[id] then return end
    curScreen = id
end

local notifScreen

hook.Add("PIXEL.Karts.EnteredKart", "PIXEL.Karts.Radio.DrawSteeringWheelScreen", function(kart)
    notifScreen = PIXEL.Karts.GetSteeringWheelScreen("notification_overlay")

    for _, screen in pairs(screens) do
        screen:resetData()
    end

    local boneId = kart:LookupBone("gokart_steeringwheel")
    if not boneId then return end

    local localPly = LocalPlayer()
    hook.Add("PostDrawTranslucentRenderables", "PIXEL.Karts.DrawSteeringWheelScreen", function(skybox, depth)
        if depth then return end
        if not IsValid(kart) then return end

        local matrix = kart:GetBoneMatrix(boneId)
        local pos = matrix:GetTranslation()
        local ang = matrix:GetAngles()

        ang:RotateAroundAxis(ang:Up(), 180)
        ang:RotateAroundAxis(ang:Right(), 90)

        pos = pos - ang:Forward() * 1.58
        pos = pos - ang:Right() * 2.955
        pos = pos + ang:Up() * 4.358

        if not ui.startDraw(pos, ang, 0.008, kart) then return end

        PIXEL.Karts.Clip:Scissor2D(scrW, scrH)
            local screen = screens[curScreen]
            screen:draw(kart, localPly)

            notifScreen:draw(kart, localPly)

            if screen:getShowCursor() then
                ui.drawCursor(0, 0, w, h, 32)
            end
        PIXEL.Karts.Clip()

        ui.endDraw()
    end)
end)

hook.Add("PIXEL.Karts.LeftKart", "PIXEL.Karts.DrawSteeringWheelScreen", function()
    hook.Remove("PostDrawTranslucentRenderables", "PIXEL.Karts.DrawSteeringWheelScreen")
end) 