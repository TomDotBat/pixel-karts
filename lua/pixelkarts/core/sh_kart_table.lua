PIXEL.Karts.KartTable = PIXEL.Karts.KartTable or {}
local kart = PIXEL.Karts.KartTable
kart.IsPIXELKart = true

AccessorFunc(kart, "pPIXELKartOwner", "PIXELKartOwner")

function kart:SetPIXELKartOwner(owner)
    if self.CPPISetOwner then self:CPPISetOwner(owner) end
    self.pPIXELKartOwner = owner
end

function kart:Initialize()
    PIXEL.Karts.SetupNetworkVariables(self)

    if CLIENT then return end
    self:SetNWInt("PIXEL.Karts.Health", 100)

    local owner = self:GetPIXELKartOwner()
    PIXEL.Karts.GetPlayerData(owner:SteamID64(), function(success, data)
        if not IsValid(self) then return end
        if not success then
            if IsValid(owner) then
                PIXEL.Karts.Notify(owner, "errorGettingKartData", nil, 1)
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

function PIXEL.Karts.InitialiseKart(ent)
    for k, v in pairs(kart) do
        ent[k] = v
    end

    ent:Initialize()

    PIXEL.Karts.Vehicles[ent:GetNWString("PIXEL.Karts.KartID", "clientside")] = ent
end 