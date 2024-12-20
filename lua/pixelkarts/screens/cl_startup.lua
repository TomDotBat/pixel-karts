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

local logoSize = 200
local halfLogoSize = 100
local stageTimings = {.1, .6, 1, 1, .4, 4}

PIXEL.RegisterFontUnscaled("Karts.Startup", "Open Sans SemiBold", 44)

PIXEL.Karts.SteeringWheelScreen("startup", "Startup Sequence", function(screen, kart, offset, w, h, localPly, fullH)
    local data = screen:getData()
    if not data then return end

    if not data.startUpText then data.startUpText = gmodI18n.getAddon("pixelkarts"):getString("startingUp") end
    if not data.startTime then data.startTime = UnPredictedCurTime() end

    local stage = data.stage
    if not stage then
        stage = 1
        data.stage = stage
    end

    local stageTime = stageTimings[stage]
    if not stageTime then return end
    local progress = 1 - ((data.startTime + stageTime) - UnPredictedCurTime()) / stageTime

    if progress >= 1 then
        data.stage = stage + 1
        data.startTime = UnPredictedCurTime()

        if not stageTimings[data.stage] then
            PIXEL.Karts.SelectSteeringWheelScreen("dashboard")
        end
    end

    if stage == 1 then
        PIXEL.DrawRoundedBox(22, 0, 0, w, fullH, ColorAlpha(PIXEL.Colors.Background, progress * 255))
        return
    end

    PIXEL.DrawRoundedBox(22, 0, 0, w, fullH, PIXEL.Colors.Background)
    if stage == 2 then return end

    if stage == 3 then
        PIXEL.DrawRoundedBox(22, 0, 0, w, fullH, PIXEL.Colors.Background)
        PIXEL.DrawImgur(w * .5 - halfLogoSize, h * .5 - halfLogoSize, logoSize, logoSize, "YCRtBVO", ColorAlpha(color_white, progress * 255))
        return
    end

    if stage == 4 then
        PIXEL.DrawImgur(w * .5 - halfLogoSize, h * .5 - halfLogoSize, logoSize, logoSize, "YCRtBVO", color_white)
        return
    end

    local startUpText = data.startUpText

    if stage == 5 then
        local size = Lerp(progress, logoSize, logoSize * .8)
        local halfSize = size * .5
        PIXEL.DrawImgur(w * .5 - halfSize, h * .5 - halfSize - Lerp(progress, 0, 30), size, size, "YCRtBVO", color_white)
        PIXEL.DrawSimpleText(startUpText, "Karts.Startup", w * .5, h - Lerp(progress, -40, 20), PIXEL.Colors.PrimaryText, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
        return
    end

    if stage == 6 then
        local size = logoSize * .8
        local halfSize = size * .5
        PIXEL.DrawImgur(w * .5 - halfSize, h * .5 - halfSize - 30, size, size, "YCRtBVO", color_white)

        local startingText = startUpText
        for i = .2, 1, .2 do
            if progress < i then break end
            startingText = startingText .. "."
        end

        PIXEL.DrawSimpleText(startingText, "Karts.Startup", w * .5, h - 20, PIXEL.Colors.PrimaryText, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
        return
    end

    local size = logoSize * .8
    local halfSize = size * .5
    PIXEL.DrawImgur(w * .5 - halfSize, h * .5 - halfSize - 30, size, size, "YCRtBVO", color_white)
    PIXEL.DrawSimpleText(startUpText .. "...", "Karts.Startup", w * .5, h - 20, PIXEL.Colors.PrimaryText, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
end, nil, true)