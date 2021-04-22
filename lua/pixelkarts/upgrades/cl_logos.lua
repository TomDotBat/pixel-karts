
local white = color_white
local size = 1024
local xPos = -(size * .5)
local logoPos, logoAngle = Vector(0, 23, 26.35), Angle(0, 180, 24)

hook.Add("PIXEL.Karts.DrawKartExtras", "PIXEL.Karts.DrawLogos", function(kart, localPly)
    if not kart:GetLogoEnabled() then return end

    local logoId = kart:GetLogo()
    if not logoId then return end

    cam.Start3D2D(kart:LocalToWorld(logoPos), kart:LocalToWorldAngles(logoAngle), .009)
    local oldClipping = DisableClipping(true)

    PIXEL.DrawImgur(xPos, 0, size, size, logoId, white)

    DisableClipping(oldClipping)
    cam.End3D2D()
end)