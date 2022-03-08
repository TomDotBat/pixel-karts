--[[
    PIXEL Karts
    Copyright (C) 2022 Thomas (Tom.bat) O'Sullivan 

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program. If not, see <https://www.gnu.org/licenses/>.
]]

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

        local bodyGroupCount = door:GetNumBodyGroups()
        if bodyGroupCount then
            for i = 0, bodyGroupCount - 1 do
                fakeDoor:SetBodygroup(i, door:GetBodygroup(i))
            end
        end

        local skin = door:GetSkin()
        if skin then
            fakeDoor:SetSkin(door:GetSkin())
        end
        fakeDoor:Spawn()

        SafeRemoveEntityDelayed(door, 0)

        fakeDoor:PhysicsDestroy()
        fakeDoor:PhysicsInitStatic(SOLID_VPHYSICS)

        local physObj = fakeDoor:GetPhysicsObject()
        if not IsValid(physObj) then continue end
        physObj:EnableMotion(false)
    end
end)