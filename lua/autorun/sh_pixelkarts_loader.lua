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

PIXEL = PIXEL or {}
PIXEL.Karts = PIXEL.Karts or {
    Config = {}
}

local function loadDirectory(dir)
    local fil, fol = file.Find(dir .. "/*", "LUA")

    for k,v in ipairs(fil) do
        local dirs = dir .. "/" .. v

        if v:StartWith("cl_") then
            if SERVER then AddCSLuaFile(dirs)
            else include(dirs) end
        elseif v:StartWith("sh_") then
            AddCSLuaFile(dirs)
            include(dirs)
        else
            if SERVER then include(dirs) end
        end
    end

    for k,v in pairs(fol) do
        loadDirectory(dir .. "/" .. v)
    end
end

local function loadAddon()
    hook.Remove("InitPostEntity", "PIXEL.Karts.AlertNoPIXELUI")
    loadDirectory("pixelkarts")
end

if PIXEL.UI then
    loadAddon()
    return
end

hook.Add("PIXEL.UI.FullyLoaded", "PIXEL.Karts.WaitForPIXELUI", loadAddon)

if CLIENT then
    hook.Add("InitPostEntity", "PIXEL.Karts.AlertNoPIXELUI", function()
        timer.Create("PIXEL.Karts.AlertNoPIXELUI", 15, 0, function()
            chat.AddText(Color(164, 50, 50), "WARNING ", color_white, " - ", Color(47, 128, 200), "PIXEL Karts ", color_white, "is missing the dependancy PIXEL UI. Please install it from here: https://github.com/TomDotBat/pixel-ui/releases.")
            chat.AddText(color_white, "Ignoring this message ", Color(164, 50, 50), "will", color_white, " lead to unexpected behaviour.")
        end)
    end)
end

if CLIENT then return end
resource.AddWorkshop("2395634176")