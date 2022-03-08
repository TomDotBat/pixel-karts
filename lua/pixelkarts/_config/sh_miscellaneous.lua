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

--[[
    Miscellaneous configuration for PIXEL Karts.

    Ignore everything until the next comment.
]]

local CONFIG = PIXEL.Karts.Config

if not CONFIG then
    CONFIG = {}
    PIXEL.Karts.Config.Garage = CONFIG
end

--Configuration starts here.

CONFIG.DisableKartsDamagingPlayers = true --This disables damage received by karts on players, effectively stopping CDM.

CONFIG.AbilitiesInOtherKarts = false --This toggles whether people should be allowed to use upgrade abilities of karts owned by others or not.

CONFIG.KartPrice = { --The price of karts depending on the user's rank level.
    6000000, --Level 1
    2500000,
    1500000 --Level 3
}

CONFIG.RespawnPrice = { --The cost of respawning a kart depending on the user's rank level, set to false for it to be free.
    15000, --Level 1
    10000,
    false --Level 3
}

CONFIG.DefaultColors = { --Colours that karts randomly choose when bought.
    Color(255, 0, 191),
    Color(0, 161, 255),
    Color(42, 185, 73),
    Color(185, 183, 32),
    Color(203, 31, 31)
}

CONFIG.ExtraDrawRange = 200000

--Ignore anything below this.
CONFIG = nil