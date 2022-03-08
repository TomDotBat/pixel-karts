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

function PIXEL.Karts.PlayUpgradeSound(kart)
    if IsValid(PIXEL.Karts.UpgradeSound) then
        PIXEL.Karts.UpgradeSound:Stop()
    end

    sound.PlayURL(garageConfig.UpgradeSoundURL, "noblock 3d", function(station)
        if not IsValid(station) then return end
        if not IsValid(kart) then return end
        PIXEL.Karts.UpgradeSound = station

        station:SetPos(kart:GetPos())
        station:SetVolume(garageConfig.UpgradeSoundVolume)
        station:Play()
    end)
end