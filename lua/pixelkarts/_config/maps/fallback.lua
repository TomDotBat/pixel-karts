
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