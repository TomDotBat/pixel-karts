
local doorConfig = PIXEL.Karts.Config.GarageDoor

if doorConfig.MapDoorID then
    hook.Add("PlayerInitialSpawn", "PIXEL.Karts.RemoveMapDoor", function()
        hook.Remove("PlayerInitialSpawn", "PIXEL.Karts.RemoveMapDoor")

        local door = ents.GetMapCreatedEntity(doorConfig.MapDoorID)
        if not IsValid(door) then return end

        SafeRemoveEntityDelayed(door, 0)
    end)
end

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

    door:SetColor(color_transparent)
    door:SetRenderMode(RENDERMODE_TRANSCOLOR)

    door:PhysicsDestroy()
    door:PhysicsInitStatic(SOLID_VPHYSICS)

    local physObj = door:GetPhysicsObject()
    if not IsValid(physObj) then return end
    physObj:EnableMotion(false)
end

hook.Add("InitPostEntity", "PIXEL.Karts.GarageDoorCollisions", makeDoor)
hook.Add("PostCleanupMap", "PIXEL.Karts.GarageDoorCollisions", makeDoor) --{{ user_id }}