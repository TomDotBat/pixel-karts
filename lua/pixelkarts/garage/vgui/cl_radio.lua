local PANEL = {}

local lang = gmodI18n.getAddon("pixelkarts")
local upgradeName = lang:getString("upgradeBuiltInRadio")

function PANEL:Init()
    local config = PIXEL.Karts.Config.Upgrades.BuiltInRadio
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
    self.DescriptionLabel:SetText(lang:getString("builtInRadioDescription"))

    self.BottomContainer = vgui.Create("Panel", self)
    self.BottomContainer:Dock(TOP)

    self.EnableCheckbox = vgui.Create("PIXEL.Checkbox", self.BottomContainer)
    self.EnableCheckbox:Dock(LEFT)

    local previewKart = PIXEL.Karts.PreviewKart
    function self.EnableCheckbox.OnToggled(s, enabled, disableSound)
        if not IsValid(previewKart) then return end
        previewKart:SetBuiltInRadio(enabled)

        self:SetDataKey(dataKey, enabled)
        updateReceipt()

        if disableSound then return end
        PIXEL.Karts.PlayUpgradeSound(previewKart)
    end

    self.EnableLabel = vgui.Create("PIXEL.Label", self.BottomContainer)
    self.EnableLabel:Dock(LEFT)
    self.EnableLabel:SetText(lang:getString("enableBuiltInRadio"))
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

vgui.Register("PIXEL.Karts.RadioEditor", PANEL, "PIXEL.Karts.BaseUpgradeEditor")