
PIXEL.Karts.Vehicles = PIXEL.Karts.Vehicles or {}
local karts = PIXEL.Karts.Vehicles

hook.Add("OnEntityCreated", "PIXEL.Karts.InitialiseKarts", function(ent)
    timer.Simple(.2, function()
        if not IsValid(ent) then return end
        if not ent:GetNWBool("PIXEL.Karts.IsKart", false) then return end

        for k, v in pairs(PIXEL.Karts.KartTable) do
            ent[k] = v
        end

        ent:Initialize()

        PIXEL.Karts.Vehicles[ent:GetNWString("PIXEL.Karts.KartID", "")] = ent
    end)
end)

hook.Add("Think", "PIXEL.Karts.KartThink", function()
    for steamId, veh in pairs(karts) do
        if not IsValid(veh) then
            karts[steamId] = nil
            continue
        end

        veh:Think()
    end
end)

hook.Add("EntityRemoved", "PIXEL.Karts.OnRemove", function(ent)
    if not ent.IsPIXELKart then return end
    PIXEL.Karts.Vehicles[ent:GetNWString("PIXEL.Karts.KartID", "")] = nil
end)