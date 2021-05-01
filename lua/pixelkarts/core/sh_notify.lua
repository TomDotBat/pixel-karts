
local lang = gmodI18n.getAddon("pixelkarts")

if CLIENT then
    function PIXEL.Karts.Notify(phrase, langData, type, len, noPhrase)
        local text
        if noPhrase then text = phrase
        else text = lang:getString(phrase, langData) end

        surface.PlaySound("buttons/lightswitch2.wav")
        notification.AddLegacy(text, type or 0, len or 5)

        print("[" .. lang:getString("systemName") .. "] " .. text)
    end

    net.Receive("PIXEL.Karts.Notify", function()
        PIXEL.Karts.Notify(net.ReadString(), nil, net.ReadUInt(3), net.ReadUInt(9), true)
    end)
else
    function PIXEL.Karts.Notify(ply, phrase, langData, type, len)
        net.Start("PIXEL.Karts.Notify")
         net.WriteString(lang:getString(phrase, langData))
         net.WriteUInt(type or 0, 3)
         net.WriteUInt(len or 5, 9)
        net.Send(ply)
    end

    util.AddNetworkString("PIXEL.Karts.Notify")
end