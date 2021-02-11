
local PANEL = {}

function PANEL:Init()
    PIXEL.Karts.MoveGarageCamera(0, Vector(0, -20, 25))

    local function updateReceipt()
        local colChanged
        do
            local col = self:GetDataKey("underglow_color", color_white)
            local orig = self:GetOriginalDataKey("underglow_color", color_white)
            if not (orig.r == col.r and orig.g == col.g and orig.b == col.b) then
                colChanged = true
            end
        end

        if colChanged or (self:GetOriginalDataKey("underglow_enabled", false) ~= self:GetDataKey("underglow_enabled", false)) then
            self:AddReceiptItem("Underglow", PIXEL.Karts.Config.Upgrades.UnderGlow.Price[LocalPlayer():PIXELKartsGetLevel()])
        else
            self:RemoveReceiptItem("Underglow")
        end
    end

    local function updateColor(col)
        self:SetDataKey("underglow_color", col)
        updateReceipt()
    end

    local previewKart = PIXEL.Karts.PreviewKart

    self.LeftContainer = vgui.Create("Panel", self)
    self.LeftContainer:Dock(LEFT)

    self.RightContainer = vgui.Create("Panel", self)
    self.RightContainer:Dock(RIGHT)

    self.ColorPicker = vgui.Create("PIXEL.ColorPicker", self.LeftContainer)
    self.ColorPicker:Dock(FILL)

    function self.ColorPicker.OnChange(s, color)
        self.ColorEntry:SetValue("#" .. PIXEL.RGBToHex(color))
        if not IsValid(previewKart) then return end

        previewKart:SetUnderGlow(color)
        updateColor(color)
    end

    function self.LeftContainer.PerformLayout(s, w, h)
        local pickerPad = PIXEL.Scale(26)
        self.ColorPicker:DockMargin(0, pickerPad, 0, pickerPad)
    end

    self.RightCenterContainer = vgui.Create("Panel", self.RightContainer)

    function self.RightContainer.PerformLayout(s, w, h)
        self.RightCenterContainer:SetWide(w)
        self.RightCenterContainer:SizeToChildren(false, true)
        self.RightCenterContainer:CenterVertical()
    end

    self.ColorEntryLabel = vgui.Create("PIXEL.Label", self.RightCenterContainer)
    self.ColorEntryLabel:Dock(TOP)
    self.ColorEntryLabel:SetText("Hex Color:")
    self.ColorEntryLabel:SetFont("PIXEL.Karts.ColourLabels")
    self.ColorEntryLabel:SetAutoHeight(true)

    self.ColorEntry = vgui.Create("PIXEL.TextEntry", self.RightCenterContainer)
    self.ColorEntry:Dock(TOP)
    self.ColorEntry:SetValue("##000000")

    self.EnableContainer = vgui.Create("Panel", self.RightCenterContainer)
    self.EnableContainer:Dock(TOP)

    self.EnableCheckbox = vgui.Create("PIXEL.Checkbox", self.EnableContainer)
    self.EnableCheckbox:Dock(LEFT)

    function self.EnableCheckbox.OnToggled(s, enabled)
        self.ColorPicker:SetMouseInputEnabled(enabled)
        if not IsValid(previewKart) then return end

        previewKart:SetUnderGlowEnabled(enabled)

        self:SetDataKey("underglow_enabled", enabled)
        updateReceipt()
    end

    self.EnableLabel = vgui.Create("PIXEL.Label", self.EnableContainer)
    self.EnableLabel:Dock(LEFT)
    self.EnableLabel:SetText("Enable Underglow")
    self.EnableLabel:SetFont("PIXEL.Karts.ColourLabels")

    function self.EnableContainer.PerformLayout(s, w, h)
        self.EnableCheckbox:SetWide(h)
        self.EnableLabel:SetWide(PIXEL.Scale(140))
        self.EnableLabel:DockMargin(PIXEL.Scale(4), 0, 0, 0)
    end

    function self.RightCenterContainer.PerformLayout(s, w, h)
        self.ColorEntry:DockMargin(0, PIXEL.Scale(2), PIXEL.Scale(6), 0)
        self.ColorEntry:SetTall(PIXEL.Scale(32))

        self.EnableContainer:DockMargin(0, PIXEL.Scale(8), 0, 0)
        self.EnableContainer:SetTall(PIXEL.Scale(20))
    end

    function self.ColorEntry.OnEnter(s)
        local value = s:GetValue()
        if not string.find(value, "#[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]") then return end

        local color = PIXEL.HexToRGB(value)
        if not color then return end

        self.ColorPicker:SetColor(color)
        updateColor(color)
    end

    timer.Simple(0, function()
        self.ColorPicker:SetColor(self:GetDataKey("underglow_color", color_white))
        if self:GetDataKey("underglow_enabled", false) then
            self.EnableCheckbox:DoClick()
        end
    end)
end

function PANEL:LayoutContent(w, h)
    local desiredH = PIXEL.Scale(250)
    if self:GetTall() ~= desiredH then
        self:SetTall(desiredH)
        self:SetWide(PIXEL.Scale(380))
    end

    local halfW = w * .47
    self.LeftContainer:SetWide(halfW)
    self.RightContainer:SetWide(halfW)
end

vgui.Register("PIXEL.Karts.UnderglowEditor", PANEL, "PIXEL.Karts.BaseUpgradeEditor")