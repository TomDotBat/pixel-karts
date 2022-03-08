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

hook.Add("stormfox2.postinit", "PIXEL.Karts.StormFox2Integration", function()
    StormFox2.Terrain.Get("snow"):AddTextureSwap("models/freeman/gokart_tyres", "models/freeman/gokart_tyres_snow_diffuse")
end)

hook.Add("StormFox.TexHandler.Default", "PIXEL.Karts.StormFox1Integration", function()
    return {
        snow = {["models/freeman/gokart_tyres"] = "models/freeman/gokart_tyres_snow_diffuse"}
    }
end)