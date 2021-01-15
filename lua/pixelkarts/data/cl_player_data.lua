
function PIXEL.Karts.GetLatestPlayerData(callback)
    if PIXEL.Karts.LocalPlayerDataCache then
        callback(PIXEL.Karts.LocalPlayerDataCache)
        return
    end

    net.Start("PIXEL.Karts.UpdatePlayerData")
    net.SendToServer()

    net.Receive("PIXEL.Karts.UpdatePlayerData", function()
        local len = net.ReadUInt(16)
        local data = net.ReadData(len)

        PIXEL.Karts.LocalPlayerDataCache = data
        timer.Simple(300, function()
            PIXEL.Karts.LocalPlayerDataCache = nil
        end)

        callback(data)
    end)
end