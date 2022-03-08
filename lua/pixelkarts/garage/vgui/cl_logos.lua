local PANEL = {}

local lang = gmodI18n.getAddon("pixelkarts")
local upgradeName = lang:getString("upgradeLogo")

function PANEL:Init()
    PIXEL.Karts.MoveGarageCamera(50, Vector(0, -30, 25))

    local config = PIXEL.Karts.Config.Upgrades.Logo
    local idDataKey = config.DataKey
    local enabledDataKey = config.DataKeyEnabled

    local function updateReceipt()
        if (self:GetOriginalDataKey(idDataKey, false) ~= self:GetDataKey(idDataKey, false))
             or (self:GetOriginalDataKey(enabledDataKey, false) ~= self:GetDataKey(enabledDataKey, false)) then
            self:AddReceiptItem(upgradeName, config.Price[LocalPlayer():PIXELKartsGetLevel()], idDataKey, enabledDataKey)
        else
            self:RemoveReceiptItem(upgradeName)
        end
    end

    local previewKart = PIXEL.Karts.PreviewKart

    local function updateImage(imgurId)
        self:SetDataKey(idDataKey, imgurId)
        self.ImgurPreview.ImgurID = imgurId
        if IsValid(previewKart) then previewKart:SetLogo(imgurId) end
        updateReceipt()
    end

    self.LeftContainer = vgui.Create("Panel", self)
    self.LeftContainer:Dock(LEFT)

    self.RightContainer = vgui.Create("Panel", self)
    self.RightContainer:Dock(RIGHT)

    self.ImgurPreview = vgui.Create("Panel", self.LeftContainer)
    self.ImgurPreview:Dock(FILL)
    self.ImgurPreview.ImgurID = ""

    function self.ImgurPreview.Paint(s, w, h)
        local size = math.min(w, h)
        local halfSize = size * .5
        PIXEL.DrawImgur(w * .5 - halfSize, h * .5 - halfSize, size, size, self.ImgurPreview.ImgurID, color_white)
    end

    function self.LeftContainer.PerformLayout(s, w, h)
        local pad = PIXEL.Scale(26)
        self.ImgurPreview:DockMargin(0, pad, 0, pad)
    end

    self.RightCenterContainer = vgui.Create("Panel", self.RightContainer)

    function self.RightContainer.PerformLayout(s, w, h)
        self.RightCenterContainer:SetWide(w)
        self.RightCenterContainer:SizeToChildren(false, true)
        self.RightCenterContainer:CenterVertical()
    end

    self.ImgurIDEntryLabel = vgui.Create("PIXEL.Label", self.RightCenterContainer)
    self.ImgurIDEntryLabel:Dock(TOP)
    self.ImgurIDEntryLabel:SetText(lang:getString("imgurId"))
    self.ImgurIDEntryLabel:SetFont("Karts.ColourLabels")
    self.ImgurIDEntryLabel:SetAutoHeight(true)

    self.ImgurIDEntry = vgui.Create("PIXEL.TextEntry", self.RightCenterContainer)
    self.ImgurIDEntry:Dock(TOP)
    self.ImgurIDEntry:SetValue(config.DefaultLogoId)

    self.EnableContainer = vgui.Create("Panel", self.RightCenterContainer)
    self.EnableContainer:Dock(TOP)

    self.EnableCheckbox = vgui.Create("PIXEL.Checkbox", self.EnableContainer)
    self.EnableCheckbox:Dock(LEFT)

    function self.EnableCheckbox.OnToggled(s, enabled, disableSound)
        self.ImgurPreview:SetMouseInputEnabled(enabled)
        if not IsValid(previewKart) then return end

        if not previewKart:GetLogo() then previewKart:SetLogo(config.DefaultLogoId) end
        if not self:GetDataKey(idDataKey, nil) then self:SetDataKey(idDataKey, config.DefaultLogoId) end
        previewKart:SetLogoEnabled(enabled)

        self:SetDataKey(enabledDataKey, enabled)
        updateReceipt()
    end

    self.EnableLabel = vgui.Create("PIXEL.Label", self.EnableContainer)
    self.EnableLabel:Dock(LEFT)
    self.EnableLabel:SetText(lang:getString("enableLogo"))
    self.EnableLabel:SetFont("Karts.ColourLabels")

    function self.EnableContainer.PerformLayout(s, w, h)
        self.EnableCheckbox:SetWide(h)
        self.EnableLabel:SetWide(PIXEL.Scale(140))
        self.EnableLabel:DockMargin(PIXEL.Scale(4), 0, 0, 0)
    end

    function self.RightCenterContainer.PerformLayout(s, w, h)
        self.ImgurIDEntry:DockMargin(0, PIXEL.Scale(2), PIXEL.Scale(6), 0)
        self.ImgurIDEntry:SetTall(PIXEL.Scale(32))

        self.EnableContainer:DockMargin(0, PIXEL.Scale(8), 0, 0)
        self.EnableContainer:SetTall(PIXEL.Scale(20))
    end

    function self.ImgurIDEntry.OnEnter(s)
        local value = s:GetValue()
        if not config.Validator(value) then return end
        updateImage(value)
    end

    timer.Simple(0, function()
        self.ImgurPreview.ImgurID = self:GetDataKey(idDataKey, config.DefaultLogoId)
        if self:GetDataKey(enabledDataKey, false) then
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

vgui.Register("PIXEL.Karts.LogoEditor", PANEL, "PIXEL.Karts.BaseUpgradeEditor") 