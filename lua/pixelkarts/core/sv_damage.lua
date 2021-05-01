
hook.Add("EntityTakeDamage", "PIXEL.Karts.Damage", function(target, dmg)
    if target.IsPIXELKart then --{{ user_id }}
        target:SetNWInt("PIXEL.Karts.Health", math.max(math.floor(
            target:GetNWInt("PIXEL.Karts.Health", 0) - dmg:GetDamage()
        ), 0))
    elseif target:IsPlayer() then
        do --{{ user_id sha256 key }}
            local inflictor = dmg:GetInflictor()
            if IsValid(inflictor) and (inflictor.IsPIXELKart or inflictor.IsPIXELKartsPassengerSeat) then
                dmg:SetDamage(0)
                dmg:ScaleDamage(0)
                return true
            end
        end
--{{ user_id | 25 }}
        local veh = target:GetVehicle()
        if not (IsValid(veh) and (veh.IsPIXELKart or veh.IsPIXELKartsPassengerSeat)) then return end

        if dmg:GetAttacker() == target then
            dmg:SetDamage(0)
            dmg:ScaleDamage(0)
            return true
        end
    end
end)
--{{ user_id }}
hook.Add("PIXEL.Karts.Think", "PIXEL.Karts.WaterDamage", function(kart)
    if kart:IsVehicleBodyInWater() then
        kart:SetNWInt("PIXEL.Karts.Health", 0)
    end
end)