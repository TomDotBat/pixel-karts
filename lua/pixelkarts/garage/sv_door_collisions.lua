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

local function makeDoor()
    local door = PIXEL.Karts.GarageDoor
    if not IsValid(door) then
        door = ents.Create("prop_physics")
        if not IsValid(door) then return end
        PIXEL.Karts.GarageDoor = door
    end

    door:SetModel(doorConfig.Model)
    door:SetPos(doorConfig.Position)
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
hook.Add("PostCleanupMap", "PIXEL.Karts.GarageDoorCollisions", makeDoor) 