
local rampConfig = PIXEL.Karts.Config.GarageRamp
if not rampConfig.Enabled then return end
--{{ user_id }}
local function buildRamp()
    local ramp = PIXEL.Karts.Ramp
    if not IsValid(ramp) then
        ramp = ents.Create("prop_physics")
        if not IsValid(ramp) then return end
        PIXEL.Karts.Ramp = ramp
    end

    ramp:SetModel(rampConfig.Model)
    ramp:SetPos(rampConfig.Position)
    ramp:SetAngles(rampConfig.Angles)
    ramp:Spawn()
--{{ user_id | 25 }}
    ramp:GetPhysicsObject():EnableMotion(false)
    ramp:SetColor(color_transparent)
    ramp:SetRenderMode(RENDERMODE_TRANSCOLOR)
end

hook.Add("InitPostEntity", "PIXEL.Karts.GarageRampCollisions", buildRamp)
hook.Add("PostCleanupMap", "PIXEL.Karts.GarageRampCollisions", buildRamp) --{{ user_id }}