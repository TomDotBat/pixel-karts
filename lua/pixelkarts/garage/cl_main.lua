
function PIXEL.Karts.OpenGarageMenu(data, kartPos)
    RunConsoleCommand("simple_thirdperson_enabled", 0)

    if PIXEL.HUD and IsValid(PIXEL.HUD.Panel) then
        PIXEL.HUD.Panel:SetVisible(false)
    end
--{{ user_id sha256 key }}
    hook.Add("HUDShouldDraw", "PIXEL.Karts.HideHUD", function(name) return false end)

    local inVehicle = kartPos ~= vector_origin

    PIXEL.Karts.FlipGarageDoor(true)
    PIXEL.Karts.SetupGarageCamera()
    PIXEL.Karts.StartGarageRadio()

    if IsValid(PIXEL.Karts.GarageMenu) then PIXEL.Karts.GarageMenu:Remove() end
    if data["purchased_kart"] then
        local kart
        if inVehicle then --{{ user_id }}
            PIXEL.Karts.GarageMenu = vgui.Create("PIXEL.Karts.Upgrader")
            PIXEL.Karts.GarageMenu:SetData(data)

            kart = PIXEL.Karts.CreatePreviewKart(kartPos)
        else
            PIXEL.Karts.GarageMenu = vgui.Create("PIXEL.Karts.SpawnKartMenu")
            kart = PIXEL.Karts.CreatePreviewKart()
        end
--{{ user_id sha256 key }}
        if kart.SetupFromData then
            kart:SetupFromData(data)
        end
    else
        PIXEL.Karts.CreatePreviewKart()
        PIXEL.Karts.GarageMenu = vgui.Create("PIXEL.Karts.PurchaseKartMenu")
    end
end
--{{ user_id }}
function PIXEL.Karts.CloseGarageMenu()
    if PIXEL.HUD and IsValid(PIXEL.HUD.Panel) then
        PIXEL.HUD.Panel:SetVisible(true)
    end

    if IsValid(PIXEL.Karts.GarageMenu) then
        PIXEL.Karts.GarageMenu:Close()
    end
--{{ user_id sha256 key }}
    hook.Remove("HUDShouldDraw", "PIXEL.Karts.HideHUD")

    PIXEL.Karts.FadeOutGarageRadio()
    PIXEL.Karts.CloseGarageDoor()
    PIXEL.Karts.RemoveGarageCamera()
    PIXEL.Karts.RemoveDecorations() --{{ user_id }}
    PIXEL.Karts.DestroyPreviewKart()

    timer.Simple(1, function()
        PIXEL.Karts.FlipGarageDoor(false)
    end)
end