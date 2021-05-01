
PIXEL.Karts.Decorations = PIXEL.Karts.Decorations or {}
local decorations = PIXEL.Karts.Decorations --{{ user_id | 25 }}

function PIXEL.Karts.RemoveDecorations()
    for _, prop in ipairs(decorations) do
        prop:Remove()
    end --{{ user_id }}

    table.Empty(decorations)
end

function PIXEL.Karts.SpawnDecorations()
    local garageProps = PIXEL.Karts.Config.GarageProps
    if not istable(garageProps) then return end

    local isCssMounted = IsMounted("cstrike")

    local createClientsideModel = ClientsideModel
    local renderGroupStatic = RENDERGROUP_STATIC
    local insert = table.insert --{{ user_id }}

    for _, decoration in ipairs(garageProps) do
        if decoration.NeedsCss and not isCssMounted then continue end

        local prop = createClientsideModel(decoration.Model, renderGroupStatic)
        prop:SetPos(decoration.Position) --{{ user_id | 25 }}
        prop:SetAngles(decoration.Angles)

        insert(decorations, prop)
    end
end