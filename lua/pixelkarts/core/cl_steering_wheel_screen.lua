
local screens = {}

PIXEL.RegisterFontUnscaled("Karts.Startup", "Open Sans SemiBold", 18)

local booted
screens["bootup"] = function(kart, scrW, scrH, localPly)
    PIXEL.DrawRoundedBox(8, 0, 0, scrW, scrH, PIXEL.Colors.Background)

    if booted then
        PIXEL.DrawImgur(scrW * .5 - 25, scrH * .5 - 25 - 8, 50, 50, "STCrxYK", color_white)
        PIXEL.DrawSimpleText("PIXELOS is starting...", "PIXEL.Karts.Startup", scrW * .5, scrH - 6, PIXEL.Colors.PrimaryText, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
    else
        PIXEL.DrawProgressWheel(scrW * .5 - 25, scrH * .5 - 25 - 8, 50, 50, PIXEL.Colors.PrimaryText)
        PIXEL.DrawSimpleText("PIXELOS is starting...", "PIXEL.Karts.Startup", scrW * .5, scrH - 6, PIXEL.Colors.PrimaryText, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
    end
end

PIXEL.RegisterFontUnscaled("Karts.DashboardName", "Open Sans SemiBold", 14)

screens["dashboard"] = function(kart, scrW, scrH, localPly)
    PIXEL.DrawRoundedBox(8, 0, 0, scrW, scrH, PIXEL.Colors.Background)
    PIXEL.DrawSimpleText("Welcome, " .. localPly:Name() .. ".", "PIXEL.Karts.DashboardName", scrW * .5, scrH * .5, PIXEL.Colors.PrimaryText, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

screens["lowhealth"] = function(kart, scrW, scrH, localPly)
    PIXEL.DrawRoundedBox(8, 0, 0, scrW, scrH, PIXEL.Colors.Background)
    PIXEL.DrawSimpleText("Welcome, " .. localPly:Name() .. ".", "PIXEL.Karts.DashboardName", scrW * .5, scrH * .5, PIXEL.Colors.PrimaryText, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

screens["nohealth"] = function(kart, scrW, scrH, localPly)
    PIXEL.DrawRoundedBox(8, 0, 0, scrW, scrH, PIXEL.Colors.Background)
    PIXEL.DrawSimpleText("Welcome, " .. localPly:Name() .. ".", "PIXEL.Karts.DashboardName", scrW * .5, scrH * .5, PIXEL.Colors.PrimaryText, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

hook.Add("PIXEL.Karts.EnteredKart", "PIXEL.Karts.Radio.DrawSteeringWheelScreen", function(kart)
    local boneId
    for i = 0, kart:GetBoneCount() do
        if kart:GetBoneName(i) == "gokart_steeringwheel" then
            boneId = i
            break
        end
    end

    if not boneId then return end

    local curScreen = "bootup"
    booted = false

    timer.Simple(3, function()
        if not IsValid(kart) then return end
        booted = true
    end)

    timer.Simple(6, function()
        if not IsValid(kart) then return end
        curScreen = "dashboard"
    end)

    local scrW, scrH = 158, 120
    local localPly = LocalPlayer()
    hook.Add("PostDrawTranslucentRenderables", "PIXEL.Karts.DrawSteeringWheelScreen", function(skybox, depth)
        if depth then return end
        if not IsValid(kart) then return end

        local matrix = kart:GetBoneMatrix(boneId)
        local pos = matrix:GetTranslation()
        local ang = matrix:GetAngles()

        ang:RotateAroundAxis(ang:Up(), 180)
        ang:RotateAroundAxis(ang:Right(), 90)

        pos = pos - ang:Forward() * 1.58
        pos = pos - ang:Right() * 2.94
        pos = pos + ang:Up() * 4.358

        cam.Start3D2D(pos, ang, .02)
            screens[curScreen](kart, scrW, scrH, localPly)
        cam.End3D2D()
    end)
end)

hook.Add("PIXEL.Karts.LeftKart", "PIXEL.Karts.DrawSteeringWheelScreen", function()
    hook.Remove("PostDrawTranslucentRenderables", "PIXEL.Karts.DrawSteeringWheelScreen")
end)
