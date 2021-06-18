
local doorIds = PIXEL.Karts.Config.ForceLockedDoors
if not istable(doorIds) then return end

hook.Add("InitPostEntity", "PIXEL.Karts.ForceLockDoors", function()
    for _, doorId in ipairs(doorIds) do
        local door = ents.GetMapCreatedEntity(doorId)
        if not IsValid(door) then continue end

        local fakeDoor = ents.Create("prop_physics")
        if not IsValid(fakeDoor) then continue end

        fakeDoor:SetPos(door:GetPos())
        fakeDoor:SetAngles(door:GetAngles())
        fakeDoor:SetModel(door:GetModel())

        for i = 0, door:GetNumBodyGroups() - 1 do
            fakeDoor:SetBodygroup(i, door:GetBodygroup(i))
        end

        fakeDoor:SetSkin(door:GetSkin())
        fakeDoor:Spawn()

        SafeRemoveEntityDelayed(door, 0)

        fakeDoor:PhysicsDestroy()
        fakeDoor:PhysicsInitStatic(SOLID_VPHYSICS)

        local physObj = fakeDoor:GetPhysicsObject()
        if not IsValid(physObj) then continue end
        physObj:EnableMotion(false)
    end
end)