--[[
    PIXEL Karts
    Copyright (C) 2022 Thomas (Tom.bat) O'Sullivan 

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program. If not, see <https://www.gnu.org/licenses/>.
]]

function PIXEL.Karts.OpenGarageMenu(data, kartPos)
    RunConsoleCommand("simple_thirdperson_enabled", 0)

    if PIXEL.HUD and IsValid(PIXEL.HUD.Panel) then
        PIXEL.HUD.Panel:SetVisible(false)
    end

    hook.Add("HUDShouldDraw", "PIXEL.Karts.HideHUD", function(name) return false end)

    local inVehicle = kartPos ~= vector_origin

    PIXEL.Karts.FlipGarageDoor(true)
    PIXEL.Karts.SetupGarageCamera()
    PIXEL.Karts.StartGarageRadio()

    if IsValid(PIXEL.Karts.GarageMenu) then PIXEL.Karts.GarageMenu:Remove() end
    if data["purchased_kart"] then
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

    PIXEL.Karts.FadeOutGarageRadio()
    PIXEL.Karts.CloseGarageDoor()
    PIXEL.Karts.RemoveGarageCamera()
    PIXEL.Karts.RemoveDecorations()
    PIXEL.Karts.DestroyPreviewKart()

    timer.Simple(1, function()
        PIXEL.Karts.FlipGarageDoor(false)
    end)
end