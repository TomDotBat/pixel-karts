
local garageConfig = PIXEL.Karts.Config.Garage

local hideDist, fadeStartDist = 400, 100
PIXEL.RegisterFontUnscaled("Karts.GarageDoor", "Open Sans Bold", 255)

local localPly
hook.Add("PostDrawTranslucentRenderables", "PIXEL.Karts.GarageDoor", function(depth, skybox)
    if skybox then return end
    if not IsValid(localPly) then localPly = LocalPlayer() end

    local distance = (garageConfig.DoorFloorPos - localPly:EyePos()):Length()
    if distance < hideDist then
        surface.SetAlphaMultiplier(math.min(math.Remap(distance, fadeStartDist, hideDist, .5, 0), .5))

        local w, h = garageConfig.DoorFloorWidth, garageConfig.DoorFloorHeight
        cam.Start3D2D(garageConfig.DoorFloorPos, garageConfig.DoorFloorAngle, .1)
            surface.SetDrawColor(PIXEL.Colors.Primary)
            surface.DrawRect(0, 0, w, h)
            PIXEL.DrawOutlinedBox(0, 0, w, h, 25, PIXEL.Colors.PrimaryText)
            PIXEL.DrawSimpleText("PIXEL Karts", "PIXEL.Karts.GarageDoor", w * .5, h * .5, PIXEL.Colors.PrimaryText, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        cam.End3D2D()

        surface.SetAlphaMultiplier(1)
    end
end)

CreateMaterial("pixel_karts_garage_door", "VertexLitGeneric", {
    ["$basetexture"] = "metal/metaldoor061a",
    ["$basetexturetransform"] = "center .5 .5 scale .36 .36 rotate 0 translate .642 .95"
})

if not IsValid(PIXEL.Karts.GarageDoor) then
    PIXEL.Karts.GarageDoor = ClientsideModel("models/hunter/plates/plate3x3.mdl")
end

local door = PIXEL.Karts.GarageDoor
door:SetModel("models/hunter/plates/plate3x3.mdl")
door:SetMaterial("!pixel_karts_garage_door")
door:SetPos(garageConfig.DoorPos)
door:SetAngles(garageConfig.DoorAngle)
door:CreateShadow()

local function moveDoor(targetPos)
    local prog = 0
    local startPos = door:GetPos()
    hook.Add("Think", "PIXEL.Karts.GarageDoor", function()
        if not IsValid(door) then return end
        if prog >= 1 then hook.Remove("Think", "PIXEL.Karts.GarageDoor") end

        prog = prog + FrameTime() * .8
        door:SetPos(LerpVector(prog, startPos, targetPos))
    end)
end

local function playDoorSound()
    sound.PlayFile("sound/doors/door_metal_gate_move1.wav", "3d", function(station)
        if not IsValid(station) then return end
        station:SetPos(door:GetPos())
        station:SetVolume(.1)
        station:Play()
    end)
end

local movementOffset = Vector(0, 0, 118)
function PIXEL.Karts.OpenGarageDoor()
    if not IsValid(door) then return end
    playDoorSound()
    moveDoor(garageConfig.DoorPos + movementOffset)
end

function PIXEL.Karts.CloseGarageDoor()
    if not IsValid(door) then return end
    playDoorSound()
    moveDoor(garageConfig.DoorPos)
end

local flipAngle = Angle(0, 180, 0)
function PIXEL.Karts.FlipGarageDoor(state)
    if not IsValid(door) then return end
    door:SetAngles(state and (garageConfig.DoorAngle + flipAngle) or garageConfig.DoorAngle)
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
--
--print(closestEnt:MapCreationID())
--PrintTable(closestEnt:GetMaterials())

--2142
--1	=	metal/metaldoor061a
--2	=	metal/metalhull010b