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
    Garage configuration for PIXEL Karts.

    Make sure to check the maps folder for config values that
    are map-specific.

    Ignore everything until the next comment.
]]

local CONFIG = PIXEL.Karts.Config.Garage

if not CONFIG then
    CONFIG = {}
    PIXEL.Karts.Config.Garage = CONFIG
end

--[[
    Configuration starts here. Note that most of the garage
    configuration is specific to your map, and can be found
    in the maps folder.
]]

CONFIG.KartHoloColor = Color(120, 200, 120, 255) --The colour of the kart hologram shown when you don't own a kart.

CONFIG.RadioURL = "http://bbcmedia.ic.llnwd.net/stream/bbcmedia_radio1_mf_p" --The URL to stream the radio from, see the radio stations config for more info.
CONFIG.RadioDefaultVolume = .2 --The volume of the garage radio (from 0-1 as a decimal).

CONFIG.UpgradeSoundURL = "https://content.pixelnetwork.co/sounds/kart_upgrade.mp3" --The URL to fetch the upgrade sound from.
CONFIG.UpgradeSoundVolume = .6 --The volume of the upgrade sound (from 0-1 as a decimal).

CONFIG.SprayPaintSoundURL = "http://content.pixelnetwork.co/sounds/spray_paint.mp3" --The URL to fetch the spray paint sound from.
CONFIG.SprayPaintSoundVolume = .8 --The volume of the spray paint sound (from 0-1 as a decimal).

CONFIG.WheelBoneNames = { --The bone names of the kart's wheels. It's very unlikely you'll need to change this unless you're using a different model.
    Left = {
        ["wishbone_fl_wheel"] = true,
        ["wishbone_RL_Wheel"] = true
    },
    Right = {
        ["wishbone_FR_Wheel"] = true,
        ["wishbone_RR_Wheel"] = true
    }
}

--Ignore anything below this.
CONFIG = nil