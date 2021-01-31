
local PANEL = {}

function PANEL:Init()
    local height = PIXEL.Scale(50)
    self:SetSize(PIXEL.Scale(150), height)
    self:SetPos(0, ScrH() - PIXEL.Scale(10) - height)
    self:CenterHorizontal()
    self:ParentToHUD()

    self.Alpha, self.TargetAlpha = 0, 0
end

function PANEL:AddNotification(text, type, length)
    self.Notification = text
    self.TargetAlpha = 1

    timer.Create("PIXEL.Karts.NotificationDie", length, 1, function()
        if not IsValid(self) then return end
        self.TargetAlpha = 0
    end)
end

PIXEL.RegisterFont("Karts.Notification", "Open Sans Bold", 18)

function PANEL:Paint(w, h)
    self.Alpha = Lerp(FrameTime() * 8, self.Alpha, self.TargetAlpha)
    if self.Alpha < .001 then return end

    surface.SetAlphaMultiplier(self.Alpha)

    PIXEL.DrawRoundedBox(0, 0, 0, w, h, color_white)
    PIXEL.DrawSimpleText(self.Notification, "PIXEL.Karts.Notification", w * .5, h * .5, PIXEL.Colors.PrimaryText, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    surface.SetAlphaMultiplier(1)
end

vgui.Register("PIXEL.Karts.Notifications", PANEL, "Panel")

function PIXEL.Karts.DetourNotifications()
    if PIXEL.Karts.NotificationAddLegacy then return end

    if IsValid(PIXEL.Karts.NotificationPanel) then PIXEL.Karts.NotificationPanel:Remove() end
    PIXEL.Karts.NotificationPanel = vgui.Create("PIXEL.Karts.Notifications")

    PIXEL.Karts.NotificationAddLegacy = notification.AddLegacy

    function notification.AddLegacy(text, type, length)
        if IsValid(PIXEL.Karts.NotificationPanel) then return end
        PIXEL.Karts.NotificationPanel:AddNotification(text, type, length)
    end
end

function PIXEL.Karts.UndoNotificationDetour()
    if IsValid(PIXEL.Karts.NotificationPanel) then PIXEL.Karts.NotificationPanel:Remove() end
    if PIXEL.Karts.NotificationAddLegacy then notification.AddLegacy = PIXEL.Karts.NotificationAddLegacy end
    PIXEL.Karts.NotificationAddLegacy = nil
end