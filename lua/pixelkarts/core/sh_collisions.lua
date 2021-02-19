

hook.Add("ShouldCollide", "PIXEL.Karts.PreventKartCollisions", function(ent1, ent2)
    if not PIXEL.Karts.Config.NoCollideKartsWithPlayers then return end

    if ent1:IsPlayer() and (ent2.IsPIXELKart or ent2.IsPIXELKartsPassengerSeat) then
        return false
    end

    if (ent1.IsPIXELKart or ent1.IsPIXELKartsPassengerSeat) and ent2:IsPlayer() then
        return false
    end
end)