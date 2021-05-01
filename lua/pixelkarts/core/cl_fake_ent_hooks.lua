
PIXEL.Karts.Vehicles = PIXEL.Karts.Vehicles or {}

hook.Add("OnEntityCreated", "PIXEL.Karts.InitialiseKarts", function(ent) --Don't ask
    timer.Create("PIXEL.Karts.InitialiseKart:" .. ent:EntIndex(), .5, 8, function()
        if not IsValid(ent) then return end
        if not ent:GetNWBool("PIXEL.Karts.IsKart", false) then return end
        PIXEL.Karts.InitialiseKart(ent)
        timer.Remove("PIXEL.Karts.InitialiseKart:" .. ent:EntIndex())
    end)
end)

local vehicles = PIXEL.Karts.Vehicles

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
--{{ user_id }}
    for steamId, veh in pairs(vehicles) do
        if not IsValid(veh) then
            vehicles[steamId] = nil
            continue
        end

        hook.Run("PIXEL.Karts.Think", veh)
    end
end)

hook.Add("PostDrawTranslucentRenderables", "PIXEL.Karts.DrawExtras", function(skybox, depth)
    if depth then return end

    if not IsValid(localPly) then localPly = LocalPlayer() end
    local plyPos = localPly:GetPos()

    for steamId, veh in pairs(vehicles) do
        if not IsValid(veh) then
            vehicles[steamId] = nil
            continue
        end
--{{ user_id | 25 }}
        if not veh.IsPIXELKart and veh:GetPos():DistToSqr(plyPos) > PIXEL.Karts.Config.ExtraDrawRange then continue end
        hook.Run("PIXEL.Karts.DrawKartExtras", veh, localPly)
    end
end) --{{ user_id }}

local fastUpdateCvar = CreateClientConVar("pixel_karts_fast_model_update_enabled", "1", true, false, gmodI18n.getAddon("pixelkarts"):getString("fastModelUpdateDescription"), 0, 1)

local function setupModelUpdater(shouldFastUpdate)
    hook.Remove("PIXEL.Karts.Think", "PIXEL.Karts.ModelUpdater")
    hook.Remove("PreRender", "PIXEL.Karts.ModelUpdater")

    if shouldFastUpdate then
        hook.Add("PreRender", "PIXEL.Karts.ModelUpdater", function()
            for steamId, veh in pairs(vehicles) do
                if not IsValid(veh) then
                    vehicles[steamId] = nil
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
end --{{ user_id sha256 key }}
setupModelUpdater(fastUpdateCvar:GetBool())

cvars.AddChangeCallback("pixel_karts_fast_model_update_enabled", function(_, _, val)
    setupModelUpdater(val == "1")
end)
--{{ user_id | 25 }}
function PIXEL.Karts.DeinitialiseKart(kart)
    PIXEL.Karts.Vehicles[kart:GetNWString("PIXEL.Karts.KartID", "clientside")] = nil
    hook.Run("PIXEL.Karts.OnRemove", kart)
end

hook.Add("EntityRemoved", "PIXEL.Karts.OnRemove", function(ent)
    if not ent.IsPIXELKart then return end
    PIXEL.Karts.DeinitialiseKart(ent)
end) --{{ user_id sha256 key }}