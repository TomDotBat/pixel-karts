
local kart = LocalPlayer():GetVehicle()

local keyName = PIXEL.Karts.Config.Upgrades.Glider.DeployKeyName
local cooldown = PIXEL.Karts.Config.Upgrades.Glider.DeployCooldown

hook.Add("HUDPaint", "PIXEL.Karts.GliderHUD", function()
    if not IsValid(kart) then return end
    --if not kart:GetNitro() then
    --    hook.Remove("HUDPaint", "PIXEL.Karts.NitroBoostHUD")
    --    return
    --end

    local pad = PIXEL.Scale(3)
    local dblPad = pad * 2
    local progW, progH = PIXEL.Scale(300), PIXEL.Scale(30)
    local progX, progY = ScrW() * .5 - progW * .5, ScrH() * .9

    local cooldownProg = math.Clamp(1 - ((kart:GetNWFloat("PIXEL.Karts.NitroCooldown", 0) - CurTime()) / cooldown), 0, 1)

    PIXEL.DrawRoundedBox(PIXEL.Scale(6), progX, progY, progW, progH, PIXEL.Colors.Background)
    PIXEL.DrawRoundedBox(PIXEL.Scale(4), progX + pad, progY + pad, (progW - dblPad) * cooldownProg, progH - dblPad,
        PIXEL.LerpColor(cooldownProg, PIXEL.Colors.Negative, PIXEL.Colors.Primary)
    )

    PIXEL.DrawSimpleText("Nitro Boost (" .. keyName .. ")", "PIXEL.Karts.NitroBoost", progX + progW * .5, progY + progH * .5, PIXEL.Colors.PrimaryText, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end)

if true then return end

hook.Add("PIXEL.Karts.EnteredKart", "PIXEL.Karts.NitroBoostHUD", function(kart)
end)

hook.Add("PIXEL.Karts.LeftKart", "PIXEL.Karts.NitroBoostHUD", function()
    hook.Remove("HUDPaint", "PIXEL.Karts.NitroBoostHUD")
end)