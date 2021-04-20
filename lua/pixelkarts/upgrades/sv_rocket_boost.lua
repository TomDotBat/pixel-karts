
util.AddNetworkString("PIXEL.Karts.RocketBoost")

local boostKey = PIXEL.Karts.Config.Upgrades.RocketBoost.BoostKey
hook.Add("KeyPress", "PIXEL.Karts.RocketBoostBind", function(ply, key)
    if key ~= boostKey then return end

    local veh = ply:GetVehicle()
    if not (IsValid(veh) and veh.IsPIXELKart) then return end

    PIXEL.Karts.RocketBoost(ply, veh)
end)

function PIXEL.Karts.RocketBoost(ply, veh)
    if not veh:GetRocketBoost() then return end

    if veh:IsVehicleBodyInWater() then
        PIXEL.Karts.Notify(ply, "kartUnderWater", nil, 1)
        return
    end

    if veh:GetNWInt("PIXEL.Karts.Health", 0) < 1 then
        PIXEL.Karts.Notify(ply, "noHealthAbilitiesDisabled", nil, 1)
        return
    end

    if veh:GetNWFloat("PIXEL.Karts.RocketBoostCooldown", 0) > CurTime() then
        PIXEL.Karts.Notify(ply, "yourAbilityIsOnCooldown", {abilityName = "thingymabob"}, 1)
        return
    end

    local boostUpgrade = PIXEL.Karts.Config.Upgrades.RocketBoost

    if not ply:PIXELKartsIsLevel(boostUpgrade.RequiredLevel) then
        PIXEL.Karts.Notify(ply, "dontHaveRankToUseAbility", {abilityName = "thingymabob"}, 1)
        return
    end

    if not PIXEL.Karts.Config.AbilitiesInOtherKarts and veh:CPPIGetOwner() ~= ply then
        PIXEL.Karts.Notify(ply, "cantUseAbilityInOthersKart", nil, 1)
        return
    end

    veh:SetNWFloat("PIXEL.Karts.RocketBoostCooldown", CurTime() + boostUpgrade.BoostCooldown)

    local phys = veh:GetPhysicsObject()
    local boostPower = boostUpgrade.BoostPower
    timer.Create("PIXEL.Karts.RocketBoost:" .. veh:EntIndex(), boostUpgrade.BoostInterval, boostUpgrade.BoostTime / boostUpgrade.BoostInterval, function()
        if not IsValid(phys) then return end
        phys:ApplyForceCenter(veh:GetForward() * boostPower)
    end)

    local recipients = RecipientFilter()
    local pos = veh:GetPos()
    recipients:AddPAS(pos)
    recipients:AddPVS(pos)
    recipients:AddPlayer(ply)

    net.Start("PIXEL.Karts.RocketBoost")
    net.WriteEntity(veh)
    net.Send(recipients)
end