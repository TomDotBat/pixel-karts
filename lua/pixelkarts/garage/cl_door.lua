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
if not doorConfig.Model or doorConfig.Model == "" then return end

CreateMaterial("pixel_karts_garage_door", "VertexLitGeneric", {
    ["$basetexture"] = doorConfig.MaterialTexture,
    ["$basetexturetransform"] = doorConfig.MaterialSettings
})

if not IsValid(PIXEL.Karts.GarageDoor) then
    PIXEL.Karts.GarageDoor = ClientsideModel(doorConfig.Model)
end

local door = PIXEL.Karts.GarageDoor
door:SetModel(doorConfig.Model)
door:SetMaterial("!pixel_karts_garage_door")
door:SetPos(doorConfig.Position)
door:SetAngles(doorConfig.Angles)
--door:DestroyShadow()

local function moveDoor(targetPos)
    local prog = 0
    local startPos = door:GetPos()
    hook.Add("Think", "PIXEL.Karts.GarageDoor", function()
        if not IsValid(door) then return end
        if prog >= 1 then hook.Remove("Think", "PIXEL.Karts.GarageDoor") end

        prog = prog + FrameTime() * .9
        door:SetPos(LerpVector(prog, startPos, targetPos))
    end)
end

local function playDoorSound()
    sound.PlayFile("sound/doors/door_metal_gate_move1.wav", "3d", function(station)
        if not IsValid(station) then return end
        station:SetPos(door:GetPos())
        station:SetVolume(.4)
        station:Play()
    end)
end

function PIXEL.Karts.OpenGarageDoor()
    if not IsValid(door) then return end
    playDoorSound()
    moveDoor(doorConfig.Position + doorConfig.OpenOffset)
end

function PIXEL.Karts.CloseGarageDoor()
    if not IsValid(door) then return end
    playDoorSound()
    moveDoor(doorConfig.Position)
end

local flipAngle = Angle(0, 180, 0)
function PIXEL.Karts.FlipGarageDoor(state)
    if not IsValid(door) then return end
    door:SetAngles(state and (doorConfig.Angles + flipAngle) or doorConfig.Angles)
end

--local closestEnt
--local closestDist = math.huge
--
--for k, v in ipairs(ents.GetAll()) do
--    if v:MapCreationID() == -1 then continue end
--
--    local dist = v:GetPos():DistToSqr(player.GetAll()[1]:GetPos())
--    if dist < closestDist then
--        closestEnt = v
--        closestDist = dist
--    end
--end

--
--print(closestEnt:MapCreationID())
--PrintTable(closestEnt:GetMaterials())

--2142
--1	=	metal/metaldoor061a
--2	=	metal/metalhull010b