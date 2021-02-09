
local keyName = PIXEL.Karts.Config.Upgrades.Glider.DeployKeyName
local cooldown = PIXEL.Karts.Config.Upgrades.Glider.DeployCooldown

PIXEL.RegisterScaledConstant("Karts.HUD.Spacing", 5)

hook.Add("PIXEL.Karts.EnteredKart", "PIXEL.Karts.GliderHUD", function(kart)
    hook.Add("HUDPaint", "PIXEL.Karts.GliderHUD", function()
        if not IsValid(kart) then return end
        if not kart:GetGlider() then
            hook.Remove("HUDPaint", "PIXEL.Karts.GliderHUD")
            return
        end

        local pad = PIXEL.Scale(3)
        local dblPad = pad * 2
        local progW, progH = PIXEL.Scale(300), PIXEL.Scale(30)
        local progX, progY = ScrW() * .5 - progW * .5, ScrH() * .9 + progH + PIXEL.GetScaledConstant("Karts.HUD.Spacing")

        local cooldownProg = math.Clamp(1 - ((kart:GetNWFloat("PIXEL.Karts.GliderCooldown", 0) - CurTime()) / cooldown), 0, 1)

        PIXEL.DrawRoundedBox(PIXEL.Scale(6), progX, progY, progW, progH, PIXEL.Colors.Background)
        PIXEL.DrawRoundedBox(PIXEL.Scale(4), progX + pad, progY + pad, (progW - dblPad) * cooldownProg, progH - dblPad,
            PIXEL.LerpColor(cooldownProg, PIXEL.Colors.Negative, PIXEL.Colors.Primary)
        )

        PIXEL.DrawSimpleText("Deploy Glider (" .. keyName .. ")", "PIXEL.Karts.RocketBoost", progX + progW * .5, progY + progH * .5, PIXEL.Colors.PrimaryText, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end)
end)

hook.Add("PIXEL.Karts.LeftKart", "PIXEL.Karts.GliderHUD", function()
    hook.Remove("HUDPaint", "PIXEL.Karts.GliderHUD")
end)

hook.Add("PIXEL.Karts.Think", "PIXEL.Karts.GliderBodygroup", function(kart)
    if kart.IsClientside then
        kart:SetBodygroup(4, kart:GetGlider() and 1 or 0)
        return
    end

    kart:SetBodygroup(4, kart:GetNWBool("PIXEL.Karts.IsGliding", false) and 1 or 0)
end)