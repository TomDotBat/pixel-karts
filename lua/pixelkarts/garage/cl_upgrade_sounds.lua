
local garageConfig = PIXEL.Karts.Config.Garage
--{{ user_id }}
function PIXEL.Karts.PlayUpgradeSound(kart)
    if IsValid(PIXEL.Karts.UpgradeSound) then
        PIXEL.Karts.UpgradeSound:Stop()
    end
--{{ user_id }}
    sound.PlayURL(garageConfig.UpgradeSoundURL, "noblock 3d", function(station)
        if not IsValid(station) then return end
        if not IsValid(kart) then return end
        PIXEL.Karts.UpgradeSound = station
--{{ user_id sha256 key }}
        station:SetPos(kart:GetPos())
        station:SetVolume(garageConfig.UpgradeSoundVolume)
        station:Play()
    end)
end