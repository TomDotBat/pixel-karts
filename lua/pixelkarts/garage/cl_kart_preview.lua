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

local function ease(x)
    return 1 - (1 - x) ^ 2
end

function PIXEL.Karts.CreatePreviewKart(kartStartPos)
    if IsValid(PIXEL.Karts.PreviewKart) then
        return PIXEL.Karts.PreviewKart
    end

    local garageConfig = PIXEL.Karts.Config.Garage

    local kart = ents.CreateClientside("pixel_kart")
    if not IsValid(kart) then return end

    kart:SetModel("models/freeman/vehicles/electric_go-kart.mdl")
    kart:SetPos(garageConfig.KartPos)
    kart:SetAngles(garageConfig.KartAngles)
    kart:SetupClientside()
    kart:SetupBones()
    kart:Spawn()

    if kartStartPos then
        if garageConfig.DisableDriveInAnim or kartStartPos == garageConfig.KartPos then
            PIXEL.Karts.PreviewKart = kart
            return kart
        end

        local progress = 0
        local startPos, targetPos = kartStartPos, garageConfig.KartPos

        startPos.y = targetPos.y
        startPos.z = targetPos.z

        local leftWheelBoneIds = {}
        local rightWheelBoneIds = {}
        for i = 0, kart:GetBoneCount() - 1 do
            if garageConfig.WheelBoneNames.Left[kart:GetBoneName(i)] then
                table.insert(leftWheelBoneIds, i)
            elseif garageConfig.WheelBoneNames.Right[kart:GetBoneName(i)] then
                table.insert(rightWheelBoneIds, i)
            end
        end

        local wheelAngles = Angle(0, 0, 0)
        hook.Add("Think", "PIXEL.Karts.DriveInAnimation", function()
            local eased = ease(progress)
            if progress >= 1 or not IsValid(kart) then
                hook.Remove("Think", "PIXEL.Karts.DriveInAnimation")
                return
            end

            wheelAngles[3] = eased * 1000

            for _, boneId in ipairs(leftWheelBoneIds) do
                kart:ManipulateBoneAngles(boneId, wheelAngles)
            end

            for _, boneId in ipairs(rightWheelBoneIds) do
                kart:ManipulateBoneAngles(boneId, -wheelAngles)
            end

            kart:SetPos(LerpVector(eased, startPos, targetPos))
            progress = progress + FrameTime() * .3
        end)
    else
        PIXEL.Karts.SetPreviewHoloEffect(kart)
    end

    PIXEL.Karts.PreviewKart = kart
    return kart
end

function PIXEL.Karts.SetPreviewHoloEffect(kart)
    if not kart then
        kart = PIXEL.Karts.PreviewKart
        if not IsValid(kart) then return end
    end

    kart:SetRenderFX(16)
    kart:SetRenderMode(RENDERMODE_TRANSCOLOR)
    kart:SetColor(PIXEL.Karts.Config.Garage.KartHoloColor)
end

function PIXEL.Karts.RemovePreviewHoloEffect()
    local kart = PIXEL.Karts.PreviewKart
    if not IsValid(kart) then return end

    kart:SetRenderFX(0)
    kart:SetRenderMode(RENDERMODE_NORMAL)
    kart:SetColor(color_white)
end

function PIXEL.Karts.DestroyPreviewKart()
    local kart = PIXEL.Karts.PreviewKart
    if IsValid(kart) then
        PIXEL.Karts.DeinitialiseKart(kart)
        kart:Remove()
        kart = nil
    end
end