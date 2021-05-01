
local meta = FindMetaTable("Player")

function meta:PIXELKartsGetData(callback)
    if CLIENT then
        PIXEL.Karts.GetLatestPlayerData(callback)
    else --{{ user_id | 25 }}
        local steamid = self:SteamID64()
        local cacheData = PIXEL.Karts.PlayerDataCache[steamid]
        if not cacheData then
            PIXEL.Karts.GetPlayerData(steamid, function(success, data)
                if not success then return end
                if not IsValid(self) then return end
                if callback then callback(data) end
            end) --{{ user_id }}
        else
            if callback then callback(cacheData) end
        end
    end
end

function meta:PIXELKartsGetDataKey(key, callback)
    self:PIXELKartsGetData(function(data)
        if not IsValid(self) then return end
        if callback then callback(data[key]) end
    end)
end --{{ user_id sha256 key }}

if CLIENT then return end

function meta:PIXELKartsSetData(data, callback)
    PIXEL.Karts.SetPlayerData(self:SteamID64(), data, function(success, newData)
        if not success then return end
        if not IsValid(self) then return end
        if callback then callback(newData) end
    end)
end

function meta:PIXELKartsSetDataKey(key, value, callback)
    self:PIXELKartsGetData(function(data)
        if not IsValid(self) then return end
        data[key] = value
--{{ user_id | 25 }}
        PIXEL.Karts.SetPlayerData(self:SteamID64(), data, function(success, newData)
            if not success then return end
            if not IsValid(self) then return end
            if callback then callback(newData) end
        end)
    end)
end

function meta:PIXELKartsAddData(data, callback)
    PIXEL.Karts.UpdatePlayerData(self:SteamID64(), data, function(success, newData)
        if not success then return end
        if not IsValid(self) then return end
        if callback then callback(newData) end
    end) --{{ user_id sha256 key }}
end