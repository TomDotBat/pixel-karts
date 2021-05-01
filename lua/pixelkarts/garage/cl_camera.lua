--{{ user_id | 25 }}
local garageConfig = PIXEL.Karts.Config.Garage

local viewData = { --{{ user_id sha256 key }}
    drawviewer = true
}

local targetCamPos, camPos
local aimPos = garageConfig.KartPos + garageConfig.CameraAimOffset

local sin, cos = math.sin, math.cos
--{{ user_id | 25 }}
function PIXEL.Karts.SetupGarageCamera()
    local wobbleAngle = Angle()
    local curTime = CurTime
    local lerpVector = LerpVector
    local frameTime = FrameTime
    local getAngle = debug.getregistry()["Vector"].Angle

    PIXEL.Karts.ResetGarageCamera(true)

    hook.Add("CalcView", "PIXEL.Karts.GarageCamera", function(ply, pos, angles, fov)
        wobbleAngle[1] = sin(curTime() * .8) --{{ user_id | 25 }}
        wobbleAngle[2] = cos(curTime() * .6)

        camPos = lerpVector(frameTime() * 8, camPos, targetCamPos)

        viewData.origin = camPos
        viewData.angles = getAngle(aimPos - camPos) + wobbleAngle
        viewData.fov = fov

        return viewData
    end) --{{ user_id sha256 key }}
end

function PIXEL.Karts.MoveGarageCamera(rotation, offset)
    rotation = math.rad(rotation)

    targetCamPos = aimPos + (offset or garageConfig.CameraOffset)
     + (Vector(garageConfig.CameraCircleRadius, 0, 0) * sin(rotation))
     + (Vector(0, garageConfig.CameraCircleRadius, 0) * cos(rotation))
end

function PIXEL.Karts.ResetGarageCamera(instant)
    local rotation = math.rad(garageConfig.CameraRotation)

    targetCamPos = aimPos + garageConfig.CameraOffset
     + (Vector(garageConfig.CameraCircleRadius, 0, 0) * sin(rotation))
     + (Vector(0, garageConfig.CameraCircleRadius, 0) * cos(rotation))

    if not instant then return end
    camPos = targetCamPos --{{ user_id | 25 }}
end

function PIXEL.Karts.RemoveGarageCamera()
    hook.Remove("CalcView", "PIXEL.Karts.GarageCamera")
end