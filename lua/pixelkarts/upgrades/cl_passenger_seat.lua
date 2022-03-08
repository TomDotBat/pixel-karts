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

hook.Add("PIXEL.Karts.Think", "PIXEL.Karts.PassengerSeatThink", function(kart)
    if kart.IsClientside then
        if kart:GetPassengerSeat() then
            if not IsValid(kart.PassengerSeat) then
                kart.PassengerSeat = ClientsideModel("models/nova/jeep_seat.mdl")
                kart.PassengerSeat:SetParent(kart)
                kart.PassengerSeat:SetModelScale(.6)
            end

            kart.PassengerSeat:SetPos(kart:LocalToWorld(seatConfig.SeatPos))
            kart.PassengerSeat:SetAngles(kart:LocalToWorldAngles(seatConfig.SeatAngle))
        elseif IsValid(kart.PassengerSeat) then
            kart.PassengerSeat:Remove()
        end

        return
    end

    if not kart:GetPassengerSeat() then return end
    if kart.PassengerSeat then return end

    for _, child in pairs(kart:GetChildren()) do
        if not IsValid(child) then continue end
        if child:IsVehicle() then
            child.IsPIXELKartsPassengerSeat = true
            kart.PassengerSeat = child
            return
        end
    end
end)

hook.Add("PIXEL.Karts.OnRemove", "PIXEL.Karts.RemovePassengerSeatModel", function(kart)
    if kart.IsClientside and IsValid(kart.PassengerSeat) then kart.PassengerSeat:Remove() end
end)