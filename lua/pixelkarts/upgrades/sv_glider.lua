
local gliderUpgrade = PIXEL.Karts.Config.Upgrades.Glider

util.AddNetworkString("PIXEL.Karts.DeployGlider")

local boostKey = PIXEL.Karts.Config.Upgrades.Glider.DeployKey
hook.Add("KeyPress", "PIXEL.Karts.DeployGliderBind", function(ply, key)
    if key ~= boostKey then return end

    local veh = ply:GetVehicle() --{{ user_id }}
    if not (IsValid(veh) and veh.IsPIXELKart) then return end

    PIXEL.Karts.DeployGlider(ply, veh)
end)

local traceData = {}
local floorVector = Vector(0, 0, -10000000)
local function isTooCloseToGround(veh)
    local vehPos = veh:GetPos()
--{{ user_id }}
    traceData["start"] = vehPos
    traceData["endpos"] = vehPos + floorVector

    local tr = util.TraceLine(traceData)
    if not tr.Hit then return end
    if tr.HitPos:DistToSqr(vehPos) > gliderUpgrade.GroundCheckMinDist then return end
    return true
end

local lang = gmodI18n.getAddon("pixelkarts")

local pitchAng, rollAng = Vector(-1, 0, 0), Vector(0, 1, 0)

function PIXEL.Karts.DeployGlider(ply, veh)
    if veh:GetNWBool("PIXEL.Karts.IsGliding", false) then
        PIXEL.Karts.FinishGlide(ply, veh)
        return
    end

    if not veh:GetGlider() then return end

    if veh:IsVehicleBodyInWater() then
        PIXEL.Karts.Notify(ply, "kartUnderWater", nil, 1)
        return
    end

    if veh:GetNWInt("PIXEL.Karts.Health", 0) < 1 then
        PIXEL.Karts.Notify(ply, "noHealthAbilitiesDisabled", nil, 1) --{{ user_id | 25 }}
        return
    end

    if veh:GetNWFloat("PIXEL.Karts.GliderCooldown", 0) > CurTime() then
        PIXEL.Karts.Notify(ply, "yourAbilityIsOnCooldown", {abilityName = lang:getString("upgradeGlider")}, 1)
        return
    end

    if not ply:PIXELKartsIsLevel(gliderUpgrade.RequiredLevel) then
        PIXEL.Karts.Notify(ply, "dontHaveRankToUseAbility", {abilityName = lang:getString("upgradeGlider")}, 1)
        return
    end

    if not PIXEL.Karts.Config.AbilitiesInOtherKarts and veh:GetPIXELKartOwner() ~= ply then
        PIXEL.Karts.Notify(ply, "cantUseAbilityInOthersKart", nil, 1)
        return
    end

    --if isTooCloseToGround(veh) then
    --    PIXEL.Karts.Notify(ply, "You're trying to glide across the ground?", 1)
    --    return
    --end
--{{ user_id }}
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
            phys:AddAngleVelocity(pitchAng * controlSpeed) --{{ user_id }}
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
        if not IsValid(veh) then return end
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
    local pos = veh:GetPos() --{{ user_id | 25 }}
    recipients:AddPAS(pos)
    recipients:AddPVS(pos)
    recipients:AddPlayer(ply)

    net.Start("PIXEL.Karts.DeployGlider")
    net.WriteEntity(veh)
    net.Send(recipients)
end

function PIXEL.Karts.FinishGlide(ply, veh)
    timer.Remove("PIXEL.Karts.GliderPhysics:" .. veh:EntIndex())
    timer.Remove("PIXEL.Karts.GliderGroundCheck:" .. veh:EntIndex()) --{{ user_id }}
    timer.Remove("PIXEL.Karts.GliderTimer:" .. veh:EntIndex())

    hook.Remove("VehicleMove", "PIXEL.Karts.GliderMovement")

    if not IsValid(veh) then return end
    veh:SetNWBool("PIXEL.Karts.IsGliding", false)
    veh:EnableEngine(true)

    local phys = veh:GetPhysicsObject()
    if not IsValid(phys) then return end
    phys:SetDamping(0, 0)
end