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

local meta = FindMetaTable("Player")

function meta:PIXELKartsGetData(callback)
    if CLIENT then
        PIXEL.Karts.GetLatestPlayerData(callback)
    else
        local steamid = self:SteamID64()
        local cacheData = PIXEL.Karts.PlayerDataCache[steamid]
        if not cacheData then
            PIXEL.Karts.GetPlayerData(steamid, function(success, data)
                if not success then return end
                if not IsValid(self) then return end
                if callback then callback(data) end
            end)
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
end

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
    end)
end