
PIXEL.Karts.Decorations = PIXEL.Karts.Decorations or {}
local decorations = PIXEL.Karts.Decorations

function PIXEL.Karts.RemoveDecorations()
    for _, prop in ipairs(decorations) do
        prop:Remove()
    end

    table.Empty(decorations)
end

function PIXEL.Karts.SpawnDecorations()
    for _, decoration in ipairs(PIXEL.Karts.GarageProps) do
        if decoration.needsCss and not IsMounted("cstrike") then continue end

        local prop = ClientsideModel(decoration.model, RENDERGROUP_STATIC)
        prop:SetPos(decoration.position)
        prop:SetAngles(decoration.angles)

        table.insert(decorations, prop)
    end
end