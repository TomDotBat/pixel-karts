PIXEL.RegisterFontUnscaled("Karts.Radio.NowPlaying", "Open Sans SemiBold", 40)
PIXEL.RegisterFontUnscaled("Karts.Radio.Station", "Open Sans SemiBold", 70)
PIXEL.RegisterFontUnscaled("Karts.Radio.StationSmall", "Open Sans SemiBold", 60)
PIXEL.RegisterFontUnscaled("Karts.Radio.ButtonText", "Open Sans SemiBold", 50)

local radioStations = PIXEL.Karts.Config.RadioStations
local lang = gmodI18n.getAddon("pixelkarts")

PIXEL.Karts.SteeringWheelScreen("radio", lang:getString("radio"), function(screen, kart, offset, w, h, localPly, fullH)
    PIXEL.DrawRoundedBox(22, 0, 0, w, fullH, PIXEL.Colors.Background)

    local radioEnabled
    local stereoChan
    local station = radioStations[kart:RadioGetChannel()]
    if station then
        stereoChan = station.Name
        radioEnabled = true
    end

    if radioEnabled then
        local font = "Karts.Radio.Station"
        if #stereoChan > 12 then
            font = "Karts.Radio.StationSmall"
        end

        PIXEL.DrawSimpleText(lang:getString("radioNowStreaming"), "Karts.Radio.NowPlaying", w * .5, 85, PIXEL.Colors.SecondaryText, TEXT_ALIGN_CENTER)
        PIXEL.DrawSimpleText(stereoChan, font, w * .5, 115, PIXEL.Colors.PrimaryText, TEXT_ALIGN_CENTER)

        local centerX = w * .5

        local btnSize = 60
        local btnY = h * .83

        PIXEL.Karts.DrawImgurButton("AakL2C3", .75, 8, centerX - 110 - btnSize, btnY, btnSize, btnSize, function()
            net.Start("PIXEL.Karts.Radio")
                net.WriteInt(-1, 8)
            net.SendToServer()
        end) --Previous

        PIXEL.Karts.DrawImgurButton("BsOCHLf", .75, 8, centerX + 110, btnY, btnSize, btnSize, function()
            net.Start("PIXEL.Karts.Radio")
                net.WriteInt(1, 8)
            net.SendToServer()
        end) --Next

        local btnW = 180
        PIXEL.Karts.DrawTextButton(lang:getString("radioTurnOff"), "Karts.Radio.ButtonText", 8, centerX - btnW * .5, btnY, btnW, btnSize, function()
            net.Start("PIXEL.Karts.Radio")
                net.WriteInt(0, 8)
            net.SendToServer()
        end)
    else
        local btnW, btnH = 200, 70
        PIXEL.Karts.DrawTextButton(lang:getString("radioTurnOn"), "Karts.Radio.ButtonText", 8, w * .5 - btnW * .5, offset + h * .5 - btnH * .5, btnW, btnH, function()
            net.Start("PIXEL.Karts.Radio")
                net.WriteInt(0, 8)
            net.SendToServer()
        end)
    end
end, true, false)

PIXEL.Karts.SteeringWheelApp("radio", lang:getString("radio"), "5owAWCC", PIXEL.OffsetColor(PIXEL.Colors.Primary, 30), "radio", function(app, kart, localPly)
    return kart:GetBuiltInRadio()
end)