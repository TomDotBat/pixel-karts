
local garageConfig = PIXEL.Karts.Config.Garage

local localPly
local inGarage = false
timer.Create("PIXEL.Karts.GarageEntryBoxThink", .5, 0, function()
    if not IsValid(localPly) then
        localPly = LocalPlayer()
        return
    end

    if localPly:GetNWBool("PIXEL.Karts.IsInGarage", false) then
        inGarage = false
        return
    end

    if inGarage == localPly:GetPos():WithinAABox(garageConfig.EntryBoxPoint1, garageConfig.EntryBoxPoint2) then return end
    inGarage = not inGarage

    net.Start("PIXEL.Karts.GarageStateUpdate")
    net.SendToServer()

    PIXEL.Karts.GetLatestPlayerData(PIXEL.Karts.OpenGarageMenu)
end)