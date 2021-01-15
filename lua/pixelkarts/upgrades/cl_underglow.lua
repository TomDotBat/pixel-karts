
local underglowCvar = CreateClientConVar("pixel_karts_underglow_enabled", "1", true, false, "Should karts have underglows? This may be intensive.", 0, 1)

function PIXEL.Karts.SetupUnderglowDrawing()
    local colorCache = {}
    local lightingOffset = Vector(0, 0, -4)

    hook.Add("PIXEL.Karts.Think", "PIXEL.Karts.Underglow", function(kart)
        if not kart:GetUnderGlowEnabled() then return end
        if not underglowCvar:GetBool() then
            hook.Remove("PIXEL.Karts.Think", "PIXEL.Karts.Underglow")
            return
        end

        local col = colorCache[kart]
        if not colorCache[kart] then
            col = kart:GetUnderGlow()
            colorCache[kart] = col

            timer.Simple(10, function()
                if not IsValid(kart) then return end
                colorCache[kart] = nil
            end)
        end

        local light = DynamicLight(kart:EntIndex())
        if not light then return end

        light.pos = kart:LocalToWorld(lightingOffset)
        light.r = col.r
        light.g = col.g
        light.b = col.b
        light.brightness = 5
        light.Decay = 1000
        light.Size = 50
        light.DieTime = CurTime() + 1
    end)

    hook.Add("PIXEL.Karts.OnRemove", "PIXEL.Karts.CacheCleanup", function(kart)
        colorCache[kart] = nil
    end)
end

PIXEL.Karts.SetupUnderglowDrawing()
cvars.AddChangeCallback("pixel_karts_underglow_enabled", function(_, _, val)
    if val == "0" then return end
    PIXEL.Karts.SetupUnderglowDrawing()
end)