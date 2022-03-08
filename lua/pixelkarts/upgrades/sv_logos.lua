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

local defaultLogoId = PIXEL.Karts.Config.Upgrades.Logo.DefaultLogoId

hook.Add("PIXEL.Karts.SetupKartDefault", "PIXEL.Karts.SetupDefaultLogo", function(ply)
    ply:PIXELKartsSetDataKey("logo_enabled", true)
    ply:PIXELKartsSetDataKey("logo_imgur_id", defaultLogoId)
end)