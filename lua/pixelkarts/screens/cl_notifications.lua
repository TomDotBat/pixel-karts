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

PIXEL.RegisterFontUnscaled("Karts.Notification", "Open Sans SemiBold", 44)

local backgroundCol = PIXEL.OffsetColor(PIXEL.Colors.Background, 10)

local notifMargin = 10
local notifH = 60
local notifPad = 10

local function drawNotification(x, y, w, h, text, textCol, iconId, iconCol)
    PIXEL.DrawRoundedBox(4, x, y, w, h, backgroundCol)

    PIXEL.DrawSimpleText(text, "Karts.Notification", x + notifPad, y + notifH * .5, textCol, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
end

local notifData

PIXEL.Karts.SteeringWheelScreen("notification_overlay", "Notification Overlay", function(screen, kart, offset, w, h, localPly, fullH)
    if not notifData then return end
    --drawNotification(notifMargin, fullH - notifH - notifMargin, w - notifMargin * 2, notifH, "Fuck", PIXEL.Colors.PrimaryText)
end, true, true)

function PIXEL.Karts.SteeringWheelNotification(text, type, length, icon)
    notifData[CurTime()] = {text, type, length, icon}
end