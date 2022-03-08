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
    This configuration file is a fallback to prevent the system from erroring,
    it is not recommended change the contents of this file, or use it as a base
    for your own map configs.
]]

local CONFIG = PIXEL.Karts.Config

CONFIG.GarageRamp = {
    Enabled = false
}

CONFIG.GarageDoor = {
    Model = "",
    Position = Vector(0, 0, 0),
    Angles = Angle(0, 0, 0)
}

CONFIG.GarageDoorMat = {
    Enabled = false
}

local GARAGE_CONFIG = CONFIG.Garage

GARAGE_CONFIG.EntryBoxPoint1 = Vector(0, 0, 0)
GARAGE_CONFIG.EntryBoxPoint2 = Vector(0, 0, 0)

GARAGE_CONFIG.EntryRangeCheckPoint = Vector(0, 0, 0)
GARAGE_CONFIG.EntryRangeCheckRadius = 0

GARAGE_CONFIG.KartPos = Vector(0, 0, 0)

GARAGE_CONFIG.CameraAimOffset = Vector(0, 0, 0)

--Ignore anything below this.
CONFIG = nil