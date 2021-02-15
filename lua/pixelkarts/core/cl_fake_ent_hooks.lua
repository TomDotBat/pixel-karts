
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
    timer.Create("PIXEL.Karts.InitialiseKart:" .. ent:EntIndex(), .5, 8, function()
        if not IsValid(ent) then return end
        if not ent:GetNWBool("PIXEL.Karts.IsKart", false) then return end
        PIXEL.Karts.InitialiseKart(ent)
        timer.Remove("PIXEL.Karts.InitialiseKart:" .. ent:EntIndex())
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


local fastUpdateCvar = CreateClientConVar("pixel_karts_fast_model_update_enabled", "1", true, false, "Should kart models be updated more frequently? This may be intensive.", 0, 1)

local function setupModelUpdater(shouldFastUpdate)
    hook.Remove("PIXEL.Karts.Think", "PIXEL.Karts.ModelUpdater")
    hook.Remove("PreRender", "PIXEL.Karts.ModelUpdater")

    if shouldFastUpdate then
        hook.Add("PreRender", "PIXEL.Karts.ModelUpdater", function()
            for steamId, veh in pairs(karts) do
                if not IsValid(veh) then
                    karts[steamId] = nil
                    continue
                end

                hook.Run("PIXEL.Karts.UpdateModels", veh)
            end
        end)
    else
        hook.Add("PIXEL.Karts.Think", "PIXEL.Karts.ModelUpdater", function(kart)
            hook.Run("PIXEL.Karts.UpdateModels", kart)
        end)
    end
end
setupModelUpdater(fastUpdateCvar:GetBool())

cvars.AddChangeCallback("pixel_karts_fast_model_update_enabled", function(_, _, val)
    setupModelUpdater(val == "1")
end)