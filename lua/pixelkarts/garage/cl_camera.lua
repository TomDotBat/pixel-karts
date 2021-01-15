
local localPly = LocalPlayer()

local viewData = {
    drawviewer = true
}

local curPos, curAng
local targetPos, targetAng = Vector(-777.760376, -688.692505, -137.569031), Angle(15.400071, -140.457840, 0)

local frameTime = FrameTime
local lerpVector, lerpAngle = LerpVector, LerpAngle
local angle = Angle
local sin, cos = math.sin, math.cos
local curTime = CurTime
hook.Add("CalcView", "PIXEL.Karts.GarageCamera", function(ply, pos, angles, fov)
    if ply ~= localPly then return end
    if not (curPos and curAng) then
        curPos, curAng = localPly:EyePos(), localPly:EyeAngles()
        return
    end

    local ft = frameTime() * 2
    curPos = lerpVector(ft, curPos, targetPos)
    curAng = lerpAngle(ft, curAng, targetAng)

    viewData.origin = curPos
    viewData.angles = curAng + angle(sin(curTime()), cos(curTime() * .8), 0)
    viewData.fov = fov

    return viewData
end)

--PIXEL.Karts.DestroyPreviewKart()
--PIXEL.Karts.CreatePreviewKart()

hook.Remove("CalcView", "PIXEL.Karts.GarageCamera")