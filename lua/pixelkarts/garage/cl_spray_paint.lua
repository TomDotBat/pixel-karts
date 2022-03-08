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

local garageConfig = PIXEL.Karts.Config.Garage

--PIXEL.Karts.SprayCanMaterial = PIXEL.Karts.SprayCanMaterial or CreateMaterial("pixel_karts_spraycan", "VertexLitGeneric", {
--    ["$basetexture"] = "color/white",
--    ["$model"] = 1,
--    ["$translucent"] = 1,
--    ["$vertexalpha"] = 1,
--    ["$vertexcolor"] = 0
--})

PIXEL.Karts.SprayPaintEmitter = PIXEL.Karts.SprayPaintEmitter or ParticleEmitter(vector_origin)
local emitter = PIXEL.Karts.SprayPaintEmitter

local particleOrigin = Vector(1, 0, 10.8)
local particleGravity = Vector(0, 0, 1.5)

local function startColorAnimation(kart, col)
    local intialKartColor = kart:GetCustomColor()
    local startTime = CurTime()
    local endTime = startTime + .9

    hook.Add("Think", "PIXEL.Karts.SprayCan.ColorAnimation", function()
        if IsValid(kart) then
            kart:SetCustomColor(PIXEL.LerpColor((CurTime() - startTime) / (endTime - startTime), intialKartColor, col))
        end
    end)
end


local function startParticleEffects(can, col)
    PIXEL.Karts.SprayPaintColor = col

    if timer.Exists("PIXEL.Karts.SprayCan.Particles") then return end

    timer.Create("PIXEL.Karts.SprayCan.Particles", 0.03, 0, function()
        if not IsValid(can) then
            timer.Remove("PIXEL.Karts.SprayCan.Particles")
            return
        end

        local color = PIXEL.Karts.SprayPaintColor
        local particle = emitter:Add(string.format("particle/smokesprites_00%02d", math.random(7, 16)), can:LocalToWorld(particleOrigin))
        particle:SetColor(color.r, color.g, color.b, color.a)
        particle:SetVelocity(can:GetAngles():Forward() * 100)
        particle:SetGravity(particleGravity)
        particle:SetLifeTime(0)
        particle:SetDieTime(0.2)
        particle:SetStartSize(5)
        particle:SetEndSize(10)
        particle:SetStartAlpha(200)
        particle:SetEndAlpha(0)
        particle:SetCollide(false)
        particle:SetBounce(0.25)
        particle:SetRoll(math.Rand(0,360))
        particle:SetRollDelta(0.01 * math.Rand(-40, 40))
        particle:SetAirResistance(50)
    end)
end

local function playSpraySound(can)
    if not IsValid(PIXEL.Karts.SprayPaintSound) then
        sound.PlayURL(garageConfig.SprayPaintSoundURL, "noblock 3d", function(station)
            if not IsValid(station) then return end
            if not IsValid(can) then return end
            PIXEL.Karts.SprayPaintSound = station

            station:SetPos(can:GetPos())
            station:SetVolume(garageConfig.SprayPaintSoundVolume)
            station:Play()
        end)
    else
        --PIXEL.Karts.SprayPaintSound:SetTime(0)
        PIXEL.Karts.SprayPaintSound:Play()
    end
end

function PIXEL.Karts.SprayPaintKart(kart, col)
    local can = PIXEL.Karts.SprayPaintCan
    if IsValid(can) then
        --PIXEL.Karts.SprayCanMaterial:SetVector("$color2", Vector(col.r, col.g, col.b))
        startColorAnimation(kart, col)
        startParticleEffects(can, col)
        playSpraySound()
        timer.Create("PIXEL.Karts.SprayCan.FinishSpray", 1, 1, PIXEL.Karts.RemoveSprayCan)
        return
    end

    if not IsValid(kart) then return end

    PIXEL.Karts.SprayPaintCan = ClientsideModel("models/unconid/spray_can/spray_can.mdl")
    can = PIXEL.Karts.SprayPaintCan
    can:SetBodygroup(1, 2)
    can:SetSkin(2)
    --can:SetSubMaterial(4, "!pixel_karts_spraycan")

    --PIXEL.Karts.SprayCanMaterial:SetVector("$color2", Vector(col.r, col.g, col.b))

    playSpraySound(can)
    startParticleEffects(can, col)
    startColorAnimation(kart, col)

    local rotation = math.Rand(0, 1) * math.pi * 2
    local sin, cos = math.sin, math.cos
    local kartPos = garageConfig.KartPos
    local heightVector = Vector(0, 0, 10)
    local xVector, yVector = Vector(garageConfig.SprayPaintCircleRadius, 0, 0), Vector(0, garageConfig.SprayPaintCircleRadius, 0)

    hook.Add("Think", "PIXEL.Karts.SprayCan.RotateAroundKart", function()
        if not IsValid(can) then return end

        rotation = rotation + FrameTime() * 2

        local time = CurTime() * 3
        local canPos = kartPos + garageConfig.SprayPaintOffset
            + (heightVector * cos(time * .6))
            + (xVector * sin(rotation))
            + (yVector * cos(rotation))

        local canAngles = (kartPos - canPos):Angle()
        canAngles:RotateAroundAxis(canAngles:Right(), sin(time -20) * 14)
        canAngles:RotateAroundAxis(canAngles:Forward(), cos(time) * 5)

        can:SetPos(canPos)
        can:SetAngles(canAngles)

        if not IsValid(PIXEL.Karts.SprayPaintSound) then return end
        PIXEL.Karts.SprayPaintSound:SetPos(canPos)
    end)

    timer.Create("PIXEL.Karts.SprayCan.FinishSpray", 1, 1, PIXEL.Karts.RemoveSprayCan)
end

function PIXEL.Karts.RemoveSprayCan()
    if IsValid(PIXEL.Karts.SprayPaintCan) then
        PIXEL.Karts.SprayPaintCan:Remove()
    end

    if IsValid(PIXEL.Karts.SprayPaintSound) then
        PIXEL.Karts.SprayPaintSound:Stop()
        PIXEL.Karts.SprayPaintSound = nil
    end

    timer.Remove("PIXEL.Karts.SprayCan.Particles")
    hook.Remove("Think", "PIXEL.Karts.SprayCan.ColorAnimation")
end