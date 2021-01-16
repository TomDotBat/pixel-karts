
hook.Add("EntityTakeDamage", "PIXEL.Karts.Damage", function(tar, dmg)
    if not tar.IsPIXELKart then return end
    tar:SetNWInt("PIXEL.Karts.Health", math.max(math.floor(
        tar:GetNWInt("PIXEL.Karts.Health", 0) - dmg:GetDamage()
    ), 0))
end)

hook.Add("PIXEL.Karts.Think", "PIXEL.Karts.WaterDamage", function(kart)
    if kart:IsVehicleBodyInWater() then
        kart:SetNWInt("PIXEL.Karts.Health", 0)
    end
end)