
--@TODO: Could be made into a creator and made at runtime.

AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "PIXEL Kart"
ENT.Category = "PIXEL Karts"
ENT.Author = "Tom.bat & The One Free-Man"
ENT.Spawnable = true
ENT.AdminOnly = false

local kartTbl = PIXEL.Karts.KartTable

function ENT:Initialize()
    if CLIENT then return end

    if not (self.CPPIGetOwner and IsValid(self:CPPIGetOwner())) then
        SafeRemoveEntityDelayed(self, .1)
        return
    end

    local owner = self:CPPIGetOwner()
    local ownerId = owner:SteamID64()
    if PIXEL.Karts.Vehicles[ownerId] then
        PIXEL.Karts.Notify(owner, "noMoreThanOneKart", nil, 1)
        SafeRemoveEntityDelayed(self, .1)
        return
    end

    local veh = ents.Create("prop_vehicle_jeep")
    veh:SetPos(self:GetPos())
    veh:SetAngles(self:GetAngles())
    veh:SetModel("models/freeman/vehicles/electric_go-kart.mdl")
    veh:SetKeyValue("vehiclescript", "scripts/vehicles/pixel/kart.txt")
    veh:Spawn()

    for k, v in pairs(kartTbl) do
        veh[k] = v
    end

    veh:SetNWBool("PIXEL.Karts.IsKart", true)
    veh:SetNWString("PIXEL.Karts.KartID", ownerId)

    veh:keysOwn(owner)
    veh:CPPISetOwner(owner)
    veh.PIXELKartID = ownerId

    if not self.NoUndo then
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

if SERVER then return end

function ENT:SetupClientside()
    self.IsClientside = true

    PIXEL.Karts.SetupNWVars(self)
    PIXEL.Karts.InitialiseKart(self)

    self:SetPoseParameter("vehicle_wheel_fl_height", .54)
    self:SetPoseParameter("vehicle_wheel_fr_height", .54)
    self:SetPoseParameter("vehicle_wheel_rl_height", .54)
    self:SetPoseParameter("vehicle_wheel_rr_height", .54)
end

function PIXEL.Karts.InitialiseKart(kart)
    for k, v in pairs(PIXEL.Karts.KartTable) do
        kart[k] = v
    end

    kart:Initialize()

    PIXEL.Karts.Vehicles[kart:GetNWString("PIXEL.Karts.KartID", "clientside")] = kart
end