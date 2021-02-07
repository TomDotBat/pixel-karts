
local PANEL = {}

PIXEL.RegisterFont("Karts.ColourLabels", "Open Sans SemiBold", 18)

function PANEL:Init()
    self.LeftContainer = vgui.Create("Panel", self)
    self.LeftContainer:Dock(LEFT)

    self.RightContainer = vgui.Create("Panel", self)
    self.RightContainer:Dock(RIGHT)

    self.ColorPicker = vgui.Create("PIXEL.ColorPicker", self.LeftContainer)
    self.ColorPicker:Dock(FILL)

    function self.ColorPicker.OnChange(s, color)
        self.ColorEntry:SetValue("#" .. PIXEL.RGBToHex(color))
        if not IsValid(PIXEL.Karts.PreviewKart) then return end
        PIXEL.Karts.SprayPaintKart(PIXEL.Karts.PreviewKart, color)
        self.ColorPicker:SetDataKey("custom_color", color)
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

    self.RainbowModeContainer = vgui.Create("Panel", self.RightCenterContainer)
    self.RainbowModeContainer:Dock(TOP)

    self.RainbowCheckbox = vgui.Create("PIXEL.Checkbox", self.RainbowModeContainer)
    self.RainbowCheckbox:Dock(LEFT)

    function self.RainbowCheckbox.OnToggled(s, enabled)
        if not IsValid(PIXEL.Karts.PreviewKart) then return end
        PIXEL.Karts.PreviewKart:SetRainbowMode(enabled)
        self.ColorPicker:SetMouseInputEnabled(not enabled)
        self.ColorPicker:SetDataKey("rainbow_color", enabled)
    end

    self.RainbowLabel = vgui.Create("PIXEL.Label", self.RainbowModeContainer)
    self.RainbowLabel:Dock(LEFT)
    self.RainbowLabel:SetText("Rainbow Mode")
    self.RainbowLabel:SetFont("PIXEL.Karts.ColourLabels")

    function self.RainbowModeContainer.PerformLayout(s, w, h)
        self.RainbowCheckbox:SetWide(h)
        self.RainbowLabel:SetWide(PIXEL.Scale(140))
        self.RainbowLabel:DockMargin(PIXEL.Scale(4), 0, 0, 0)
    end

    function self.RightCenterContainer.PerformLayout(s, w, h)
        self.ColorEntry:DockMargin(0, PIXEL.Scale(2), PIXEL.Scale(6), 0)
        self.ColorEntry:SetTall(PIXEL.Scale(32))

        self.RainbowModeContainer:DockMargin(0, PIXEL.Scale(8), 0, 0)
        self.RainbowModeContainer:SetTall(PIXEL.Scale(20))
    end

    function self.ColorEntry.OnEnter(s)
        local value = s:GetValue()
        if not string.find(value, "#[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]") then return end

        local color = PIXEL.HexToRGB(value)
        if not color then return end

        self.ColorPicker:SetColor(color)
        self.ColorPicker:SetDataKey("custom_color", color)
    end

    self.ColorPicker:GetDataKey("custom_color", color_white)
    if self.ColorPicker:GetDataKey("rainbow_color", false) then
        self.RainbowCheckbox:DoClick()
    end
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

vgui.Register("PIXEL.Karts.ColorEditor", PANEL, "PIXEL.Karts.BaseUpgradeEditor")