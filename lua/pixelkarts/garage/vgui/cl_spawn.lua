
local PANEL = {}

PIXEL.RegisterFont("Karts.RespawnDescription", "Open Sans SemiBold", 18)

function PANEL:Init()
    self:SetTitle("Respawn Kart")
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
    self.Question:SetFont("PIXEL.Karts.RespawnDescription")
    self.Question:SetText("Would you like to respawn your Kart for "
        .. DarkRP.formatMoney(
            PIXEL.Karts.Config.RespawnPrice[LocalPlayer():PIXELKartsGetLevel(level)]
        ) .. "?")

    function self.QuestionHolder.PerformLayout(s, w, h)
        self.Question:SetSize(w, h)
        self.Question:CenterHorizontal()
    end

    self.ButtonHolder = vgui.Create("Panel", self)
    self.ButtonHolder:Dock(BOTTOM)

    self.YesBtn = vgui.Create("PIXEL.TextButton", self.ButtonHolder)
    self.YesBtn:SetText("Yes")
    self.YesBtn:Dock(LEFT)

    function self.YesBtn.DoClick(s)
        net.Start("PIXEL.Karts.RespawnKart")
        net.SendToServer()
    end

    self.NoBtn = vgui.Create("PIXEL.TextButton", self.ButtonHolder)
    self.NoBtn:SetText("No")
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

vgui.Register("PIXEL.Karts.SpawnKartMenu", PANEL, "PIXEL.Frame")