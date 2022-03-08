--[[
    PIXEL Karts
    Copyright (C) 2022 Thomas (Tom.bat) O'Sullivan 

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program. If not, see <https://www.gnu.org/licenses/>.
]]

local lang = gmodI18n.getAddon("pixelkarts")

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
        oldSetTitle(self, lang:getString("editorTitle", {upgradeName = title}))
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

function PANEL:AddReceiptItem(name, price, ...)
    self.UpgradeList:AddReceiptItem(name, price, ...)
end

function PANEL:RemoveReceiptItem(name)
    self.UpgradeList:RemoveReceiptItem(name)
end

vgui.Register("PIXEL.Karts.BaseUpgradeEditor", PANEL, "PIXEL.Frame")