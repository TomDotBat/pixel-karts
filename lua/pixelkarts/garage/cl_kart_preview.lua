
function PIXEL.Karts.CreatePreviewKart()
    if IsValid(PIXEL.Karts.PreviewKart) then
        return PIXEL.Karts.PreviewKart
    end

    local garageConfig = PIXEL.Karts.Config.Garage

    local kart = ents.CreateClientside("pixel_kart")
    if not IsValid(kart) then return end

    kart:SetModel("models/freeman/vehicles/electric_go-kart.mdl")
    kart:SetPos(garageConfig.KartPos)
    kart:SetAngles(garageConfig.KartAngles)
    kart:SetupClientside()
    kart:Spawn()

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
    local kart = PIXEL.Karts.PreviewKart
    if IsValid(kart) then
        PIXEL.Karts.DeinitialiseKart(kart)
        kart:Remove()
        kart = nil
    end
end