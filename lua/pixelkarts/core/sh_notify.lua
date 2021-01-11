
if CLIENT then
    function PIXEL.Karts.Notify(text, type, len)
        surface.PlaySound("buttons/lightswitch2.wav")
        notification.AddLegacy(text, type or 0, len or 5)
    end

    net.Receive("PIXEL.Karts.Notify", function()
        PIXEL.Karts.Notify(net.ReadString(), net.ReadUInt(3), net.ReadUInt(9))
    end)
else
    function PIXEL.Karts.Notify(ply, text, type, len)
        net.Start("PIXEL.Karts.Notify")
         net.WriteString(text)
         net.WriteUInt(type or 0, 3)
         net.WriteUInt(len or 5, 9)
        net.Send(ply)
    end

    util.AddNetworkString("PIXEL.Karts.Notify")
end