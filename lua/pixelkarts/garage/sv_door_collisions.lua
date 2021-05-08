
local doorConfig = PIXEL.Karts.Config.GarageDoor
if not doorConfig.MakeCollisions then return end
--{{ user_id | 25 }}
local function makeDoor()
    local door = PIXEL.Karts.GarageDoor
    if not IsValid(door) then
        door = ents.Create("prop_physics")
        if not IsValid(door) then return end
        PIXEL.Karts.GarageDoor = door
    end

    door:SetModel(doorConfig.Model)
    door:SetPos(doorConfig.Position) --{{ user_id }}
    door:SetAngles(doorConfig.Angles)
    door:Spawn()

    door:GetPhysicsObject():EnableMotion(false)
    door:SetColor(color_transparent)
    door:SetRenderMode(RENDERMODE_TRANSCOLOR)
end

hook.Add("InitPostEntity", "PIXEL.Karts.GarageDoorCollisions", makeDoor)
hook.Add("PostCleanupMap", "PIXEL.Karts.GarageDoorCollisions", makeDoor) --{{ user_id }}