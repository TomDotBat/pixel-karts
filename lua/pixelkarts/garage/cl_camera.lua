
local garageConfig = PIXEL.Karts.Config.Garage

local viewData = {
    drawviewer = true
}

local kartPos = garageConfig.KartPos
local rotation = math.rad(garageConfig.CameraRotation)
local camPos = kartPos + garageConfig.CameraOffset
    + (Vector(garageConfig.CameraCircleRadius, 0, 0) * math.sin(rotation))
    + (Vector(0, garageConfig.CameraCircleRadius, 0) * math.cos(rotation))

local camAngles = (kartPos - camPos):Angle()
local wobbleAngle = Angle()

local curTime = CurTime
local sin, cos = math.sin, math.cos

function PIXEL.Karts.SetupGarageCamera()
    hook.Add("CalcView", "PIXEL.Karts.GarageCamera", function(ply, pos, angles, fov)
        wobbleAngle[1] = sin(curTime() * .8)
        wobbleAngle[2] = cos(curTime() * .6)

        viewData.origin = camPos
        viewData.angles = camAngles + wobbleAngle
        viewData.fov = fov

        return viewData
    end)
end

function PIXEL.Karts.RemoveGarageCamera()
    hook.Remove("CalcView", "PIXEL.Karts.GarageCamera")
end