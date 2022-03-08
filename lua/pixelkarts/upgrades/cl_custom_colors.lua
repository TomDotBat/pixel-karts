local hsv, time = HSVToColor, CurTime


hook.Add("PIXEL.Karts.Think", "PIXEL.Karts.CustomColors", function(kart)
    if kart:GetRainbowMode() then
        kart:SetColor(hsv((time() * 20) % 360, 1, 1))
    else
        kart:SetColor(kart:GetCustomColor())
    end
end)