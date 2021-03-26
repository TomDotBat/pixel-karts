
local garageConfig = PIXEL.Karts.Config.Garage
if not garageConfig.DoorCollisions then return end

local function makeDoor()
    if not IsValid(PIXEL.Karts.GarageDoor) then
        PIXEL.Karts.GarageDoor = ents.Create("prop_physics")
    end

    local door = PIXEL.Karts.GarageDoor
    door:SetModel("models/hunter/plates/plate3x3.mdl")
    door:SetPos(garageConfig.DoorPos)
    door:SetAngles(garageConfig.DoorAngle)
    door:Spawn()

    door:GetPhysicsObject():EnableMotion(false)
    door:SetColor(color_transparent)
    door:SetRenderMode(RENDERMODE_TRANSCOLOR)
end

hook.Add("InitPostEntity", "PIXEL.Karts.FakeGarageDoorCollisions", makeDoor)
hook.Add("PostCleanupMap", "PIXEL.Karts.FakeGarageDoorCollisions", makeDoor)