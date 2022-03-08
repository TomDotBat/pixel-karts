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

PIXEL.RegisterFontUnscaled("Karts.Speedometer", "Open Sans SemiBold", 70)

local BAR_COUNT = 5
local UNITS_TO_MPH = 20
local UPDATE_RATE = .25
local MAX_SPEED = 40

local UNITS_STR = gmodI18n.getAddon("pixelkarts"):getString("speedometerUnits")

local barSpacing = 10
local barW, barH = 50, 20
local nextUpdate = 0

local curSpeed, smoothSpeed = 0, 0

local emptyBarCol = PIXEL.OffsetColor(PIXEL.Colors.Background, 8)

PIXEL.Karts.SteeringWheelScreen("speedometer", gmodI18n.getAddon("pixelkarts"):getString("speedometer"), function(screen, kart, offset, w, h, localPly, fullH)
    if CurTime() >= nextUpdate then
        curSpeed = kart:GetVelocity():Length2D() / UNITS_TO_MPH
        nextUpdate = CurTime() + UPDATE_RATE
    end

    smoothSpeed = Lerp(FrameTime() * 10, smoothSpeed, curSpeed)

    PIXEL.DrawRoundedBox(22, 0, 0, w, fullH, PIXEL.Colors.Background)
    PIXEL.DrawSimpleText(math.Round(smoothSpeed) .. UNITS_STR, "Karts.Speedometer", w * .5, fullH - 25, PIXEL.Colors.PrimaryText, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)

    local fullWidth = barW + barSpacing
    local barX = w * .5 - (fullWidth * BAR_COUNT - barSpacing) * .5
    local barY = h - 50

    for i = 1, BAR_COUNT do
        local thisBarH = barH * i
        local barProg = i / BAR_COUNT

        PIXEL.DrawRoundedBox(
            4, barX, barY - thisBarH, barW, thisBarH,
            smoothSpeed <= (MAX_SPEED * barProg) and emptyBarCol or PIXEL.LerpColor(barProg, PIXEL.Colors.Positive, PIXEL.Colors.Negative)
        )
        barX = barX + fullWidth
    end
end, true, false)

PIXEL.Karts.SteeringWheelApp("speedometer", gmodI18n.getAddon("pixelkarts"):getString("speedometer"), "9uSMiMR", PIXEL.OffsetColor(PIXEL.Colors.Negative, 30), "speedometer")