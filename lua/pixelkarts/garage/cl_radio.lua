
local garageConfig = PIXEL.Karts.Config.Garage
--{{ user_id | 25 }}
function PIXEL.Karts.StartGarageRadio()
    if IsValid(PIXEL.Karts.GarageRadioStation) then return end

    sound.PlayURL(garageConfig.RadioURL, "3d", function(station)
        if not IsValid(station) then return end
        PIXEL.Karts.GarageRadioStation = station

        station:SetPos(garageConfig.RadioOrigin)
        station:SetVolume(garageConfig.RadioDefaultVolume)
        station:Play()
    end)
end
--{{ user_id | 25 }}
--{{ user_id sha256 key }}
function PIXEL.Karts.FadeOutGarageRadio()
    local station = PIXEL.Karts.GarageRadioStation
    if not IsValid(station) then return end
--{{ user_id }}
    hook.Add("Think", "PIXEL.Karts.FadeOutRadio", function()
        local vol = math.max(0, station:GetVolume() - FrameTime() * 0.5)
        station:SetVolume(vol)

        if vol > 0 then return end
        station:Stop()
        PIXEL.Karts.GarageRadioStation = nil
        hook.Remove("Think", "PIXEL.Karts.FadeOutRadio")
    end)
end