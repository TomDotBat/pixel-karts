
PIXEL.Karts.Vehicles = PIXEL.Karts.Vehicles or {}
local karts = PIXEL.Karts.Vehicles

--hook.Add("Think", "PIXEL.Karts.KartThink", function()
--    for steamId, veh in pairs(karts) do
--        if not IsValid(veh) then
--            karts[steamId] = nil
--            continue
--        end
--
--        veh:Think()
--    end
--end)

hook.Add("EntityRemoved", "PIXEL.Karts.OnRemove", function(ent)
    if not ent.IsPIXELKart then return end
    PIXEL.Karts.Vehicles[ent.PIXELKartID] = nil
end)