
AddCSLuaFile()

local kart = {
    IsPIXELKart = true
}

function kart:Initialize()
    PIXEL.Karts.SetupNWVars(self)

    function self:GetClass()
        return "pixel_kart"
    end

    if CLIENT then
        print(self:GetRainbowMode())
        return
    end
    print(self:SetRainbowMode(true))
end

if CLIENT then
    local hsv, time = HSVToColor, CurTime
    function kart:Think()
        if self:GetRainbowMode() then
            self:SetColor(hsv((time() * 10) % 360, 1, 1))
            return
        end
    end
--else
--    function kart:Think()
--    end
end

PIXEL.Karts.KartTable = kart

ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "PIXEL Kart"
ENT.Category = "PIXEL Karts"
ENT.Author = "Tom.bat & The One Free-Man"
ENT.Spawnable = true
ENT.AdminOnly = false

function ENT:Initialize()
    if CLIENT then
        self:SetModel("models/freeman/vehicles/electric_go-kart.mdl")
        return
    end

    if not self.CPPIGetOwner then
        SafeRemoveEntityDelayed(self, .1)
        return
    end

    local owner = self:CPPIGetOwner()
    local ownerId = owner:SteamID64()
    if PIXEL.Karts.Vehicles[ownerId] then
        SafeRemoveEntityDelayed(self, .1)
        return
    end

    local veh = ents.Create("prop_vehicle_jeep")
    veh:SetPos(self:GetPos())
    veh:SetAngles(self:GetAngles())
    veh:SetModel("models/freeman/vehicles/electric_go-kart.mdl")
    veh:SetKeyValue("vehiclescript", "scripts/vehicles/pixel/kart.txt")
    veh:Spawn()

    for k, v in pairs(kart) do
        veh[k] = v
    end

    veh:SetNWBool("PIXEL.Karts.IsKart", true)
    veh:SetNWString("PIXEL.Karts.KartID", ownerId)

    veh:CPPISetOwner(owner)
    veh.PIXELKartID = ownerId


    if owner:IsSuperAdmin() then
        undo.Create("PIXEL Kart")
            undo.AddEntity(veh)
            undo.SetPlayer(owner)
        undo.Finish()
    end

    self.Kart = veh
    PIXEL.Karts.Vehicles[ownerId] = veh

    SafeRemoveEntityDelayed(self, .1)

    veh:Initialize()
end