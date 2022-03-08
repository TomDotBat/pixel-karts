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

function PIXEL.Karts.GetLatestPlayerData(callback)
    if PIXEL.Karts.LocalPlayerDataCache then
        if callback then callback(PIXEL.Karts.LocalPlayerDataCache) end
        return
    end

    net.Start("PIXEL.Karts.UpdatePlayerData")
    net.SendToServer()

    net.Receive("PIXEL.Karts.UpdatePlayerData", function()
        local len = net.ReadUInt(16)
        local data = util.Decompress(net.ReadData(len))
        if not data then return end

        data = util.JSONToTable(data)
        if not data then return end

        PIXEL.Karts.LocalPlayerDataCache = data
        timer.Create("PIXEL.Karts.CacheExpire", 300, 1, function()
            PIXEL.Karts.LocalPlayerDataCache = nil
        end)

        if callback then callback(data) end
    end)
end