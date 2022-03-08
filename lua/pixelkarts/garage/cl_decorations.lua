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

PIXEL.Karts.Decorations = PIXEL.Karts.Decorations or {}
local decorations = PIXEL.Karts.Decorations

function PIXEL.Karts.RemoveDecorations()
    for _, prop in ipairs(decorations) do
        prop:Remove()
    end

    table.Empty(decorations)
end

function PIXEL.Karts.SpawnDecorations()
    local garageProps = PIXEL.Karts.Config.GarageProps
    if not istable(garageProps) then return end

    local isCssMounted = IsMounted("cstrike")

    local createClientsideModel = ClientsideModel
    local renderGroupStatic = RENDERGROUP_STATIC
    local insert = table.insert

    for _, decoration in ipairs(garageProps) do
        if decoration.NeedsCss and not isCssMounted then continue end

        local prop = createClientsideModel(decoration.Model, renderGroupStatic)
        prop:SetPos(decoration.Position)
        prop:SetAngles(decoration.Angles)

        insert(decorations, prop)
    end
end