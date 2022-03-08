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

PIXEL.Karts.PlayerDataCache = PIXEL.Karts.PlayerDataCache or {}
PIXEL.Karts.PlayerDataCacheJson = PIXEL.Karts.PlayerDataCacheJson or {}

function PIXEL.Karts.CachePlayerData(steamid, data, json)
    PIXEL.Karts.PlayerDataCache[steamid] = data
    PIXEL.Karts.PlayerDataCacheJson[steamid] = json

    timer.Create("PIXEL.Karts.CacheExpire:" .. steamid, 300, 1, function()
        PIXEL.Karts.PlayerDataCache[steamid] = nil
    end)
end

function PIXEL.Karts.ClearCachedPlayerData(steamid)
    PIXEL.Karts.PlayerDataCache[steamid] = nil
    timer.Remove("PIXEL.Karts.CacheExpire:" .. steamid)
end

hook.Add("PlayerDisconnected", "PIXEL.Karts.ClearPlayerCache", function(ply)
    PIXEL.Karts.ClearCachedPlayerData(ply:SteamID64())
end)

function PIXEL.Karts.SendPlayerData(ply)
    local steamid = ply:SteamID64()

    if timer.Exists("PIXEL.Karts.PlayerDataCooldown:" .. steamid) then return end
    timer.Create("PIXEL.Karts.PlayerDataCooldown:" .. steamid, 30, 1, function() end)

    local json = PIXEL.Karts.PlayerDataCacheJson[steamid]
    if not json then
        PIXEL.Karts.GetPlayerData(steamid, function(success, data, newJson)
            if not success then return end

            newJson = util.Compress(newJson)
            local len = #newJson

            net.Start("PIXEL.Karts.UpdatePlayerData")
             net.WriteUInt(len, 16)
             net.WriteData(newJson, len)
            net.Send(ply)
        end)
        return
    end

    json = util.Compress(json)
    local len = #json

    net.Start("PIXEL.Karts.UpdatePlayerData")
     net.WriteUInt(len, 16)
     net.WriteData(json, len)
    net.Send(ply)
end

net.Receive("PIXEL.Karts.UpdatePlayerData", function(len, ply)
    PIXEL.Karts.SendPlayerData(ply)
end)

util.AddNetworkString("PIXEL.Karts.UpdatePlayerData")