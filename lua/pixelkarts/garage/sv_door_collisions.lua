
local doorConfig = PIXEL.Karts.Config.GarageDoor
if not doorConfig.MakeCollisions then return end

local function makeDoor()
    if not IsValid(PIXEL.Karts.GarageDoor) then
        PIXEL.Karts.GarageDoor = ents.Create("prop_physics")
    end

    local door = PIXEL.Karts.GarageDoor
    door:SetModel(doorConfig.Model)
    door:SetPos(doorConfig.Position)
    door:SetAngles(doorConfig.Angles)
    door:Spawn()

    door:GetPhysicsObject():EnableMotion(false)
    door:SetColor(color_transparent)
    door:SetRenderMode(RENDERMODE_TRANSCOLOR)
end

hook.Add("InitPostEntity", "PIXEL.Karts.GarageDoorCollisions", makeDoor)
hook.Add("PostCleanupMap", "PIXEL.Karts.GarageDoorCollisions", makeDoor)