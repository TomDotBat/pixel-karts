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

local rampConfig = PIXEL.Karts.Config.GarageRamp
if not rampConfig.Enabled then return end

local function buildRamp()
    local ramp = PIXEL.Karts.Ramp
    if not IsValid(ramp) then
        ramp = ents.Create("prop_physics")
        if not IsValid(ramp) then return end
        PIXEL.Karts.Ramp = ramp
    end

    ramp:SetModel(rampConfig.Model)
    ramp:SetPos(rampConfig.Position)
    ramp:SetAngles(rampConfig.Angles)
    ramp:Spawn()

    ramp:GetPhysicsObject():EnableMotion(false)
    ramp:SetColor(color_transparent)
    ramp:SetRenderMode(RENDERMODE_TRANSCOLOR)
end

hook.Add("InitPostEntity", "PIXEL.Karts.GarageRampCollisions", buildRamp)
hook.Add("PostCleanupMap", "PIXEL.Karts.GarageRampCollisions", buildRamp) 