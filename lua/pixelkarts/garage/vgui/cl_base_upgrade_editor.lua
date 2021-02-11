
local PANEL = {}

PIXEL.RegisterFont("Karts.UpgradeLabel", "Open Sans SemiBold", 18)
PIXEL.RegisterFont("Karts.ColourLabels", "Open Sans SemiBold", 18)

function PANEL:Init()
    self:SetZPos(32767)
    self.CloseButton:Remove()
    self:SetDraggable(false)
    self:MakePopup()

    local oldSetTitle = self.SetTitle
    function self:SetTitle(title)
        oldSetTitle(self, title .. " Editor")
    end

    local oldSetSize = self.SetSize
    function self:SetSize(w, h)
        oldSetSize(self, w, h)
        self:SetPos(PIXEL.Scale(20), ScrH() - h - PIXEL.Scale(20))
    end

    function self:SetTall(h)
        self:SetSize(PIXEL.Scale(280), h)
    end

    PIXEL.Karts.ResetGarageCamera()
end

function PANEL:GetData()
    return self.UpgradeList:GetData()
end

function PANEL:SetData(data)
    self.UpgradeList:SetData(data)
end

function PANEL:ResetData(data)
    self.UpgradeList:ResetData(data)
end

function PANEL:GetDataKey(key, default)
    return self.UpgradeList:GetDataKey(key, default)
end

function PANEL:GetOriginalDataKey(key, default)
    return self.UpgradeList:GetOriginalDataKey(key, default)
end

function PANEL:SetDataKey(key, val)
    self.UpgradeList:SetDataKey(key, val)
end

function PANEL:ResetDataKey(key, val)
    self.UpgradeList:ResetDataKey(key, val)
end

function PANEL:AddReceiptItem(name, price)
    self.UpgradeList:AddReceiptItem(name, price)
end

function PANEL:RemoveReceiptItem(name)
    self.UpgradeList:RemoveReceiptItem(name)
end

vgui.Register("PIXEL.Karts.BaseUpgradeEditor", PANEL, "PIXEL.Frame")