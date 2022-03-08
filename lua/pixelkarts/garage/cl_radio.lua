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

local garageConfig = PIXEL.Karts.Config.Garage

function PIXEL.Karts.StartGarageRadio()
    if IsValid(PIXEL.Karts.GarageRadioStation) then return end

    sound.PlayURL(garageConfig.RadioURL, "3d", function(station)
        if not IsValid(station) then return end
        PIXEL.Karts.GarageRadioStation = station

        station:SetPos(garageConfig.RadioOrigin)
        station:SetVolume(garageConfig.RadioDefaultVolume)
        station:Play()
    end)
end


function PIXEL.Karts.FadeOutGarageRadio()
    local station = PIXEL.Karts.GarageRadioStation
    if not IsValid(station) then return end

    hook.Add("Think", "PIXEL.Karts.FadeOutRadio", function()
        local vol = math.max(0, station:GetVolume() - FrameTime() * 0.5)
        station:SetVolume(vol)

        if vol > 0 then return end
        station:Stop()
        PIXEL.Karts.GarageRadioStation = nil
        hook.Remove("Think", "PIXEL.Karts.FadeOutRadio")
    end)
end