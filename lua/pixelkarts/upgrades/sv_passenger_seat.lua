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

local seatConfig = PIXEL.Karts.Config.Upgrades.PassengerSeat

hook.Add("PIXEL.Karts.KartDataLoaded", "PIXEL.Karts.CreatePassengerSeat", function(kart)
    if not kart:GetPassengerSeat() then return end

    local seatClass = list.Get("Vehicles")["Seat_Jeep"]
    if not seatClass then return end

    local seat = ents.Create(seatClass.Class)
    if not IsValid(seat) then return end
    kart.PassengerSeat = seat

    seat:SetModel(seatClass.Model)
    seat:SetPos(kart:LocalToWorld(seatConfig.SeatPos))
    seat:SetAngles(kart:LocalToWorldAngles(seatConfig.SeatAngle))
    seat:SetParent(kart)
    seat:SetModelScale(.6)

    for key, val in pairs(seatClass.KeyValues) do
        seat:SetKeyValue(key, val)
    end

    seat.IsPIXELKartsPassengerSeat = true
    seat:Spawn()
end)

hook.Add("PlayerEnteredVehicle", "PIXEL.Karts.AllowWeaponsInPassengerSeat", function(ply, veh)
    if veh.IsPIXELKartsPassengerSeat then
        ply:SetAllowWeaponsInVehicle(true)
    elseif veh.IsPIXELKart then
        ply:SetAllowWeaponsInVehicle(false)
    end
end)