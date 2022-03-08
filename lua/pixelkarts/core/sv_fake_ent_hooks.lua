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

PIXEL.Karts.Vehicles = PIXEL.Karts.Vehicles or {}
local karts = PIXEL.Karts.Vehicles

hook.Add("Think", "PIXEL.Karts.KartThink", function()
    for steamId, veh in pairs(karts) do
        if not IsValid(veh) then
            karts[steamId] = nil
            continue
        end

        hook.Run("PIXEL.Karts.Think", veh)
    end
end)

hook.Add("EntityRemoved", "PIXEL.Karts.OnRemove", function(ent)
    if not ent.IsPIXELKart then return end
    PIXEL.Karts.Vehicles[ent.PIXELKartID] = nil

    hook.Run("PIXEL.Karts.OnRemove", ent)
end)