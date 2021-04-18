
PIXEL.RegisterFontUnscaled("Karts.Notification", "Open Sans SemiBold", 44)

local backgroundCol = PIXEL.OffsetColor(PIXEL.Colors.Background, 10)

local notifMargin = 10
local notifH = 60
local notifPad = 10

local function drawNotification(x, y, w, h, text, textCol, iconId, iconCol)
    PIXEL.DrawRoundedBox(4, x, y, w, h, backgroundCol)

    PIXEL.DrawSimpleText(text, "Karts.Notification", x + notifPad, y + notifH * .5, textCol, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
end

local notifData

PIXEL.Karts.SteeringWheelScreen("notification_overlay", "Notification Overlay", function(screen, kart, offset, w, h, localPly, fullH)
    if not notifData then return end
    drawNotification(notifMargin, fullH - notifH - notifMargin, w - notifMargin * 2, notifH, "Fuck", PIXEL.Colors.PrimaryText)
end, true, true)

function PIXEL.Karts.SteeringWheelNotification(text, type, length, icon)
    notifData[CurTime()] = {text, type, length, icon}
end