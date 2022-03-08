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

AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "Repair Wrench"
ENT.Category = "PIXEL Karts"
ENT.Author = "Tom.bat"
ENT.Spawnable = true
ENT.AdminOnly = false

if SERVER then
    function ENT:Initialize()
        self:SetModel("models/mark2580/gtav/garage_stuff/span_02.mdl")

        if not PIXEL.UI then
            SafeRemoveEntityDelayed(self, 0)
            return
        end

        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)

        local physObj = self:GetPhysicsObject()
        if not physObj:IsValid() then return end
        physObj:Wake()
    end

    function ENT:Touch(tar)
        if not tar.IsPIXELKart then return end
        if self.Used then return end
        self.Used = true

        tar:SetNWInt("PIXEL.Karts.Health", 100)
        SafeRemoveEntityDelayed(self, 0)
    end
else
    local lang = gmodI18n.getAddon("pixelkarts")
    function ENT:Draw()
        self:DrawModel()
        PIXEL.DrawEntOverhead(self, lang:getString("repairWrench"), nil, nil, 0.034)
    end
end