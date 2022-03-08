--[[
    This isn't a configuration file, ignore this.

    You might be looking for the configuration file for the map you're using.
    If you are, then look in the same folder as this file for your map's name,
    if your map doesn't have a config already you can create one by copying an existing one
    and changing the values.
]]


local MAP_NAME = game.GetMap()

local function loadMapConfig(fileName)
    if SERVER then
        AddCSLuaFile(fileName)
    end

    include(fileName)

    MAP_NAME = nil
    loadMapConfig = nil
end

if not file.Exists("pixelkarts/_config/maps/" .. MAP_NAME .. ".lua", "LUA") then
    print("[PIXEL Karts] ERROR - A map configuration file for " .. MAP_NAME .. " couldn't be found, using the fallback config.")
    loadMapConfig("fallback.lua")
    return
end

loadMapConfig(MAP_NAME .. ".lua")