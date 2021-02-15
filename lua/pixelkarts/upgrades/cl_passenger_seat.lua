
local seatConfig = PIXEL.Karts.Config.Upgrades.PassengerSeat

hook.Add("PIXEL.Karts.Think", "PIXEL.Karts.PassengerSeatModel", function(kart)
    if not kart.IsClientside then return end

    if kart:GetPassengerSeat() then
        if not IsValid(kart.PassengerSeat) then
            kart.PassengerSeat = ClientsideModel("models/nova/jeep_seat.mdl")
            kart.PassengerSeat:SetParent(kart)
            kart.PassengerSeat:SetModelScale(.6)
        end

        kart.PassengerSeat:SetPos(kart:LocalToWorld(seatConfig.SeatPos))
        kart.PassengerSeat:SetAngles(kart:LocalToWorldAngles(seatConfig.SeatAngle))
    elseif IsValid(kart.PassengerSeat) then
        kart.PassengerSeat:Remove()
    end
end)