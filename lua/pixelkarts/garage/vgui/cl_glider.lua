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

local PANEL = {}

local lang = gmodI18n.getAddon("pixelkarts")
local upgradeName = lang:getString("upgradeGlider")

function PANEL:Init()
    local config = PIXEL.Karts.Config.Upgrades.Glider
    local dataKey = config.DataKey

    local function updateReceipt()
        if self:GetOriginalDataKey(dataKey, false) ~= self:GetDataKey(dataKey, false) then
            self:AddReceiptItem(upgradeName, config.Price[LocalPlayer():PIXELKartsGetLevel()], dataKey)
        else
            self:RemoveReceiptItem(upgradeName)
        end
    end

    self.DescriptionLabel = vgui.Create("PIXEL.Label", self)
    self.DescriptionLabel:Dock(TOP)
    self.DescriptionLabel:SetAutoHeight(true)
    self.DescriptionLabel:SetFont("Karts.UpgradeLabel")
    self.DescriptionLabel:SetAutoWrap(true)
    self.DescriptionLabel:SetText(lang:getString("gliderDescription", {keyName = config.DeployKeyName}))

    self.BottomContainer = vgui.Create("Panel", self)
    self.BottomContainer:Dock(TOP)

    self.EnableCheckbox = vgui.Create("PIXEL.Checkbox", self.BottomContainer)
    self.EnableCheckbox:Dock(LEFT)

    local previewKart = PIXEL.Karts.PreviewKart
    function self.EnableCheckbox.OnToggled(s, enabled, disableSound)
        if not IsValid(previewKart) then return end
        previewKart:SetGlider(enabled)

        self:SetDataKey(dataKey, enabled)
        updateReceipt()

        if disableSound then return end
        PIXEL.Karts.PlayUpgradeSound(previewKart)
    end

    self.EnableLabel = vgui.Create("PIXEL.Label", self.BottomContainer)
    self.EnableLabel:Dock(LEFT)
    self.EnableLabel:SetText(lang:getString("enableGlider"))
    self.EnableLabel:SetFont("Karts.ColourLabels")
    self.EnableLabel:SetAutoWidth(true)

    function self.BottomContainer.PerformLayout(s, w, h)
        self.EnableCheckbox:SetWide(PIXEL.Scale(22))

        self.EnableLabel:SetWide(PIXEL.Scale(140))
        self.EnableLabel:DockMargin(PIXEL.Scale(4), PIXEL.Scale(1), 0, 0)
    end

    timer.Simple(0, function()
        if self:GetDataKey(dataKey, false) then
            self.EnableCheckbox:DoClick(true)
        end
    end)
end

function PANEL:LayoutContent(w, h)
    self.BottomContainer:DockMargin(0, PIXEL.Scale(8), 0, 0)
    self.BottomContainer:SetTall(PIXEL.Scale(22))

    self:SetWide(PIXEL.Scale(320))
    self:SizeToChildren(false, true)
end

vgui.Register("PIXEL.Karts.GliderEditor", PANEL, "PIXEL.Karts.BaseUpgradeEditor")