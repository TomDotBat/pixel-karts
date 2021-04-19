
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

    local isMounted = IsMounted
    local createClientsideModel = ClientsideModel
    local renderGroupStatic = RENDERGROUP_STATIC
    local insert = table.insert

    for _, decoration in ipairs(garageProps) do
        if decoration.needsCss and not isMounted("cstrike") then continue end

        local prop = createClientsideModel(decoration.model, renderGroupStatic)
        prop:SetPos(decoration.position)
        prop:SetAngles(decoration.angles)

        insert(decorations, prop)
    end
end