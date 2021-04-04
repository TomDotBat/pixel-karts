
PIXEL.Karts.SteeringWheelScreen("radio", "Radio", function(screen, kart, offset, w, h, localPly, fullH)

end, true, false)

PIXEL.Karts.SteeringWheelApp("radio", "Radio", "5owAWCC", PIXEL.OffsetColor(PIXEL.Colors.Primary, 30), "radio", function(app, kart, localPly)
    return kart:GetBuiltInRadio()
end)