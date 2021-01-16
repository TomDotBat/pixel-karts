
PIXEL.Karts.Vehicles = PIXEL.Karts.Vehicles or {}
local karts = PIXEL.Karts.Vehicles

function PIXEL.Karts.InitialiseKart(kart)
    for k, v in pairs(PIXEL.Karts.KartTable) do
        kart[k] = v
    end

    kart:Initialize()

    PIXEL.Karts.Vehicles[kart:GetNWString("PIXEL.Karts.KartID", "clientside")] = kart
end

hook.Add("OnEntityCreated", "PIXEL.Karts.InitialiseKarts", function(ent)
    timer.Simple(.5, function()
        if not IsValid(ent) then return end
        if not ent:GetNWBool("PIXEL.Karts.IsKart", false) then return end
        PIXEL.Karts.InitialiseKart(ent)
    end)
end)

local localPly, curKart
hook.Add("Think", "PIXEL.Karts.KartThink", function()
    if not IsValid(localPly) then localPly = LocalPlayer() end

    local kart = localPly:GetVehicle()
    if IsValid(kart) and kart.IsPIXELKart then
        if curKart ~= kart then
            hook.Run("PIXEL.Karts.EnteredKart", kart)
            curKart = kart
        end
    elseif curKart then
        hook.Run("PIXEL.Karts.LeftKart", curKart)
        curKart = nil
    end

    for steamId, veh in pairs(karts) do
        if not IsValid(veh) then
            karts[steamId] = nil
            continue
        end

        hook.Run("PIXEL.Karts.Think", veh)
    end
end)

function PIXEL.Karts.DeinitialiseKart(kart)
    PIXEL.Karts.Vehicles[kart:GetNWString("PIXEL.Karts.KartID", "clientside")] = nil
    hook.Run("PIXEL.Karts.OnRemove", kart)
end

hook.Add("EntityRemoved", "PIXEL.Karts.OnRemove", function(ent)
    if not ent.IsPIXELKart then return end
    PIXEL.Karts.DeinitialiseKart(ent)
end)