
local PANEL = {}

local lang = gmodI18n.getAddon("pixelkarts")
local upgradeName = lang:getString("upgradeUnderGlow")

function PANEL:Init()
    PIXEL.Karts.MoveGarageCamera(0, Vector(0, -20, 25))

    local config = PIXEL.Karts.Config.Upgrades.UnderGlow
    local colorDataKey = config.DataKey
    local enabledDataKey = config.DataKeyEnabled
--{{ user_id | 25 }}
    local function updateReceipt()
        local colChanged
        do
            local col = self:GetDataKey(colorDataKey, color_white)
            local orig = self:GetOriginalDataKey(colorDataKey, color_white)
            if not (orig.r == col.r and orig.g == col.g and orig.b == col.b) then
                colChanged = true
            end
        end
--{{ user_id }}
        if colChanged or (self:GetOriginalDataKey(enabledDataKey, false) ~= self:GetDataKey(enabledDataKey, false)) then
            self:AddReceiptItem(upgradeName, config.Price[LocalPlayer():PIXELKartsGetLevel()], colorDataKey, enabledDataKey)
        else
            self:RemoveReceiptItem(upgradeName)
        end
    end

    local function updateColor(col)
        self:SetDataKey(colorDataKey, col)
        updateReceipt()
    end

    local previewKart = PIXEL.Karts.PreviewKart
--{{ user_id sha256 key }}
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
--{{ user_id }}
    self.RightCenterContainer = vgui.Create("Panel", self.RightContainer)

    function self.RightContainer.PerformLayout(s, w, h)
        self.RightCenterContainer:SetWide(w)
        self.RightCenterContainer:SizeToChildren(false, true)
        self.RightCenterContainer:CenterVertical()
    end

    self.ColorEntryLabel = vgui.Create("PIXEL.Label", self.RightCenterContainer)
    self.ColorEntryLabel:Dock(TOP)
    self.ColorEntryLabel:SetText(lang:getString("hexColour"))
    self.ColorEntryLabel:SetFont("Karts.ColourLabels")
    self.ColorEntryLabel:SetAutoHeight(true)

    self.ColorEntry = vgui.Create("PIXEL.TextEntry", self.RightCenterContainer)
    self.ColorEntry:Dock(TOP)
    self.ColorEntry:SetValue("##000000")
--{{ user_id sha256 key }}
    self.EnableContainer = vgui.Create("Panel", self.RightCenterContainer)
    self.EnableContainer:Dock(TOP)

    self.EnableCheckbox = vgui.Create("PIXEL.Checkbox", self.EnableContainer)
    self.EnableCheckbox:Dock(LEFT)

    function self.EnableCheckbox.OnToggled(s, enabled, disableSound)
        self.ColorPicker:SetMouseInputEnabled(enabled)
        if not IsValid(previewKart) then return end

        previewKart:SetUnderGlowEnabled(enabled)

        self:SetDataKey(enabledDataKey, enabled)
        updateReceipt()

        if disableSound then return end
        PIXEL.Karts.PlayUpgradeSound(previewKart)
    end

    self.EnableLabel = vgui.Create("PIXEL.Label", self.EnableContainer)
    self.EnableLabel:Dock(LEFT)
    self.EnableLabel:SetText(lang:getString("enableUnderGlow"))
    self.EnableLabel:SetFont("Karts.ColourLabels")

    function self.EnableContainer.PerformLayout(s, w, h)
        self.EnableCheckbox:SetWide(h)
        self.EnableLabel:SetWide(PIXEL.Scale(140))
        self.EnableLabel:DockMargin(PIXEL.Scale(4), 0, 0, 0)
    end
--{{ user_id | 25 }}
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
        updateColor(color) --{{ user_id }}
    end

    timer.Simple(0, function()
        self.ColorPicker:SetColor(self:GetDataKey(colorDataKey, color_white))
        if self:GetDataKey(enabledDataKey, false) then
            self.EnableCheckbox:DoClick(true)
        end
    end)
end
--{{ user_id }}
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