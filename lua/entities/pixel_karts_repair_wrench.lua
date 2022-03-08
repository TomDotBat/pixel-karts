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