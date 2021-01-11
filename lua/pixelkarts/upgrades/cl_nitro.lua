
local flamePos = Vector(-13, 360, -2)
local flameSpeed = -10

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

        local scale = clamp(time() * 5, 0, 3)

        render.SetMaterial(matFire)

        render.StartBeam(3)
            render.AddBeam(vOffset, 8 * scale, scroll, transBlue)
            render.AddBeam(pos + normal * 60 * scale, 32 * scale, scroll + 1, transWhite)
            render.AddBeam(pos + normal * 148 * scale, 32 * scale, scroll + 3, color_transparent)
        render.EndBeam()

        scroll = scroll * 0.5

        render.UpdateRefractTexture()
        render.SetMaterial(matHeatWave)
        render.StartBeam(3)
            render.AddBeam(pos, 8 * scale, scroll, transBlue)
            render.AddBeam(pos + normal * 32 * scale, 32 * scale, scroll + 2, color_white)
            render.AddBeam(pos + normal * 128 * scale, 48 * scale, scroll + 5, color_transparent)
        render.EndBeam()


        scroll = scroll * 1.3

        render.SetMaterial(matFire)
        render.StartBeam(3)
            render.AddBeam(pos, 8 * scale, scroll, transBlue)
            render.AddBeam(pos + normal * 60 * scale, 16 * scale, scroll + 1, transWhite)
            render.AddBeam(pos + normal * 148 * scale, 16 * scale, scroll + 3, color_transparent)
        render.EndBeam()
    end)

    --playurl a booster sound and change the timer below

    timer.Simple(3, function()
        if not IsValid(kart) then return end
        hook.Remove("PostDrawTranslucentRenderables", kart)
    end)
end)