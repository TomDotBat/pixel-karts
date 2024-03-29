--[[
    PIXEL Karts
    Copyright (C) 2022 Thomas (Tom.bat) O'Sullivan 

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program. If not, see <https://www.gnu.org/licenses/>.
]]

PIXEL.Karts.SteeringWheelApps = PIXEL.Karts.SteeringWheelApps or {}
local apps = PIXEL.Karts.SteeringWheelApps

function PIXEL.Karts.SteeringWheelApp(id, name, imgurId, color, screenId, visibilityCheck)
    local tbl = {}

    function tbl:getId() return id end
    function tbl:setId(newId) id = newId end

    function tbl:getName() return name end
    function tbl:setName(newName) name = newName end

    function tbl:getImgurId() return imgurId end
    function tbl:setImgurId(newImgurId) imgurId = newImgurId end

    function tbl:getColor() return color end
    function tbl:setColor(newColor) color = newColor end

    function tbl:getScreenId() return screenId end
    function tbl:setScreenId(newScreenId) screenId = newScreenId end

    function tbl:getScreen() return PIXEL.Karts.SteeringWheelScreens[screenId] end

    if isfunction(visibilityCheck) then
        tbl.isVisible = visibilityCheck
    else
        function tbl:isVisible() return true end
    end

    apps[id] = tbl
    return tbl
end

PIXEL.RegisterFontUnscaled("Karts.AppName", "Open Sans SemiBold", 38)

local iconBgCol = PIXEL.Colors.Transparent
local iconBgHoverCol = Color(255, 255, 255, 20)

local iconCol = PIXEL.Colors.PrimaryText

local function drawIcon(imgurId, scale, x, y, size, app)
    return PIXEL.Karts.DrawImgurButton(imgurId, scale, nil, x, y, size, size, function() PIXEL.Karts.SelectSteeringWheelScreen(app:getScreenId()) end, 1, iconBgCol, iconBgHoverCol, iconBgHoverCol, iconCol, app:getColor())
end

PIXEL.Karts.SteeringWheelScreen("dashboard", gmodI18n.getAddon("pixelkarts"):getString("dashboard"), function(screen, kart, offset, w, h, localPly, fullH)
    PIXEL.DrawRoundedBox(22, 0, 0, w, fullH, PIXEL.Colors.Background)

    local data = screen:getData()
    if not data then return end

    local visibleApps = data.visibleApps
    if not visibleApps then
        visibleApps = {}

        for appId, app in pairs(apps) do
            if app:isVisible(kart, localPly) then
                visibleApps[appId] = app
            end
        end

        data.visibleApps = visibleApps
    end

    local appCount = table.Count(visibleApps)
    local rowCount = (appCount <= 4) and 1 or 2

    local iconSize = (rowCount == 1) and 80 or 60
    local iconSpacing = 10
    local fullWidth = iconSize + iconSpacing

    local iconX = w * .5 - (fullWidth * appCount - iconSpacing) * .5
    local iconY = offset + (h * .5 - iconSize * .5)

    local appNo = 1
    for appId, app in pairs(visibleApps) do
        if drawIcon(app:getImgurId(), .8, iconX, iconY, iconSize, app) then
            PIXEL.DrawSimpleText(app:getName(), "Karts.AppName", w * .5, fullH - 6, PIXEL.Colors.SecondaryText, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
        end

        iconX = iconX + fullWidth
        appNo = appNo + 1
    end
end, true)