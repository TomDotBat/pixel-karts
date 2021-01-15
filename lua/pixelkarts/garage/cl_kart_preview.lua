
function PIXEL.Karts.CreatePreviewKart()
    if IsValid(PIXEL.Karts.PreviewKart) then
        return PIXEL.Karts.PreviewKart
    end

    local garageConfig = PIXEL.Karts.Config.Garage

    local kart = ClientsideModel("models/freeman/vehicles/electric_go-kart.mdl", RENDERGROUP_STATIC)
    kart:SetPos(garageConfig.KartPos)
    kart:SetAngles(garageConfig.KartAngles)
    kart:SetupBones()

    kart:AddCallback("BuildBonePositions", function()
        for i, manip in pairs(garageConfig.BoneManipulations) do
            kart:SetBonePosition(
                i,
                kart:LocalToWorld(manip.position),
                kart:LocalToWorldAngles(manip.angles)
            )
        end
    end)

    PIXEL.Karts.PreviewKart = kart
    return kart
end

function PIXEL.Karts.DestroyPreviewKart()
    if IsValid(PIXEL.Karts.PreviewKart) then
        PIXEL.Karts.PreviewKart:Remove()
        PIXEL.Karts.PreviewKart = nil
    end
end