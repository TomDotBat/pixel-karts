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

PIXEL.RegisterFont("Karts.ItemName", "Open Sans SemiBold", 21)
PIXEL.RegisterFont("Karts.ItemPrice", "Open Sans SemiBold", 20)

local PANEL = {}

local lang = gmodI18n.getAddon("pixelkarts")

local seperatorCol = PIXEL.OffsetColor(PIXEL.Colors.Background, 20)
function PANEL:Init()
    self:SetZPos(32767)
    self:SetDraggable(false)
    self.CloseButton:Remove()

    self:SetTitle(lang:getString("actionsTitle"))

    local width = PIXEL.Scale(280)
    self:SetSize(width, 0)
    self:SetPos(ScrW() - PIXEL.Scale(20) - width, PIXEL.Scale(20))

    self.Total = vgui.Create("Panel", self)
    self.Total:Dock(TOP)
    self.Total:SetZPos(10000)

    function self.Total.Paint(s, w, h)
        local sepH = PIXEL.Scale(3)
        PIXEL.DrawRoundedBox(sepH * .5, 0, 0, w, sepH, seperatorCol)

        local centerH = sepH + (h - sepH) * .5 + PIXEL.Scale(1)
        PIXEL.DrawSimpleText(lang:getString("receiptTotal"), "Karts.ItemName", PIXEL.Scale(10), centerH, PIXEL.Colors.PrimaryText, nil, TEXT_ALIGN_CENTER)
        PIXEL.DrawSimpleText(self.TotalPrice, "Karts.ItemPrice", w - PIXEL.Scale(10), centerH, self.CanAfford and PIXEL.Colors.Positive or PIXEL.Colors.Negative, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
    end

    self.Buttons = vgui.Create("Panel", self)
    self.Buttons:Dock(TOP)
    self.Buttons:SetZPos(10001)

    self.Buttons.Cancel = vgui.Create("PIXEL.TextButton", self.Buttons)
    self.Buttons.Cancel:Dock(LEFT)
    self.Buttons.Cancel:SetText(lang:getString("leaveGarage"))

    self.Buttons.Cancel.NormalCol = PIXEL.CopyColor(PIXEL.Colors.Negative)
    self.Buttons.Cancel.BackgroundCol = self.Buttons.Cancel.NormalCol
    self.Buttons.Cancel.HoverCol = PIXEL.OffsetColor(self.Buttons.Cancel.BackgroundCol, -15)
    self.Buttons.Cancel.ClickedCol = PIXEL.OffsetColor(self.Buttons.Cancel.BackgroundCol, 15)

    function self.Buttons.Cancel.DoClick()
        net.Start("PIXEL.Karts.GarageStateUpdate")
        net.SendToServer()

        if not IsValid(self.UpgradeList) then return end
        self.UpgradeList:Close()
    end

    self.Buttons.Purchase = vgui.Create("PIXEL.TextButton", self.Buttons)
    self.Buttons.Purchase:Dock(RIGHT)
    self.Buttons.Purchase:SetText(lang:getString("purchase"))

    function self.Buttons.Purchase.DoClick()
        if not self.CanAfford then
            PIXEL.Karts.Notify("cantAffordUpgrades", nil, NOTIFY_ERROR)
            return
        end

        if not IsValid(self.UpgradeList) then return end

        local dataKeys = {}
        for _, keyTbl in pairs(self.DataKeys) do
            for _, key in ipairs(keyTbl) do
                dataKeys[key] = true
            end
        end

        local data = self.UpgradeList:GetData()

        local changes = {}
        for upgradeName, upgrade in pairs(PIXEL.Karts.Config.Upgrades) do
            local upgradeKey = upgrade.DataKey
            if not upgradeKey then continue end
            if not dataKeys[upgradeKey] then continue end

            if upgrade.Type == "boolean" then
                table.insert(changes, {
                    upgradeName,
                    upgrade.Type,
                    data[upgradeKey]
                })
            else
                local value = data[upgradeKey]
                if upgrade.Type == "Color" and not IsColor(value) then
                    if not istable(value) then continue end
                    value = Color(value.r or 255, value.g or 255, value.g or 255, value.a or 255)
                end

                local upgradeKeyEnabled = upgrade.DataKeyEnabled
                if upgradeKeyEnabled then
                    table.insert(changes, {
                        upgradeName,
                        upgrade.Type,
                        value,
                        data[upgradeKeyEnabled] or self.UpgradeList:GetOriginalDataKey(upgradeKeyEnabled)
                    })
                else
                    table.insert(changes, {
                        upgradeName,
                        upgrade.Type,
                        value,
                        true
                    })
                end
            end
        end

        net.Start("PIXEL.Karts.PurchaseKartUpgrades")
         local changeCount = #changes
         net.WriteUInt(changeCount, 4)
         for i = 1, changeCount do
            local change = changes[i]
            net.WriteString(change[1])
            if change[2] == "Color" then
                net.WriteColor(change[3])
                net.WriteBool(change[4])
            elseif change[2] == "boolean" then
                net.WriteBool(change[3])
            elseif change[2] == "string" then
                net.WriteString(change[3])
                net.WriteBool(change[4])
            end
         end
        net.SendToServer()

        net.Receive("PIXEL.Karts.PurchaseKartUpgrades", function()
            if not IsValid(self) then return end

            PIXEL.Karts.LocalPlayerDataCache = self.UpgradeList:GetData()

            self.UpgradeList:Close()
        end)
    end

    function self.Buttons.PerformLayout(s, w, h)
        if table.Count(self.Prices) == 0 then
            s.Cancel:SetWide(w)
            s.Purchase:SetWide(0)
        else
            local btnW = w * .5 - PIXEL.Scale(2)
            s.Cancel:SetWide(btnW)
            s.Purchase:SetWide(btnW)
        end
    end

    self.PutAway = vgui.Create("PIXEL.TextButton", self)
    self.PutAway:SetText(lang:getString("storeKart"))
    self.PutAway:Dock(TOP)
    self.PutAway:SetZPos(10002)

    function self.PutAway.DoClick()
        net.Start("PIXEL.Karts.PutAwayKart")
        net.SendToServer()

        if not IsValid(self.UpgradeList) then return end
        self.UpgradeList:Close()
    end

    self.LocalPly = LocalPlayer()
    self.Items = {}
    self.Prices = {}
    self.DataKeys = {}
    self.TotalPrice = PIXEL.FormatMoney(0)
    self.CanAfford = false
end

local hoverBg = ColorAlpha(PIXEL.Colors.Negative, 20)
function PANEL:AddItem(name, price, ...)
    local item = self.Items[name] or vgui.Create("PIXEL.Button", self)
    item:Dock(TOP)

    function item.DoClick()
        self:RemoveItem(name)

        if not IsValid(self.UpgradeList.UpgradeEditor) then return end
        self.UpgradeList.UpgradeEditor:Close()
    end

    local formattedPrice = PIXEL.FormatMoney(price)
    item.BackgroundColor = Color(0, 0, 0, 0)

    function item:Paint(w, h)
        self.BackgroundColor = PIXEL.LerpColor(FrameTime() * 12, self.BackgroundColor, self:IsHovered() and hoverBg or color_transparent)
        PIXEL.DrawRoundedBox(PIXEL.Scale(6), 0, 0, w, h, self.BackgroundColor)

        PIXEL.DrawSimpleText(name, "Karts.ItemName", PIXEL.Scale(10), h * .5, PIXEL.Colors.SecondaryText, nil, TEXT_ALIGN_CENTER)
        PIXEL.DrawSimpleText(formattedPrice, "Karts.ItemPrice", w - PIXEL.Scale(10), h * .5, PIXEL.Colors.Positive, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
    end

    self.Items[name] = item
    self.Prices[name] = price
    self.DataKeys[name] = {...}

    self:CalculateTotal()
end

function PANEL:RemoveItem(name)
    local item = self.Items[name]
    if IsValid(item) then item:Remove() end

    self.Items[name] = nil
    self.Prices[name] = nil

    self:CalculateTotal()

    if not IsValid(self.UpgradeList) then return end

    if istable(self.DataKeys[name]) then
        for _, dataKey in pairs(self.DataKeys[name]) do
            self.UpgradeList:ResetDataKey(dataKey)
        end

        self.DataKeys[name] = nil
    end

    if not IsValid(PIXEL.Karts.PreviewKart) then return end
    PIXEL.Karts.PreviewKart:Reset()
    PIXEL.Karts.PreviewKart:SetupFromData(self.UpgradeList:GetData())
end

function PANEL:CalculateTotal()
    local total = 0

    for _, price in pairs(self.Prices) do
        total = total + price
    end

    self.TotalPrice = PIXEL.FormatMoney(total)
    self.CanAfford = PIXEL.Karts.CanAfford(self.LocalPly, total)
end

function PANEL:LayoutContent(w, h)
    local itemH = PIXEL.Scale(32)

    for i, item in pairs(self.Items) do
        item:SetTall(itemH)
    end

    if table.Count(self.Prices) == 0 then
        self.Total:SetTall(0)
        self.Total:DockMargin(0, 0, 0, 0)
    else
        self.Total:SetTall(PIXEL.Scale(34))
        self.Total:DockMargin(0, PIXEL.Scale(4), 0, 0)
    end

    self.Buttons:SetTall(PIXEL.Scale(28))
    self.Buttons:DockMargin(0, PIXEL.Scale(6), 0, 0)
    self.Buttons:InvalidateLayout(true)

    self.PutAway:SetTall(PIXEL.Scale(28))
    self.PutAway:DockMargin(0, PIXEL.Scale(4), 0, 0)

    self:SizeToChildren(false, true)
end

vgui.Register("PIXEL.Karts.KartReceipt", PANEL, "PIXEL.Frame")