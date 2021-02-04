
local garageConfig = PIXEL.Karts.Config.Garage

local function togglePlayerGarageState(ply)
    if ply:GetNWBool("PIXEL.Karts.IsInGarage", false) then
        ply:SetNWBool("PIXEL.Karts.IsInGarage", false)
        ply:SetNWBool("PIXEL.Karts.IsInGarageWithKart", false)

        ply:SetPos(garageConfig.LeavePosition)
        ply:SetEyeAngles(garageConfig.LeaveAngles)

        net.Start("PIXEL.Karts.GarageStateUpdate")
        net.Send(ply)
    else
        if ply:Health() < 1 then return end
        if ply:GetPos():DistToSqr(garageConfig.EntryRangeCheckPoint) > garageConfig.EntryRangeCheckRadius ^ 2 then return end

        local veh = ply:GetVehicle()
        if IsValid(veh) then
            if not veh.IsPIXELKart then return end

            if veh:CPPIGetOwner() ~= ply then
                PIXEL.Karts.Notify(ply, "You can't enter the garage with someone else's kart.", 1, 5)
                return
            end

            veh:GetPhysicsObject():EnableMotion(false)
            veh:SetColor(color_transparent)
            veh:SetRenderMode(RENDERMODE_TRANSCOLOR)

            ply:SetNWBool("PIXEL.Karts.IsInGarage", true)
            ply:SetNWBool("PIXEL.Karts.IsInGarageWithKart", true)

            net.Start("PIXEL.Karts.GarageEntered")
             net.WriteVector(veh:GetPos())
            net.Send(ply)

            ply:ExitVehicle()
            ply:SetPos(garageConfig.InsidePositions[math.random(#garageConfig.InsidePositions)])
            veh:Remove()

            return
        end

        net.Start("PIXEL.Karts.GarageEntered")
         net.WriteVector(vector_origin)
        net.Send(ply)

        ply:SetNWBool("PIXEL.Karts.IsInGarage", true)
        ply:SetNWBool("PIXEL.Karts.IsInGarageWithKart", true)

        ply:SetPos(garageConfig.InsidePositions[math.random(#garageConfig.InsidePositions)])
    end
end
util.AddNetworkString("PIXEL.Karts.GarageEntered")

net.Receive("PIXEL.Karts.GarageStateUpdate", function(len, ply)
    local steamId = ply:SteamID64()
    if timer.Exists("PIXEL.Karts.GarageStateUpdateCooldown:" .. steamId) then return end
    timer.Create("PIXEL.Karts.GarageStateUpdateCooldown:" .. steamId, .5, 1, function() end)

    togglePlayerGarageState(ply)
end)
util.AddNetworkString("PIXEL.Karts.GarageStateUpdate")


net.Receive("PIXEL.Karts.PurchaseKart", function(len, ply)
    if not ply:GetNWBool("PIXEL.Karts.IsInGarage", false) then return end

    local price = PIXEL.Karts.Config.KartPrice[ply:PIXELKartsGetLevel()]
    if not ply:canAfford(price) then
        togglePlayerGarageState(ply)
        PIXEL.Karts.Notify(ply, "You can't afford to buy a kart.", 1)
        return
    end

    ply:addMoney(-price)
    PIXEL.Karts.Notify(ply, "Purchased a kart for " .. DarkRP.formatMoney(price) .. ".", 1)

    net.Start("PIXEL.Karts.RespawnKart")
    net.Send(ply)
end)
util.AddNetworkString("PIXEL.Karts.PurchaseKart")

net.Receive("PIXEL.Karts.RespawnKart", function(len, ply)
    if not ply:GetNWBool("PIXEL.Karts.IsInGarage", false) then return end

    local price = PIXEL.Karts.Config.RespawnPrice[ply:PIXELKartsGetLevel()]
    if not ply:canAfford(price) then
        togglePlayerGarageState(ply)
        PIXEL.Karts.Notify(ply, "You can't afford to respawn your kart.", 1)
        return
    end

    ply:addMoney(-price)
    PIXEL.Karts.Notify(ply, "Respawned your kart for " .. DarkRP.formatMoney(price) .. ".", 1)

    net.Start("PIXEL.Karts.RespawnKart")
    net.Send(ply)
end)
util.AddNetworkString("PIXEL.Karts.RespawnKart")

hook.Add("PlayerDeath", "PIXEL.Karts.LeaveGarageOnDeath", function(ply)
    if not ply:GetNWBool("PIXEL.Karts.IsInGarage", false) then return end

    ply:SetPos(garageConfig.LeavePosition)

    ply:SetNWBool("PIXEL.Karts.IsInGarage", false)
    ply:SetNWBool("PIXEL.Karts.IsInGarageWithKart", false)

    net.Start("PIXEL.Karts.GarageStateUpdate")
    net.Send(ply)
end)