
PIXEL.Karts.SteeringWheelScreens = PIXEL.Karts.SteeringWheelScreens or {}
local screens = PIXEL.Karts.SteeringWheelScreens

local scrW, scrH = 395, 304
local headerH = 55
PIXEL.RegisterFontUnscaled("Karts.Header", "Open Sans SemiBold", 38)

local rounding = 4
local ui = PIXEL.UI.UI3D2D
local hoverCol = PIXEL.OffsetColor(PIXEL.Colors.Primary, -10)
local pressingCol = PIXEL.OffsetColor(PIXEL.Colors.Primary, 5)

function PIXEL.Karts.DrawButton(x, y, w, h, doClick)
    if ui.isHovering(x, y, w, h) then
        if ui.isPressing() then
            PIXEL.DrawRoundedBox(rounding, x, y, w, h, pressingCol)
            if ui.isPressed() and doClick then doClick() end
        else
            PIXEL.DrawRoundedBox(rounding, x, y, w, h, hoverCol)
        end

        return true
    end

    PIXEL.DrawRoundedBox(rounding, x, y, w, h, PIXEL.Colors.Primary)
end

function PIXEL.Karts.DrawTextButton(text, x, y, w, h, doClick)
    if PIXEL.Karts.DrawButton(x, y, w, h, doClick) then
        PIXEL.DrawSimpleText(text, "PIXEL.Karts.Radio.Buttons", x + w * .5, y + h * .5, PIXEL.Colors.SecondaryText, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        return true
    end

    PIXEL.DrawSimpleText(text, "PIXEL.Karts.Radio.Buttons", x + w * .5, y + h * .5, PIXEL.Colors.PrimaryText, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

function PIXEL.Karts.DrawImgurButton(imgurId, scale, x, y, w, h, doClick, extraX)
    extraX = extraX or 0
    local imgW, imgH = w * scale, h * scale
    if PIXEL.Karts.DrawButton(x, y, w, h, doClick) then
        PIXEL.DrawImgur(x + (w - imgW) * .5 + extraX, y + (h - imgH) * .5, imgW, imgH, imgurId, PIXEL.Colors.SecondaryText)
        return true
    end

    PIXEL.DrawImgur(x + (w - imgW) * .5 + extraX, y + (h - imgH) * .5, imgW, imgH, imgurId, PIXEL.Colors.PrimaryText)
end

local function drawHeader(screen, kart, w, h, localPly)
    PIXEL.DrawRoundedBoxEx(22, 0, 0, w, headerH, PIXEL.Colors.Header, true, true)

    local offsetX, offsetY = 10, headerH * .5
    local iconSize = headerH * .75
    local spacing = 10

    if screen:getId() ~= "dashboard" then
        PIXEL.Karts.DrawImgurButton("wuj141s", .8, offsetX, offsetY - iconSize * .5, iconSize, iconSize, function()
            PIXEL.Karts.SelectSteeringWheelScreen("dashboard")
        end)
        offsetX = offsetX + iconSize + spacing
    end

    PIXEL.DrawSimpleText(screen:getName(), "PIXEL.Karts.Header", offsetX, offsetY, PIXEL.Colors.PrimaryText, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
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

local curScreen = "startup"
function PIXEL.Karts.SelectSteeringWheelScreen(id)
    if not screens[id] then return end
    curScreen = id
end

hook.Add("PIXEL.Karts.EnteredKart", "PIXEL.Karts.Radio.DrawSteeringWheelScreen", function(kart)
    tomdotkart = kart

    timer.Simple(1.4, function()
        for _, screen in pairs(screens) do
            screen:resetData()
        end
    end)
end)

hook.Add("PIXEL.Karts.LeftKart", "PIXEL.Karts.DrawSteeringWheelScreen", function()
    --hook.Remove("PostDrawTranslucentRenderables", "PIXEL.Karts.DrawSteeringWheelScreen")
end)

if not IsValid(tomdotkart) then return end
local kart = tomdotkart

local boneId
for i = 0, kart:GetBoneCount() do
    if kart:GetBoneName(i) == "gokart_steeringwheel" then
        boneId = i
        break
    end
end

if not boneId then return end

for _, screen in pairs(screens) do
    screen:resetData()
end

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
        if screen:getShowCursor() then
            ui.drawCursor(0, 0, w, h, 32)
        end
    PIXEL.Karts.Clip()

    ui.endDraw()
end)