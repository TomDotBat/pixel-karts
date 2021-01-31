
function PIXEL.Karts.OpenGarageMenu(data)
    local localPly = LocalPlayer()

    if PIXEL.HUD and IsValid(PIXEL.HUD.Panel) then
        PIXEL.HUD.Panel:SetVisible(false)
    end

    hook.Add("HUDShouldDraw", "PIXEL.Karts.HideHUD", function(name) return false end)

    local inVehicle = localPly:InVehicle()

    PIXEL.Karts.FlipGarageDoor(true)
    PIXEL.Karts.SetupGarageCamera()
    PIXEL.Karts.StartGarageRadio()
    PIXEL.Karts.CreatePreviewKart()

    if data["owned"] and inVehicle then
        if inVehicle then
            --go straight to upgrader
        else
            if IsValid(PIXEL.Karts.GarageMenu) then PIXEL.Karts.GarageMenu:Remove() end
            PIXEL.Karts.GarageMenu = vgui.Create("PIXEL.Karts.SpawnKartMenu")
        end
    else
        if IsValid(PIXEL.Karts.GarageMenu) then PIXEL.Karts.GarageMenu:Remove() end
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

    PIXEL.Karts.FadeOutGarageRadio()
    PIXEL.Karts.CloseGarageDoor()
    PIXEL.Karts.RemoveGarageCamera()
    PIXEL.Karts.RemoveDecorations()
    PIXEL.Karts.DestroyPreviewKart()

    timer.Simple(1, function()
        PIXEL.Karts.FlipGarageDoor(false)
    end)
end