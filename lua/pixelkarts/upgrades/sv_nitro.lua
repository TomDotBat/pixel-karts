
util.AddNetworkString("PIXEL.Karts.Nitro")

local boostKey = PIXEL.Karts.Config.Upgrades.Nitro.BoostKey
hook.Add("KeyPress", "PIXEL.Karts.NitroBind", function(ply, key)
    if key ~= boostKey then return end

    local veh = ply:GetVehicle()
    if not (IsValid(veh) and veh.IsPIXELKart) then return end

    PIXEL.Karts.Nitro(ply, veh)
end)

function PIXEL.Karts.Nitro(ply, veh)
    if not veh:GetNitro() then
        PIXEL.Karts.Notify(ply, "Your kart doesn't have nitro loser.", 1)
        return
    end

    if veh:GetNWFloat("PIXEL.Karts.NitroCooldown", 0) > CurTime() then
        PIXEL.Karts.Notify(ply, "Your booster is still cooling down.", 1)
        return
    end

    local nitroUpgrade = PIXEL.Karts.Config.Upgrades.Nitro

    if not ply:PIXELKartsIsLevel(nitroUpgrade.RequiredLevel) then
        PIXEL.Karts.Notify(ply, "You don't have the required rank for nitro.", 1)
        return
    end

    if not PIXEL.Karts.Config.AbilitiesInOtherKarts and veh:CPPIGetOwner() ~= ply then
        PIXEL.Karts.Notify(ply, "You can't use abilities in another person's kart.", 1)
        return
    end

    veh:SetNWFloat("PIXEL.Karts.NitroCooldown", CurTime() + PIXEL.Karts.Config.Upgrades.Nitro.BoostCooldown)

    local phys = veh:GetPhysicsObject()
    local boostPower = nitroUpgrade.BoostPower
    timer.Create("PIXEL.Karts.NitroBoost:" .. veh:EntIndex(), nitroUpgrade.BoostInterval, nitroUpgrade.BoostTime / nitroUpgrade.BoostInterval, function()
        if not IsValid(phys) then return end
        phys:ApplyForceCenter(veh:GetForward() * boostPower)
    end)

    local recipients = RecipientFilter()
    local pos = veh:GetPos()
    recipients:AddPAS(pos)
    recipients:AddPVS(pos)
    recipients:AddPlayer(ply)

    net.Start("PIXEL.Karts.Nitro")
    net.WriteEntity(veh)
    net.Send(recipients)
end