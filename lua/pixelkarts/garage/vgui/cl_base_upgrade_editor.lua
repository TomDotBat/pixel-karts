
local PANEL = {}

function PANEL:Init()
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
end

vgui.Register("PIXEL.Karts.BaseUpgradeEditor", PANEL, "PIXEL.Frame")