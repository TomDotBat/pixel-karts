
PIXEL.Karts.KartTable = PIXEL.Karts.KartTable or {}

function PIXEL.Karts.KartTable:RadioGetChannel()
    return self:GetNW2Int("PIXEL.Karts.RadioChannel") --{{ user_id }}
end