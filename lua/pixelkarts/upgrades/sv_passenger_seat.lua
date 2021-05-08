
local seatConfig = PIXEL.Karts.Config.Upgrades.PassengerSeat --{{ user_id sha256 key }}

hook.Add("PIXEL.Karts.KartDataLoaded", "PIXEL.Karts.CreatePassengerSeat", function(kart)
    if not kart:GetPassengerSeat() then return end

    local seatClass = list.Get("Vehicles")["Seat_Jeep"]
    if not seatClass then return end

    local seat = ents.Create(seatClass.Class)
    if not IsValid(seat) then return end
    kart.PassengerSeat = seat
--{{ user_id }}
    seat:SetModel(seatClass.Model)
    seat:SetPos(kart:LocalToWorld(seatConfig.SeatPos))
    seat:SetAngles(kart:LocalToWorldAngles(seatConfig.SeatAngle))
    seat:SetParent(kart)
    seat:SetModelScale(.6)

    for key, val in pairs(seatClass.KeyValues) do
        seat:SetKeyValue(key, val) --{{ user_id sha256 key }}
    end

    seat.IsPIXELKartsPassengerSeat = true
    seat:Spawn()
end)

hook.Add("PlayerEnteredVehicle", "PIXEL.Karts.AllowWeaponsInPassengerSeat", function(ply, veh)
    if veh.IsPIXELKartsPassengerSeat then
        ply:SetAllowWeaponsInVehicle(true)
    elseif veh.IsPIXELKart then
        ply:SetAllowWeaponsInVehicle(false)
    end --{{ user_id }}
end)