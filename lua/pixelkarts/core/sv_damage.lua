
hook.Add("EntityTakeDamage", "PIXEL.Karts.Damage", function(tar, dmg)
    if not tar.IsPIXELKart then return end
    tar:SetNWInt("PIXEL.Karts.Health", math.max(math.floor(
        tar:GetNWInt("PIXEL.Karts.Health", 0) - dmg:GetDamage()
    ), 0))
end)