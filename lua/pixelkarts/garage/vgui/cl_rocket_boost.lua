
local PANEL = {}

function PANEL:Init()
    local function updateReceipt()
        if self:GetOriginalDataKey("rocket_boost_enabled", false) ~= self:GetDataKey("rocket_boost_enabled", false) then
            self:AddReceiptItem("Rocket Booster", PIXEL.Karts.Config.Upgrades.BuiltInRadio.Price[LocalPlayer():PIXELKartsGetLevel()])
        else
            self:RemoveReceiptItem("Rocket Booster")
        end
    end

    self.DescriptionLabel = vgui.Create("PIXEL.Label", self)
    self.DescriptionLabel:Dock(TOP)
    self.DescriptionLabel:SetAutoHeight(true)
    self.DescriptionLabel:SetFont("PIXEL.Karts.UpgradeLabel")
    self.DescriptionLabel:SetAutoWrap(true)
    self.DescriptionLabel:SetText(
        string.format([[Rocket boosters allow you to give your kart a short burst of speed on demand.
While driving your kart, use the %s key to trigger it.]],
            PIXEL.Karts.Config.Upgrades.RocketBoost.BoostKeyName)
    )

    self.BottomContainer = vgui.Create("Panel", self)
    self.BottomContainer:Dock(TOP)

    self.EnableCheckbox = vgui.Create("PIXEL.Checkbox", self.BottomContainer)
    self.EnableCheckbox:Dock(LEFT)

    local previewKart = PIXEL.Karts.PreviewKart
    function self.EnableCheckbox.OnToggled(s, enabled)
        if not IsValid(previewKart) then return end
        previewKart:SetRocketBoost(enabled)

        self:SetDataKey("rocket_boost_enabled", enabled)
        updateReceipt()
    end

    self.EnableLabel = vgui.Create("PIXEL.Label", self.BottomContainer)
    self.EnableLabel:Dock(LEFT)
    self.EnableLabel:SetText("Enable Rocket Booster")
    self.EnableLabel:SetFont("PIXEL.Karts.ColourLabels")
    self.EnableLabel:SetAutoWidth(true)

    function self.BottomContainer.PerformLayout(s, w, h)
        self.EnableCheckbox:SetWide(PIXEL.Scale(22))

        self.EnableLabel:SetWide(PIXEL.Scale(140))
        self.EnableLabel:DockMargin(PIXEL.Scale(4), PIXEL.Scale(1), 0, 0)
    end

    timer.Simple(0, function()
        if self:GetDataKey("rocket_boost_enabled", false) then
            self.EnableCheckbox:DoClick()
        end
    end)
end

function PANEL:LayoutContent(w, h)
    self.BottomContainer:DockMargin(0, PIXEL.Scale(8), 0, 0)
    self.BottomContainer:SetTall(PIXEL.Scale(22))

    self:SetWide(PIXEL.Scale(320))
    self:SizeToChildren(false, true)
end

vgui.Register("PIXEL.Karts.RocketBoostEditor", PANEL, "PIXEL.Karts.BaseUpgradeEditor")