
util.AddNetworkString("PIXEL.Karts.Nitro")

net.Receive("PIXEL.Karts.Nitro", function(len, ply)
    if not ply:InVehicle() then return end

    local veh = ply:GetVehicle()
    if not veh.IsPIXELKart then return end

    if not veh:GetNitro() then
        PIXEL.Karts.Notify(ply, "Your kart doesn't have nitro loser.", 1)
        return
    end

    if not ply:PIXELKartsIsLevel(PIXEL.Karts.Config.Nitro.RequiredLevel) then
        PIXEL.Karts.Notify(ply, "You don't have the required rank for nitro.", 1)
        return
    end

    if not PIXEL.Karts.Config.AbilitiesInOtherKarts and veh:CPPIGetOwner() ~= ply then
        PIXEL.Karts.Notify(ply, "You can't use abilities in another person's kart.", 1)
        return
    end

    local phys = veh:GetPhysicsObject()
    local boostPower = PIXEL.Karts.Config.Nitro.BoostPower
    timer.Create("PIXEL.Karts.NitroBoost:" .. veh:EntIndex(), 0.025, 150, function()
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
end)