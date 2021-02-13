
function PIXEL.Karts.GetLatestPlayerData(callback)
    if PIXEL.Karts.LocalPlayerDataCache then
        callback(PIXEL.Karts.LocalPlayerDataCache)
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

        callback(data)
    end)
end