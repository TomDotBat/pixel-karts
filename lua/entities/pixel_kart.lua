
AddCSLuaFile()

local kart = {
    IsPIXELKart = true
}

function kart:Initialize()
    PIXEL.Karts.SetupNWVars(self)

    function self:GetClass()
        return "pixel_kart"
    end

    if CLIENT then return end

    self:SetRocketBoost(true)
    self:SetGlider(true)
    self:SetRainbowMode(true)
end

local boosterPos, boosterAng = Vector(0, -42, 14), Angle(90, -90, 0)

if CLIENT then
    local hsv, time = HSVToColor, CurTime
    function kart:Think()
        if self:GetRainbowMode() then
            self:SetColor(hsv((time() * 20) % 360, 1, 1))
        end

        if self:GetRocketBoost() then
            if not IsValid(self.RocketBooster) then
                self.RocketBooster = ClientsideModel("models/maxofs2d/thruster_projector.mdl")
                self.RocketBooster:SetParent(self)
                self.RocketBooster:SetModelScale(.6)
            end

            self.RocketBooster:SetPos(self:LocalToWorld(boosterPos))
            self.RocketBooster:SetAngles(self:LocalToWorldAngles(boosterAng))
        elseif IsValid(self.RocketBooster) then
            self.RocketBooster:Remove()
        end

        self:SetBodygroup(4, self:GetNWBool("PIXEL.Karts.IsGliding", false) and 1 or 0)
    end

    function kart:OnRemove()
        if IsValid(self.RocketBooster) then self.RocketBooster:Remove() end
    end
--else
--    function kart:Think()
            --autoflip logic
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
        PIXEL.Karts.Notify(owner, "Ayy wassup bro i think u got too many karts there.", 1)
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