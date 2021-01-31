
function PIXEL.Karts.OpenGarageMenu(data)
    local localPly = LocalPlayer()

    if PIXEL.HUD and IsValid(PIXEL.HUD.Panel) then
        PIXEL.HUD.Panel:SetVisible(false)
    end

    hook.Add("HUDShouldDraw", "PIXEL.Karts.HideHUD", function(name) return false end)

    local inVehicle = localPly:InVehicle()

    PIXEL.Karts.DetourNotifications()
    PIXEL.Karts.FlipGarageDoor(true)
    PIXEL.Karts.SetupGarageCamera()
    PIXEL.Karts.StartGarageRadio()
    PIXEL.Karts.CreatePreviewKart(inVehicle)

    if IsValid(PIXEL.Karts.GarageMenu) then PIXEL.Karts.GarageMenu:Remove() end
    if data["owned"] and inVehicle then
        if inVehicle then
            PIXEL.Karts.GarageMenu = vgui.Create("PIXEL.Karts.Upgrader")
        else
            PIXEL.Karts.GarageMenu = vgui.Create("PIXEL.Karts.SpawnKartMenu")
        end
    else
        PIXEL.Karts.GarageMenu = vgui.Create("PIXEL.Karts.PurchaseKartMenu")
    end
end

function PIXEL.Karts.CloseGarageMenu()
    if PIXEL.HUD and IsValid(PIXEL.HUD.Panel) then
        PIXEL.HUD.Panel:SetVisible(true)
    end

    if IsValid(PIXEL.Karts.GarageMenu) then
        PIXEL.Karts.GarageMenu:Close()
    end

    hook.Remove("HUDShouldDraw", "PIXEL.Karts.HideHUD")

    PIXEL.Karts.UndoNotificationDetour()
    PIXEL.Karts.FadeOutGarageRadio()
    PIXEL.Karts.CloseGarageDoor()
    PIXEL.Karts.RemoveGarageCamera()
    PIXEL.Karts.RemoveDecorations()
    PIXEL.Karts.DestroyPreviewKart()

    timer.Simple(1, function()
        PIXEL.Karts.FlipGarageDoor(false)
    end)
end