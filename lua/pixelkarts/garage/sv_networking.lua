
local garageConfig = PIXEL.Karts.Config.Garage

net.Receive("PIXEL.Karts.GarageStateUpdate", function(len, ply)
    local steamid = ply:SteamID64()
    if timer.Exists("PIXEL.Karts.GarageStateCooldown:" .. steamid) then return end
    timer.Create("PIXEL.Karts.GarageStateCooldown:" .. steamid, 2, 1, function() end)

    local inGarage = ply:GetNWBool("PIXEL.Karts.IsInGarage", false)
    if not inGarage then
        if ply:Health() < 1 then
            ply:SetNWBool("PIXEL.Karts.IsInGarage", false)
            ply:SetNWBool("PIXEL.Karts.IsInGarageWithKart", false)
            return
        end

        local veh = ply:GetVehicle()
        if IsValid(veh) then
            if not veh.IsPIXELKart then return end

            if veh:CPPIGetOwner() ~= ply then
                PIXEL.Karts.Notify(ply, "You can't enter the garage with someone else's kart.", 1, 5)
                return
            end

            ply:SetNWBool("PIXEL.Karts.IsInGarageWithKart", true)
            veh:Remove()
        end

        if not ply:GetPos():WithinAABox(garageConfig.EntryBoxPoint1, garageConfig.EntryBoxPoint2) then
            PIXEL.Karts.Notify(ply, "Where the fuck are you?", 1, 5)
            return
        end

        ply:SetPos(garageConfig.InsidePositions[math.random(#garageConfig.InsidePositions)])
    else
        ply:SetNWBool("PIXEL.Karts.IsInGarageWithKart", false)
        ply:SetPos(garageConfig.LeavePosition)
        ply:SetEyeAngles(garageConfig.LeaveAngles)
    end

    ply:SetNWBool("PIXEL.Karts.IsInGarage", not inGarage)
end)

util.AddNetworkString("PIXEL.Karts.GarageStateUpdate")

hook.Add("PlayerDeath", "PIXEL.Karts.LeaveGarageOnDeath", function(ply)
    ply:SetNWBool("PIXEL.Karts.IsInGarage", false)
    ply:SetNWBool("PIXEL.Karts.IsInGarageWithKart", false)
end)