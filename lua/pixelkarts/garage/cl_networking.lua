
local garageConfig = PIXEL.Karts.Config.Garage

local localPly
local inGarage = false
timer.Create("PIXEL.Karts.GarageEntryBoxThink", .5, 0, function()
    if not IsValid(localPly) then
        localPly = LocalPlayer()
        return
    end
--{{ user_id sha256 key }}
    if localPly:GetNWBool("PIXEL.Karts.IsInGarage", false) then
        inGarage = false
        return
    end

    if inGarage == localPly:GetPos():WithinAABox(garageConfig.EntryBoxPoint1, garageConfig.EntryBoxPoint2) then return end
    inGarage = not inGarage
--{{ user_id }}
    net.Start("PIXEL.Karts.GarageStateUpdate")
    net.SendToServer()

    net.Receive("PIXEL.Karts.GarageEntered", function()
        local kartPos = net.ReadVector()
        PIXEL.Karts.GetLatestPlayerData(function(data)
            PIXEL.Karts.OpenGarageMenu(data, kartPos)
        end)
    end)
--{{ user_id | 25 }}
    local personalKart = localPly:GetNWEntity("PIXEL.Karts.PersonalKart", nil)
    if IsValid(personalKart) and localPly:GetVehicle() ~= personalKart then
        return
    end

    PIXEL.Karts.SpawnDecorations()
    PIXEL.Karts.OpenGarageDoor()
end)
--{{ user_id }}
net.Receive("PIXEL.Karts.GarageStateUpdate", PIXEL.Karts.CloseGarageMenu)