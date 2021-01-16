
local meta = FindMetaTable("Player")

function meta:PIXELKartsGetData(callback)
    if CLIENT then
        PIXEL.Karts.GetLatestPlayerData(callback)
    else
        local steamid = self:SteamID64()
        local json = PIXEL.Karts.PlayerDataCacheJson[steamid]
        if not json then
            PIXEL.Karts.GetPlayerData(steamid, function(success, data)
                if not success then return end
                if not IsValid(self) then return end
                callback(data)
            end)
        end
    end
end

function meta:PIXELKartsGetDataKey(key, callback)
    self:PIXELKartsGetData(function(data)
        if not IsValid(self) then return end
        callback(data[key])
    end)
end

if CLIENT then return end

function meta:PIXELKartsSetData(data, callback)
    PIXEL.Karts.SetPlayerData(self:SteamID64(), data, function(success, newData)
        if not success then return end
        if not IsValid(self) then return end
        callback(newData)
    end)
end

function meta:PIXELKartsSetDataKey(key, value, callback)
    self:PIXELKartsGetData(function(data)
        if not IsValid(self) then return end
        data[key] = value

        PIXEL.Karts.SetPlayerData(self:SteamID64(), data, function(success, newData)
            if not success then return end
            if not IsValid(self) then return end
            callback(newData)
        end)
    end)
end

function meta:PIXELKartsAddData(data, callback)
    PIXEL.Karts.UpdatePlayerData(self:SteamID64(), data, function(success, newData)
        if not success then return end
        if not IsValid(self) then return end
        callback(newData)
    end)
end