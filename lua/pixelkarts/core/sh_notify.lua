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