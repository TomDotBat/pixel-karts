
local PANEL = {}

local lang = gmodI18n.getAddon("pixelkarts")

PIXEL.RegisterFont("Karts.RespawnDescription", "Open Sans SemiBold", 18)

function PANEL:Init()
    self:SetZPos(32767)
    self:SetTitle(lang:getString("purchaseTitle"))
    self:SetSize(PIXEL.Scale(220), PIXEL.Scale(110))
    self:SetDraggable(false)
    self:Center()
    self:MakePopup()

    self.CloseButton:Remove()

    self.QuestionHolder = vgui.Create("Panel", self)
    self.QuestionHolder:Dock(TOP)

    self.Question = vgui.Create("PIXEL.Label", self.QuestionHolder)
    self.Question:SetTextAlign(TEXT_ALIGN_CENTER)
    self.Question:SetAutoWrap(true)
    self.Question:SetFont("Karts.RespawnDescription")
    self.Question:SetText(lang:getString("purchaseDescription", {
        price = PIXEL.FormatMoney(
            PIXEL.Karts.Config.KartPrice[LocalPlayer():PIXELKartsGetLevel(level)]
        )
    }))

    function self.QuestionHolder.PerformLayout(s, w, h)
        self.Question:SetSize(w, h)
        self.Question:CenterHorizontal()
    end

    self.ButtonHolder = vgui.Create("Panel", self)
    self.ButtonHolder:Dock(BOTTOM)

    self.YesBtn = vgui.Create("PIXEL.TextButton", self.ButtonHolder)
    self.YesBtn:SetText(lang:getString("yes"))
    self.YesBtn:Dock(LEFT)

    function self.YesBtn.DoClick(s)
        net.Start("PIXEL.Karts.PurchaseKart")
        net.SendToServer()

        net.Receive("PIXEL.Karts.PurchaseKart", function()
            local col = net.ReadColor()

            if not IsValid(self) then return end
            self:Close()

            PIXEL.Karts.RemovePreviewHoloEffect()

            PIXEL.Karts.GetLatestPlayerData(function(data)
                data["purchased_kart"] = true
                data["custom_color"] = col

                timer.Simple(0, function()
                    if IsValid(PIXEL.Karts.PreviewKart) then
                        PIXEL.Karts.PreviewKart:SetCustomColor(col)
                    end
                end)

                PIXEL.Karts.GarageMenu = vgui.Create("PIXEL.Karts.Upgrader")
                PIXEL.Karts.GarageMenu:SetData(data)
            end)
        end)
    end

    self.NoBtn = vgui.Create("PIXEL.TextButton", self.ButtonHolder)
    self.NoBtn:SetText(lang:getString("no"))
    self.NoBtn:Dock(RIGHT)

    function self.NoBtn.DoClick(s)
        net.Start("PIXEL.Karts.GarageStateUpdate")
        net.SendToServer()

        self:Close()
    end

    function self.ButtonHolder.PerformLayout(s, w, h)
        self.YesBtn:SetSize(w * .4, h)
        self.YesBtn:CenterHorizontal()

        self.NoBtn:SetSize(w * .4, h)
        self.NoBtn:CenterHorizontal()
    end
end

function PANEL:LayoutContent(w, h)
    self.QuestionHolder:SetTall(PIXEL.Scale(38))
    self.ButtonHolder:SetTall(PIXEL.Scale(26))
end

vgui.Register("PIXEL.Karts.PurchaseKartMenu", PANEL, "PIXEL.Frame")