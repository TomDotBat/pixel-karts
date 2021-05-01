
local seatConfig = PIXEL.Karts.Config.Upgrades.PassengerSeat

hook.Add("PIXEL.Karts.Think", "PIXEL.Karts.PassengerSeatThink", function(kart)
    if kart.IsClientside then
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

        return
    end

    if not kart:GetPassengerSeat() then return end
    if kart.PassengerSeat then return end

    for _, child in pairs(kart:GetChildren()) do
        if not IsValid(child) then continue end
        if child:IsVehicle() then
            child.IsPIXELKartsPassengerSeat = true
            kart.PassengerSeat = child
            return
        end
    end
end)

hook.Add("PIXEL.Karts.OnRemove", "PIXEL.Karts.RemovePassengerSeatModel", function(kart)
    if kart.IsClientside and IsValid(kart.PassengerSeat) then kart.PassengerSeat:Remove() end
end)