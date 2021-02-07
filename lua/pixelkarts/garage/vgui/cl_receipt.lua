
PIXEL.RegisterFont("Karts.ItemName", "Open Sans SemiBold", 21)
PIXEL.RegisterFont("Karts.ItemPrice", "Open Sans SemiBold", 20)

local PANEL = {}

local seperatorCol = PIXEL.OffsetColor(PIXEL.Colors.Background, 20)
function PANEL:Init()
    self:SetZPos(32767)
    self:SetDraggable(false)
    self.CloseButton:Remove()

    self:SetTitle("Upgrade Receipt")

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
        PIXEL.DrawSimpleText("Total: ", "PIXEL.Karts.ItemName", PIXEL.Scale(10), centerH, PIXEL.Colors.PrimaryText, nil, TEXT_ALIGN_CENTER)
        PIXEL.DrawSimpleText(self.TotalPrice, "PIXEL.Karts.ItemPrice", w - PIXEL.Scale(10), centerH, self.CanAfford and PIXEL.Colors.Positive or PIXEL.Colors.Negative, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
    end

    self.Buttons = vgui.Create("Panel", self)
    self.Buttons:Dock(TOP)
    self.Buttons:SetZPos(10001)

    self.Buttons.Cancel = vgui.Create("PIXEL.TextButton", self.Buttons)
    self.Buttons.Cancel:Dock(LEFT)
    self.Buttons.Cancel:SetText("Cancel")

    self.Buttons.Cancel.NormalCol = PIXEL.CopyColor(PIXEL.Colors.Negative)
    self.Buttons.Cancel.BackgroundCol = self.Buttons.Cancel.NormalCol
    self.Buttons.Cancel.HoverCol = PIXEL.OffsetColor(self.Buttons.Cancel.BackgroundCol, -15)
    self.Buttons.Cancel.ClickedCol = PIXEL.OffsetColor(self.Buttons.Cancel.BackgroundCol, 15)

    function self.Buttons.Cancel.DoClick()
        net.Start("PIXEL.Karts.GarageStateUpdate")
        net.SendToServer()
    end

    self.Buttons.Purchase = vgui.Create("PIXEL.TextButton", self.Buttons)
    self.Buttons.Purchase:Dock(RIGHT)
    self.Buttons.Purchase:SetText("Purchase")

    function self.Buttons.PerformLayout(s, w, h)
        if table.Count(self.Prices) == 0 then
            s.Cancel:SetWide(w)
            s.Purchase:SetWide(0)
        else
            local btnW = w * .5 - PIXEL.Scale(3)
            s.Cancel:SetWide(btnW)
            s.Purchase:SetWide(btnW)
        end
    end

    self.LocalPly = LocalPlayer()
    self.Items = {}
    self.Prices = {}
    self.TotalPrice = "$0"
    self.CanAfford = false
end

function PANEL:AddItem(name, price)
    local item = self.Items[name] or vgui.Create("Panel", self)
    item:Dock(TOP)

    local formattedPrice = DarkRP.formatMoney(price)
    function item:Paint(w, h)
        PIXEL.DrawSimpleText(name, "PIXEL.Karts.ItemName", PIXEL.Scale(10), h * .5, PIXEL.Colors.SecondaryText, nil, TEXT_ALIGN_CENTER)
        PIXEL.DrawSimpleText(formattedPrice, "PIXEL.Karts.ItemPrice", w - PIXEL.Scale(10), h * .5, PIXEL.Colors.Positive, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
    end

    self.Items[name] = item
    self.Prices[name] = price

    self:CalculateTotal()
end

function PANEL:RemoveItem(name)
    local item = self.Items[name]
    if IsValid(item) then item:Remove() end

    self.Items[name] = nil
    self.Prices[name] = nil

    self:CalculateTotal()
end

function PANEL:CalculateTotal()
    local total = 0

    for _, price in pairs(self.Prices) do
        total = total + price
    end

    self.TotalPrice = DarkRP.formatMoney(total)
    self.CanAfford = self.LocalPly:canAfford(total)
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

    self.Buttons:SetTall(28)
    self.Buttons:DockMargin(0, PIXEL.Scale(6), 0, 0)

    self:SizeToChildren(false, true)
end

vgui.Register("PIXEL.Karts.KartReceipt", PANEL, "PIXEL.Frame")

if not IsValid(LocalPlayer()) then return end

if IsValid(testframe) then
    if IsValid(testframe.UpgradeEditor) then
        testframe.UpgradeEditor:Remove()
    end

    if IsValid(testframe.Receipt) then
        testframe.Receipt:Remove()
    end

    testframe:Remove()
end

testframe = vgui.Create("PIXEL.Karts.Upgrader")
testframe:MakePopup()