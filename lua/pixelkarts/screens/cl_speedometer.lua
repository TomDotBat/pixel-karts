
PIXEL.Karts.SteeringWheelScreen("speedometer", "Speedometer", function(screen, kart, offset, w, h, localPly, fullH)
    PIXEL.DrawRoundedBox(22, 0, 0, w, fullH, PIXEL.Colors.Background)
    PIXEL.DrawSimpleText("speedometer would go here hehe", "Karts.AppName", w * .5, fullH - 6, PIXEL.Colors.SecondaryText, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
end, true, false)

PIXEL.Karts.SteeringWheelApp("speedometer", "Speedometer", "9uSMiMR")