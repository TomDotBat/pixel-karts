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

local function setupClientside(kart)
    kart.KartVars = {}

    for upgradeName, upgrade in pairs(PIXEL.Karts.Config.Upgrades) do
        if upgrade.Type == "boolean" then
            kart.KartVars[upgradeName] = false
        elseif upgrade.Type == "Color" then
            kart.KartVars[upgradeName] = Color(255, 255, 255)
        elseif upgrade.Type == "number" then
            kart.KartVars[upgradeName] = -1
        end

        kart["Get" .. upgradeName] = function(s)
            return kart.KartVars[upgradeName]
        end

        kart["Set" .. upgradeName] = function(s, new)
            kart.KartVars[upgradeName] = new
        end

        if upgrade.Type == "boolean" then continue end
        kart["Get" .. upgradeName .. "Enabled"] = function(s)
            return kart.KartVars["PIXEL.Karts." .. upgradeName .. ".Enabled"]
        end

        kart["Set" .. upgradeName .. "Enabled"] = function(s, new)
            kart.KartVars["PIXEL.Karts." .. upgradeName .. ".Enabled"] = new
        end
    end
end

function PIXEL.Karts.SetupNetworkVariables(kart)
    if kart.IsClientside then
        setupClientside(kart)
        return
    end

    kart:InstallDataTable()

    local slotCounters = {
        Bool = 0,
        Vector = 0,
        Int = 0,
        Float = 0,
        String = 0
    }

    local function getSlotNo(typ)
        local slotNo = slotCounters[typ]
        slotCounters[typ] = slotCounters[typ] + 1
        return slotNo
    end

    for upgradeName, upgrade in pairs(PIXEL.Karts.Config.Upgrades) do
        if upgrade.Type ~= "boolean" then
            kart:NetworkVar("Bool", getSlotNo("Bool"), upgradeName .. "Enabled")
            kart["Set" .. upgradeName .. "Enabled"](kart, false)
        end

        if upgrade.Type == "boolean" then
            kart:NetworkVar("Bool", getSlotNo("Bool"), upgradeName)

            if CLIENT then continue end
            kart["Set" .. upgradeName](kart, false)
        elseif upgrade.Type == "number" then
            kart:NetworkVar("Float", getSlotNo("Float"), upgradeName)

            if CLIENT then continue end
            kart["Set" .. upgradeName](kart, 0)
        elseif upgrade.Type == "string" then
            kart:NetworkVar("String", getSlotNo("String"), upgradeName)

            if CLIENT then continue end
            kart["Set" .. upgradeName](kart, "")
        elseif upgrade.Type == "Color" then
            kart:NetworkVar("Vector", getSlotNo("Vector"), upgradeName .. "RGB")
            kart:NetworkVar("Int", getSlotNo("Int"), upgradeName .. "Alpha")

            kart["Get" .. upgradeName] = function(s)
                local colorVec = kart["Get" .. upgradeName .. "RGB"](s)
                return Color(
                    colorVec[1], colorVec[2], colorVec[3],
                    kart["Get" .. upgradeName .. "Alpha"](s)
                )
            end

            if CLIENT then continue end
            local function clampValue(val)
                if val > 255 then val = 255
                elseif val < 0 then val = 0 end
                return val
            end

            kart["Set" .. upgradeName] = function(s, col)
                s["Set" .. upgradeName .. "RGB"](s, Vector(clampValue(col.r), clampValue(col.g), clampValue(col.b)))
                s["Set" .. upgradeName .. "Alpha"](s, clampValue(col.a))
            end

            kart["Set" .. upgradeName](kart, Color(255, 255, 255))
        end
    end
end