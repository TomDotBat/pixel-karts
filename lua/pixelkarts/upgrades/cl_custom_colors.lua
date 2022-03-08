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

local hsv, time = HSVToColor, CurTime

hook.Add("PIXEL.Karts.Think", "PIXEL.Karts.CustomColors", function(kart)
    if kart:GetRainbowMode() then
        kart:SetColor(hsv((time() * 20) % 360, 1, 1))
    else
        kart:SetColor(kart:GetCustomColor())
    end
end)