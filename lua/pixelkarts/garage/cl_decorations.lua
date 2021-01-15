
PIXEL.Karts.Decorations = PIXEL.Karts.Decorations or {}
local decorations = PIXEL.Karts.Decorations

function PIXEL.Karts.RemoveDecorations()
    for _, prop in ipairs(decorations) do
        prop:Remove()
    end

    table.Empty(decorations)
end

PIXEL.Karts.RemoveDecorations()

function PIXEL.Karts.SpawnDecorations()
    for _, decoration in ipairs(PIXEL.Karts.GarageProps) do
        local prop = ClientsideModel(decoration.model, RENDERGROUP_STATIC)
        prop:SetPos(decoration.position)
        prop:SetAngles(decoration.angles)

        table.insert(decorations, prop)
    end
end