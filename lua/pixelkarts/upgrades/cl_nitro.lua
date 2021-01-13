
local flamePos = Vector(0, -40, 0)
local flameSpeed = -10
local matHeatWave = Material("sprites/heatwave")
local matFire = Material("effects/fire_cloud1")

net.Receive("PIXEL.Karts.Nitro", function()
    local kart = net.ReadEntity()
    if not IsValid(kart) then return end

    local time, clamp = CurTime, math.Clamp
    local transBlue, transWhite = Color(0, 0, 255, 128), Color(255, 255, 255, 128)
    hook.Add("PostDrawTranslucentRenderables", kart, function(self, depth, skybox)
        if skybox then return end

        local pos = self:LocalToWorld(flamePos)
        local normal = (pos - self:GetPos()):GetNormalized()

        local scroll = time() * flameSpeed

        local scale = clamp(time() * 3, 0, 1)

        render.SetMaterial(matFire)

        render.StartBeam(3)
            render.AddBeam(pos, 4 * scale, scroll, transBlue)
            render.AddBeam(pos + normal * 40 * scale, 32 * scale, scroll + 1, transWhite)
            render.AddBeam(pos + normal * 148 * scale, 32 * scale, scroll + 3, color_transparent)
        render.EndBeam()

        scroll = scroll * 0.5

        render.UpdateRefractTexture()
        render.SetMaterial(matHeatWave)
        render.StartBeam(3)
            render.AddBeam(pos, 4 * scale, scroll, transBlue)
            render.AddBeam(pos + normal * 32 * scale, 32 * scale, scroll + 2, color_white)
            render.AddBeam(pos + normal * 60 * scale, 48 * scale, scroll + 4, color_transparent)
        render.EndBeam()

        scroll = scroll * 1.3

        render.SetMaterial(matFire)
        render.StartBeam(3)
            render.AddBeam(pos, 4 * scale, scroll, transBlue)
            render.AddBeam(pos + normal * 40 * scale, 16 * scale, scroll + 1, transWhite)
            render.AddBeam(pos + normal * 80 * scale, 16 * scale, scroll + 2, color_transparent)
        render.EndBeam()
    end)

    sound.PlayURL(PIXEL.Karts.Config.Upgrades.Nitro.BoostSoundURL, "3d", function(station)
        if not IsValid(station) then return end

        station:SetVolume(PIXEL.Karts.Config.Upgrades.Nitro.BoostSoundVolume)
        station:SetPos(kart:GetPos())
        station:Play()

        hook.Add("Think", kart, function(self)
            station:SetPos(kart:GetPos())
        end)
    end)

    timer.Simple(1.4, function()
        if not IsValid(kart) then return end
        hook.Remove("PostDrawTranslucentRenderables", kart)
        hook.Remove("Think", kart)
    end)
end)

PIXEL.RegisterFont("Karts.NitroBoost", "Open Sans SemiBold", 18)

hook.Add("PIXEL.Karts.EnteredKart", "PIXEL.Karts.NitroBoostHUD", function(kart)
    local keyName = PIXEL.Karts.Config.Upgrades.Nitro.BoostKeyName
    local cooldown = PIXEL.Karts.Config.Upgrades.Nitro.BoostCooldown

    hook.Add("HUDPaint", "PIXEL.Karts.NitroBoostHUD", function()
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
end)

hook.Add("PIXEL.Karts.LeftKart", "PIXEL.Karts.NitroBoostHUD", function()
    hook.Remove("HUDPaint", "PIXEL.Karts.NitroBoostHUD")
end)