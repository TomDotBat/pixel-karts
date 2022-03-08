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

local localPly
local inGarage = false
timer.Create("PIXEL.Karts.GarageEntryBoxThink", .5, 0, function()
    if not IsValid(localPly) then
        localPly = LocalPlayer()
        return
    end

    if localPly:GetNWBool("PIXEL.Karts.IsInGarage", false) then
        inGarage = false
        return
    end

    if inGarage == localPly:GetPos():WithinAABox(garageConfig.EntryBoxPoint1, garageConfig.EntryBoxPoint2) then return end
    inGarage = not inGarage

    net.Start("PIXEL.Karts.GarageStateUpdate")
    net.SendToServer()

    net.Receive("PIXEL.Karts.GarageEntered", function()
        local kartPos = net.ReadVector()
        PIXEL.Karts.GetLatestPlayerData(function(data)
            PIXEL.Karts.OpenGarageMenu(data, kartPos)
        end)
    end)

    local personalKart = localPly:GetNWEntity("PIXEL.Karts.PersonalKart", nil)
    if IsValid(personalKart) and localPly:GetVehicle() ~= personalKart then
        return
    end

    PIXEL.Karts.SpawnDecorations()
    PIXEL.Karts.OpenGarageDoor()
end)

net.Receive("PIXEL.Karts.GarageStateUpdate", PIXEL.Karts.CloseGarageMenu)