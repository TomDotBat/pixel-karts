
local rampConfig = PIXEL.Karts.Config.GarageRamp
if not rampConfig.Enabled then return end

local function buildRamp()
    if not IsValid(PIXEL.Karts.Ramp) then
        PIXEL.Karts.Ramp = ents.Create("prop_physics")
    end

    local ramp = PIXEL.Karts.Ramp
    ramp:SetModel(rampConfig.Model)
    ramp:SetPos(rampConfig.Position)
    ramp:SetAngles(rampConfig.Angles)
    ramp:Spawn()

    ramp:GetPhysicsObject():EnableMotion(false)
    ramp:SetColor(color_transparent)
    ramp:SetRenderMode(RENDERMODE_TRANSCOLOR)
end

hook.Add("InitPostEntity", "PIXEL.Karts.GarageRampCollisions", buildRamp)
hook.Add("PostCleanupMap", "PIXEL.Karts.GarageRampCollisions", buildRamp)