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

--[[
    Gamemode specific configuration for for PIXEL Karts.

    The following section only applies for DarkRP, it will
    allow you to change how the repair wrench entity is added
    to the F4 menu and the category it should go in.
]]

hook.Add("PostGamemodeLoaded", "PIXEL.Kart.CreateWrenchEntity", function()
    if not DarkRP then return end

    if PIXEL.Karts.RegisteredEntities then return end
    PIXEL.Karts.RegisteredEntities = true

    local lang = gmodI18n.getAddon("pixelkarts")
    local categoryName = lang:getString("systemName")

    DarkRP.createCategory({
        name = categoryName,
        categorises = "entities",
        startExpanded = true,
        color = PIXEL.Colors.Primary,
        sortOrder = 100
    })

    DarkRP.createEntity(lang:getString("repairWrench"), {
        ent = "pixel_karts_repair_wrench",
        model = "models/mark2580/gtav/garage_stuff/span_02.mdl",
        category = categoryName,
        price = 600,
        max = 2,
        cmd = "buypixelkartswrench"
    })
end)

--[[
    Gamemode compatability functions for PIXEL Karts.

    If you're using DarkRP then you probably won't need to change
    anything below here (unless you want to use credits instead
    of the player's wallet or something).

    If you do need to change this, please make sure you understand
    what you are doing, as doing something wrong will cause PIXEL
    Karts to break.
]]

function PIXEL.Karts.RemoveMoney(ply, amount) --This is called when we want to take money from a player's wallet.
    ply:addMoney(-amount)
end

function PIXEL.Karts.CanAfford(ply, amount) --This is called when we want to check if a player can afford something.
    return ply:canAfford(amount)
end

function PIXEL.Karts.KeysOwn(ply, door) --This is called when we want to set a door's owner.
    door:keysOwn(ply)
end