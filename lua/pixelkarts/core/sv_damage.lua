
--- @TODO
--- Rename tar to target.
--- 
hook.Add("EntityTakeDamage", "PIXEL.Karts.Damage", function(tar, dmg)
    if tar.IsPIXELKart then
        tar:SetNWInt("PIXEL.Karts.Health", math.max(math.floor(
            tar:GetNWInt("PIXEL.Karts.Health", 0) - dmg:GetDamage()
        ), 0))
    elseif tar:IsPlayer() then
        do
            local inflictor = dmg:GetInflictor()
            if IsValid(inflictor) and (inflictor.IsPIXELKart or inflictor.IsPIXELKartsPassengerSeat) then
                dmg:SetDamage(0)
                dmg:ScaleDamage(0)
                return true
            end
        end

        local veh = tar:GetVehicle()
        if not (IsValid(veh) and (veh.IsPIXELKart or veh.IsPIXELKartsPassengerSeat)) then return end

        if dmg:GetAttacker() == tar then
            dmg:SetDamage(0)
            dmg:ScaleDamage(0)
            return true
        end
    end
end)

hook.Add("PIXEL.Karts.Think", "PIXEL.Karts.WaterDamage", function(kart)
    if kart:IsVehicleBodyInWater() then
        kart:SetNWInt("PIXEL.Karts.Health", 0)
    end
end)