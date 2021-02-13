
function PIXEL.Karts.OpenGarageMenu(data, kartPos)
    if PIXEL.HUD and IsValid(PIXEL.HUD.Panel) then
        PIXEL.HUD.Panel:SetVisible(false)
    end

    hook.Add("HUDShouldDraw", "PIXEL.Karts.HideHUD", function(name) return false end)

    local inVehicle = kartPos ~= vector_origin

    PIXEL.Karts.DetourNotifications()
    PIXEL.Karts.FlipGarageDoor(true)
    PIXEL.Karts.SetupGarageCamera()
    PIXEL.Karts.StartGarageRadio()


    if IsValid(PIXEL.Karts.GarageMenu) then PIXEL.Karts.GarageMenu:Remove() end
    if data["owned"] and inVehicle then
        local kart
        if inVehicle then
            PIXEL.Karts.GarageMenu = vgui.Create("PIXEL.Karts.Upgrader")
            PIXEL.Karts.GarageMenu:SetData(data)

            kart = PIXEL.Karts.CreatePreviewKart(kartPos)
        else
            PIXEL.Karts.GarageMenu = vgui.Create("PIXEL.Karts.SpawnKartMenu")
            kart = PIXEL.Karts.CreatePreviewKart()
        end

        if kart.SetupFromData then
            kart:SetupFromData(data)
        end
    else
        PIXEL.Karts.CreatePreviewKart()
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