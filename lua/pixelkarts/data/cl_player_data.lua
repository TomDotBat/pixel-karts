
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