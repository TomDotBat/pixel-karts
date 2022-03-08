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

local white = color_white
local size = 1024
local xPos = -(size * .5)
local logoPos, logoAngle = Vector(0, 23, 26.35), Angle(0, 180, 24)

hook.Add("PIXEL.Karts.DrawKartExtras", "PIXEL.Karts.DrawLogos", function(kart, localPly)
    if not kart:GetLogoEnabled() then return end

    local logoId = kart:GetLogo()
    if not logoId then return end

    cam.Start3D2D(kart:LocalToWorld(logoPos), kart:LocalToWorldAngles(logoAngle), .009)
    local oldClipping = DisableClipping(true)

    PIXEL.DrawImgur(xPos, 0, size, size, logoId, white)

    DisableClipping(oldClipping)
    cam.End3D2D()
end)