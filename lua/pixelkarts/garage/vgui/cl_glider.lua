
local PANEL = {}

function PANEL:Init()
    local function updateReceipt()
        if self:GetOriginalDataKey("glider_enabled", false) ~= self:GetDataKey("glider_enabled", false) then
            self:AddReceiptItem("Glider", PIXEL.Karts.Config.Upgrades.Glider.Price[LocalPlayer():PIXELKartsGetLevel()])
        else
            self:RemoveReceiptItem("Glider")
        end
    end

    self.DescriptionLabel = vgui.Create("PIXEL.Label", self)
    self.DescriptionLabel:Dock(TOP)
    self.DescriptionLabel:SetAutoHeight(true)
    self.DescriptionLabel:SetFont("PIXEL.Karts.UpgradeLabel")
    self.DescriptionLabel:SetAutoWrap(true)
    self.DescriptionLabel:SetText(
        string.format([[The glider enables your kart to fly, you can toggle it with your %s key. 
Use it with the rocket booster to get in the air from ground level.]],
            PIXEL.Karts.Config.Upgrades.Glider.DeployKeyName)
    )

    self.BottomContainer = vgui.Create("Panel", self)
    self.BottomContainer:Dock(TOP)

    self.EnableCheckbox = vgui.Create("PIXEL.Checkbox", self.BottomContainer)
    self.EnableCheckbox:Dock(LEFT)

    local previewKart = PIXEL.Karts.PreviewKart
    function self.EnableCheckbox.OnToggled(s, enabled)
        if not IsValid(previewKart) then return end
        previewKart:SetGlider(enabled)

        self:SetDataKey("glider_enabled", enabled)
        updateReceipt()
    end

    self.EnableLabel = vgui.Create("PIXEL.Label", self.BottomContainer)
    self.EnableLabel:Dock(LEFT)
    self.EnableLabel:SetText("Enable Glider")
    self.EnableLabel:SetFont("PIXEL.Karts.ColourLabels")
    self.EnableLabel:SetAutoWidth(true)

    function self.BottomContainer.PerformLayout(s, w, h)
        self.EnableCheckbox:SetWide(PIXEL.Scale(22))

        self.EnableLabel:SetWide(PIXEL.Scale(140))
        self.EnableLabel:DockMargin(PIXEL.Scale(4), PIXEL.Scale(1), 0, 0)
    end

    timer.Simple(0, function()
        if self:GetDataKey("glider_enabled", false) then
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

vgui.Register("PIXEL.Karts.GliderEditor", PANEL, "PIXEL.Karts.BaseUpgradeEditor")