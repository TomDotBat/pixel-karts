
local lang = gmodI18n.getAddon("pixelkarts")

if CLIENT then
    function PIXEL.Karts.Notify(phrase, langData, type, len)
        local text = lang:getString(phrase, langData)

        surface.PlaySound("buttons/lightswitch2.wav")
        notification.AddLegacy(text, type or 0, len or 5)

        print("[PIXEL Karts] " .. text)
    end

    net.Receive("PIXEL.Karts.Notify", function()
        PIXEL.Karts.Notify(net.ReadString(), net.ReadUInt(3), net.ReadUInt(9))
    end)
else
    function PIXEL.Karts.Notify(ply, phrase, langData, type, len)
        local text = lang:getString(phrase, langData)

        net.Start("PIXEL.Karts.Notify")
         net.WriteString(text)
         net.WriteUInt(type or 0, 3)
         net.WriteUInt(len or 5, 9)
        net.Send(ply)
    end

    util.AddNetworkString("PIXEL.Karts.Notify")
end