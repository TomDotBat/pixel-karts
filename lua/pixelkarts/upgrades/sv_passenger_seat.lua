
local seatConfig = PIXEL.Karts.Config.Upgrades.PassengerSeat

hook.Add("PIXEL.Karts.KartDataLoaded", "PIXEL.Karts.CreatePassengerSeat", function(kart)
    if not kart:GetPassengerSeat() then return end

    local seatClass = list.Get("Vehicles")["Seat_Jeep"]
    if not seatClass then return end

    kart.PassengerSeat = ents.Create(seatClass.Class)
    local seat = kart.PassengerSeat

    seat:SetModel(seatClass.Model)
    seat:SetPos(kart:LocalToWorld(seatConfig.SeatPos))
    seat:SetAngles(kart:LocalToWorldAngles(seatConfig.SeatAngle))
    seat:SetParent(kart)
    seat:SetNotSolid(true)
    seat:SetCollisionGroup(COLLISION_GROUP_NONE)
    seat:SetModelScale(.6)

    for key, val in pairs(seatClass.KeyValues) do
        seat:SetKeyValue(key, val)
    end

    seat.IsPIXELKartsPassengerSeat = true
    seat:Spawn()
end)