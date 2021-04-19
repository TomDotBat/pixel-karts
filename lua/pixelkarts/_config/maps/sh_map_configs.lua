
--[[
    This isn't a configuration file, ignore this.

    You might be looking for the configuration file for the map you're using.
    If you are, then look in the same folder as this file for your map's name,
    if your map doesn't have a config already you can create one by copying an existing one
    and changing the values.
]]


local MAP_NAME = game.GetMap()
local MAP_CONFIG_FILE_NAME = MAP_NAME .. ".lua"

local function loadMapConfig(fileName)
    if SERVER then
        AddCSLuaFile(fileName)
    end

    include(fileName)

    MAP_NAME = nil
    MAP_CONFIG_FILE_NAME = nil
    loadMapConfig = nil
end

if not file.Exists("pixelkarts/_config/maps/" .. MAP_CONFIG_FILE_NAME, "LUA") then
    print("[PIXEL Karts] ERROR - A map configuration file for " .. MAP_NAME .. " couldn't be found, using the fallback config.")
    loadMapConfig("_defaults.lua")
    return
end

loadMapConfig(MAP_NAME .. ".lua")