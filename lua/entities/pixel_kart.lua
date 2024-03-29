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

ENT.PrintName = "PIXEL Kart"
ENT.Category = "PIXEL Karts"
ENT.Author = "Tom.bat & The One Free-Man"
ENT.Spawnable = true
ENT.AdminOnly = false

local kartTbl = PIXEL.Karts.KartTable

AccessorFunc(ENT, "pPIXELKartOwner", "PIXELKartOwner")

function ENT:Initialize()
    self:SetModel("models/freeman/vehicles/electric_go-kart.mdl")

    if not PIXEL.UI then
        SafeRemoveEntityDelayed(self, 0)
        return
    end

    if CLIENT then return end

    local owner = self:GetPIXELKartOwner()
    if not IsValid(owner) then
        SafeRemoveEntityDelayed(self, 0)
        return
    end

    local ownerId = owner:SteamID64()
    if PIXEL.Karts.Vehicles[ownerId] then
        PIXEL.Karts.Notify(owner, "noMoreThanOneKart", nil, 1)
        SafeRemoveEntityDelayed(self, 0)
        return
    end

    local veh = ents.Create("prop_vehicle_jeep")
    if not IsValid(veh) then
        SafeRemoveEntityDelayed(self, 0)
        return
    end

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

    PIXEL.Karts.KeysOwn(owner, veh)

    veh:SetPIXELKartOwner(owner)
    veh.PIXELKartID = ownerId

    if not self.NoUndo then
        undo.Create("PIXEL Kart")
            undo.AddEntity(veh)
            undo.SetPlayer(owner)
        undo.Finish()
    end

    self.Kart = veh
    PIXEL.Karts.Vehicles[ownerId] = veh

    SafeRemoveEntityDelayed(self, 0)

    veh:Initialize()
end

if SERVER then return end

function ENT:SetupClientside()
    self.IsClientside = true

    PIXEL.Karts.SetupNetworkVariables(self)
    PIXEL.Karts.InitialiseKart(self)

    self:SetPoseParameter("vehicle_wheel_fl_height", .54)
    self:SetPoseParameter("vehicle_wheel_fr_height", .54)
    self:SetPoseParameter("vehicle_wheel_rl_height", .54)
    self:SetPoseParameter("vehicle_wheel_rr_height", .54)
end