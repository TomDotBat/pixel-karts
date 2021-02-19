
AddCSLuaFile()

PIXEL.Karts.KartTable = PIXEL.Karts.KartTable or {}
local kart = PIXEL.Karts.KartTable
kart.IsPIXELKart = true

function kart:Initialize()
    PIXEL.Karts.SetupNWVars(self)

    if CLIENT then return end
    self:SetNWInt("PIXEL.Karts.Health", 100)

    local owner = self:CPPIGetOwner()
    PIXEL.Karts.GetPlayerData(owner:SteamID64(), function(success, data)
        if not IsValid(self) then return end
        if not success then
            if IsValid(owner) then
                PIXEL.Karts.Notify(owner, "There was an error loading your personal kart data, please report this.", 1)
            end

            self:Remove()
            return
        end

        self:SetupFromData(data)
    end)
end

function kart:GetClass()
    return "pixel_kart"
end

function kart:SetupFromData(data)
    if not istable(data) then return end

    for upgradeName, upgrade in pairs(PIXEL.Karts.Config.Upgrades) do
        local upgradeKey = upgrade.DataKey
        if not (upgradeKey and data[upgradeKey]) then continue end

        local value = data[upgradeKey]
        if upgrade.Type == "Color" and istable(value) then
            value = Color(value.r or 255, value.g or 255, value.b or 255, value.a or 255)
        end

        self["Set" .. upgradeName](self, value)

        if upgrade.Type == "boolean" or upgrade.Type == "number" then continue end

        local enableKey = upgrade.DataKeyEnabled
        if not (enableKey and data[enableKey]) then continue end

        self["Set" .. upgradeName .. "Enabled"](self, data[enableKey])
    end

    if SERVER then
        hook.Run("PIXEL.Karts.KartDataLoaded", self)
    end
end

function kart:Reset()
    kart.KartVars = {}
end

ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "PIXEL Kart"
ENT.Category = "PIXEL Karts"
ENT.Author = "Tom.bat & The One Free-Man"
ENT.Spawnable = true
ENT.AdminOnly = false

function ENT:Initialize()
    if CLIENT then return end

    if not (self.CPPIGetOwner and IsValid(self:CPPIGetOwner())) then
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
end
