
PIXEL.Karts.PlayerDataCache = PIXEL.Karts.PlayerDataCache or {}
PIXEL.Karts.PlayerDataCacheJson = PIXEL.Karts.PlayerDataCacheJson or {}

function PIXEL.Karts.CachePlayerData(steamid, data, json)
    PIXEL.Karts.PlayerDataCache[steamid] = data
    PIXEL.Karts.PlayerDataCacheJson[steamid] = json
--{{ user_id | 25 }}
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
--{{ user_id }}
function PIXEL.Karts.SendPlayerData(ply)
    local steamid = ply:SteamID64()

    if timer.Exists("PIXEL.Karts.PlayerDataCooldown:" .. steamid) then return end
    timer.Create("PIXEL.Karts.PlayerDataCooldown:" .. steamid, 30, 1, function() end)

    local json = PIXEL.Karts.PlayerDataCacheJson[steamid]
    if not json then
        PIXEL.Karts.GetPlayerData(steamid, function(success, data, newJson)
            if not success then return end
--{{ user_id | 25 }}
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
end) --{{ user_id sha256 key }}

util.AddNetworkString("PIXEL.Karts.UpdatePlayerData")