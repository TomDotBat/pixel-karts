
local gliderUpgrade = PIXEL.Karts.Config.Upgrades.Glider

util.AddNetworkString("PIXEL.Karts.DeployGlider")

local boostKey = PIXEL.Karts.Config.Upgrades.Glider.DeployKey
hook.Add("KeyPress", "PIXEL.Karts.DeployGliderBind", function(ply, key)
    if key ~= boostKey then return end

    local veh = ply:GetVehicle()
    if not (IsValid(veh) and veh.IsPIXELKart) then return end

    PIXEL.Karts.DeployGlider(ply, veh)
end)

local traceData = {}
local floorVector = Vector(0, 0, -10000000)
local function isTooCloseToGround(veh)
    local vehPos = veh:GetPos()

    traceData["start"] = vehPos
    traceData["endpos"] = vehPos + floorVector

    local tr = util.TraceLine(traceData)
    if not tr.Hit then return end
    if tr.HitPos:DistToSqr(vehPos) > gliderUpgrade.GroundCheckMinDist then return end
    return true
end

local pitchAng, rollAng = Vector(-1, 0, 0), Vector(0, 1, 0)

function PIXEL.Karts.DeployGlider(ply, veh)
    if veh:GetNWBool("PIXEL.Karts.IsGliding", false) then
        PIXEL.Karts.FinishGlide(ply, veh)
        return
    end

    if not veh:GetGlider() then
        PIXEL.Karts.Notify(ply, "Your kart doesn't have a glider loser.", 1)
        return
    end

    if veh:GetNWFloat("PIXEL.Karts.GliderCooldown", 0) > CurTime() then
        PIXEL.Karts.Notify(ply, "Your glider is on cooldown.", 1)
        return
    end

    if not ply:PIXELKartsIsLevel(gliderUpgrade.RequiredLevel) then
        PIXEL.Karts.Notify(ply, "You don't have the required rank to use a glider.", 1)
        return
    end

    if not PIXEL.Karts.Config.AbilitiesInOtherKarts and veh:CPPIGetOwner() ~= ply then
        PIXEL.Karts.Notify(ply, "You can't use abilities in another person's kart.", 1)
        return
    end

    --if isTooCloseToGround(veh) then
    --    PIXEL.Karts.Notify(ply, "You're trying to glide across the ground?", 1)
    --    return
    --end

    veh:SetNWFloat("PIXEL.Karts.GliderCooldown", CurTime() + gliderUpgrade.DeployCooldown)
    veh:SetNWBool("PIXEL.Karts.IsGliding", true)

    local phys = veh:GetPhysicsObject()
    local controlSpeed = gliderUpgrade.AirControlSpeed
    hook.Add("VehicleMove", "PIXEL.Karts.GliderMovement", function(driver, kart, mv)
        if not (driver == ply and veh == kart) then return end
        if not IsValid(phys) then
            hook.Remove("VehicleMove", "PIXEL.Karts.GliderMovement")
            return
        end

        local fwSpeed, sideSpeed = mv:GetForwardSpeed(), mv:GetSideSpeed()
        if fwSpeed > 0 then --fw
            phys:AddAngleVelocity(pitchAng * controlSpeed)
        elseif fwSpeed ~= 0 then --bw
            phys:AddAngleVelocity(-pitchAng * controlSpeed)
        end

        if sideSpeed > 0 then --right
            phys:AddAngleVelocity(rollAng * controlSpeed)
        elseif sideSpeed ~= 0 then --left
            phys:AddAngleVelocity(-rollAng * controlSpeed)
        end
    end)

    veh:EnableEngine(false)
    phys:SetDamping(gliderUpgrade.LinearDamping, gliderUpgrade.AngularDamping)

    local thrust = Vector(0, 0, gliderUpgrade.UpwardsThrust)
    timer.Create("PIXEL.Karts.GliderPhysics:" .. veh:EntIndex(), gliderUpgrade.ThrustInterval, gliderUpgrade.MaxGlideTime / gliderUpgrade.ThrustInterval, function()
        if not IsValid(phys) then return end
        phys:ApplyForceCenter(thrust + veh:GetForward() * gliderUpgrade.ForwardThrust)
    end)

    timer.Create("PIXEL.Karts.GliderGroundCheck:" .. veh:EntIndex(), gliderUpgrade.GroundCheckInterval, gliderUpgrade.MaxGlideTime / gliderUpgrade.GroundCheckInterval, function()
        if not IsValid(veh) then return end
        if isTooCloseToGround(veh) then PIXEL.Karts.FinishGlide(ply, veh) end
    end)

    timer.Create("PIXEL.Karts.GliderTimer:" .. veh:EntIndex(), gliderUpgrade.MaxGlideTime, 1, function()
        PIXEL.Karts.FinishGlide(ply, veh)
    end)

    local recipients = RecipientFilter()
    local pos = veh:GetPos()
    recipients:AddPAS(pos)
    recipients:AddPVS(pos)
    recipients:AddPlayer(ply)

    net.Start("PIXEL.Karts.DeployGlider")
    net.WriteEntity(veh)
    net.Send(recipients)
end

function PIXEL.Karts.FinishGlide(ply, veh)
    timer.Remove("PIXEL.Karts.GliderPhysics:" .. veh:EntIndex())
    timer.Remove("PIXEL.Karts.GliderGroundCheck:" .. veh:EntIndex())
    timer.Remove("PIXEL.Karts.GliderTimer:" .. veh:EntIndex())

    hook.Remove("VehicleMove", "PIXEL.Karts.GliderMovement")

    if not IsValid(veh) then return end
    veh:SetNWBool("PIXEL.Karts.IsGliding", false)
    veh:EnableEngine(true)

    local phys = veh:GetPhysicsObject()
    if not IsValid(phys) then return end
    phys:SetDamping(0, 0)
end