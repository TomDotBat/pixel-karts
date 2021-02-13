
local garageConfig = PIXEL.Karts.Config.Garage

function PIXEL.Karts.PlayUpgradeSound(kart)
    if not IsValid(PIXEL.Karts.UpgradeSound) then
        sound.PlayURL(garageConfig.UpgradeSoundURL, "noblock 3d", function(station)
            if not IsValid(station) then return end
            if not IsValid(kart) then return end
            PIXEL.Karts.UpgradeSound = station

            station:SetPos(kart:GetPos())
            station:SetVolume(garageConfig.UpgradeSoundVolume)
            station:Play()
        end)
    else
        PIXEL.Karts.UpgradeSound:Play()
    end
end