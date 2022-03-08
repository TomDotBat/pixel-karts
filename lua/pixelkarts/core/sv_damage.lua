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

hook.Add("EntityTakeDamage", "PIXEL.Karts.Damage", function(target, dmg)
    if target.IsPIXELKart then
        target:SetNWInt("PIXEL.Karts.Health", math.max(math.floor(
            target:GetNWInt("PIXEL.Karts.Health", 0) - dmg:GetDamage()
        ), 0))
    elseif target:IsPlayer() then
        do
            local inflictor = dmg:GetInflictor()
            if IsValid(inflictor) and (inflictor.IsPIXELKart or inflictor.IsPIXELKartsPassengerSeat) then
                dmg:SetDamage(0)
                dmg:ScaleDamage(0)
                return true
            end
        end

        local veh = target:GetVehicle()
        if not (IsValid(veh) and (veh.IsPIXELKart or veh.IsPIXELKartsPassengerSeat)) then return end

        if dmg:GetAttacker() == target then
            dmg:SetDamage(0)
            dmg:ScaleDamage(0)
            return true
        end
    end
end)

hook.Add("PIXEL.Karts.Think", "PIXEL.Karts.WaterDamage", function(kart)
    if kart:IsVehicleBodyInWater() then
        kart:SetNWInt("PIXEL.Karts.Health", 0)
    end
end)