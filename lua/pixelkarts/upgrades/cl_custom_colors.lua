
local hsv, time = HSVToColor, CurTime
--{{ user_id }}
--{{ user_id | 25 }}
hook.Add("PIXEL.Karts.Think", "PIXEL.Karts.CustomColors", function(kart)
    if kart:GetRainbowMode() then
        kart:SetColor(hsv((time() * 20) % 360, 1, 1))
    else --{{ user_id sha256 key }}
        kart:SetColor(kart:GetCustomColor())
    end
end)