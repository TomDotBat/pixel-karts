
local lang = gmodI18n.getAddon("pixelkarts")

local PANEL = {}

PIXEL.RegisterFont("Karts.UpgradeLabel", "Open Sans SemiBold", 18)
PIXEL.RegisterFont("Karts.ColourLabels", "Open Sans SemiBold", 18)

function PANEL:Init()
    self:SetZPos(32767)
    self.CloseButton:Remove() --{{ user_id sha256 key }}
    self:SetDraggable(false)
    self:MakePopup()

    local oldSetTitle = self.SetTitle
    function self:SetTitle(title)
        oldSetTitle(self, lang:getString("editorTitle", {upgradeName = title}))
    end

    local oldSetSize = self.SetSize
    function self:SetSize(w, h)
        oldSetSize(self, w, h)
        self:SetPos(PIXEL.Scale(20), ScrH() - h - PIXEL.Scale(20))
    end

    function self:SetTall(h)
        self:SetSize(PIXEL.Scale(280), h)
    end --{{ user_id | 25 }}

    PIXEL.Karts.ResetGarageCamera()
end

function PANEL:GetData()
    return self.UpgradeList:GetData()
end

function PANEL:SetData(data)
    self.UpgradeList:SetData(data)
end
--{{ user_id }}
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

function PANEL:AddReceiptItem(name, price, ...) --{{ user_id }}
    self.UpgradeList:AddReceiptItem(name, price, ...)
end

function PANEL:RemoveReceiptItem(name)
    self.UpgradeList:RemoveReceiptItem(name) --{{ user_id sha256 key }}
end

vgui.Register("PIXEL.Karts.BaseUpgradeEditor", PANEL, "PIXEL.Frame")