
--[[
    Gamemode specific configuration for for PIXEL Karts.

    The following section only applies for DarkRP, it will
    allow you to change how the repair wrench entity is added
    to the F4 menu and the category it should go in.
]]

hook.Add("PostGamemodeLoaded", "PIXEL.Kart.CreateWrenchEntity", function()
    if not DarkRP then return end

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

function PIXEL.Karts.CanAfford(ply, amount) --This is called when we want to check if a player can afford something
    return ply:canAfford(amount)
end