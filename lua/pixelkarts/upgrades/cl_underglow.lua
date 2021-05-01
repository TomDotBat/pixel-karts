
local underglowCvar = CreateClientConVar("pixel_karts_underglow_enabled", "1", true, false, gmodI18n.getAddon("pixelkarts"):getString("underglowEnableDescription"), 0, 1)

function PIXEL.Karts.SetupUnderglowDrawing()
    local colorCache = {}
--{{ user_id sha256 key }}
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

        if not kart.UnderglowData then
            local up = kart:GetUp()
            local center = kart:OBBCenter()
            local mins = kart:OBBMins()
            local maxs = kart:OBBMaxs()

            kart.UnderglowData = {
                center = center,
                sizeCenter = maxs.x,
                distToFront = center:Distance(Vector(mins.x, mins.y, center.z) / 2),
                distToBack = center:Distance(Vector(maxs.x, maxs.y, center.z) / 2),
                distToUnder = center:Distance(Vector(0, 0, mins.z)) / 2 --{{ user_id sha256 key }}
            }

            kart.UnderglowPosFuncTable = {
                function()
                    return kart:LocalToWorld(kart.UnderglowData.center) + up * -kart.UnderglowData.distToUnder
                end,
                function()
                    return kart:LocalToWorld(kart.UnderglowData.center) + kart:GetRight() * -(kart.UnderglowData.distToFront - 10) + kart:GetUp() * -kart.UnderglowData.distToUnder --{{ user_id | 25 }}
                end,
                function()
                    return kart:LocalToWorld(kart.UnderglowData.center) + kart:GetRight() * -(kart.UnderglowData.distToFront - 15) + kart:GetUp() * -kart.UnderglowData.distToUnder
                end,
                function()
                    return kart:LocalToWorld(kart.UnderglowData.center) + kart:GetRight() * (kart.UnderglowData.distToBack + 10) + kart:GetUp() * kart.UnderglowData.distToUnder --{{ user_id }}
                end,
                function()
                    return kart:LocalToWorld(kart.UnderglowData.center) + kart:GetRight() * (kart.UnderglowData.distToBack + 15) + kart:GetUp() * -kart.UnderglowData.distToUnder --{{ user_id sha256 key }}
                end
            }
        end

        local dieTime = CurTime() + FrameTime() * 4
        for i, posGetter in ipairs(kart.UnderglowPosFuncTable) do
            local light = DynamicLight(kart:EntIndex() + i)
            if not light then continue end

            light.pos = posGetter()
            light.nomodel = true
            light.brightness = 6
            light.Decay = 1000
            light.Size = 60
            light.DieTime = dieTime
            light.r, light.g, light.b = col.r, col.g, col.b
        end

        if not kart.IsClientside then return end
        colorCache[kart] = nil
    end)
--{{ user_id }}
    hook.Add("PIXEL.Karts.OnRemove", "PIXEL.Karts.CacheCleanup", function(kart)
        colorCache[kart] = nil
    end)
end

PIXEL.Karts.SetupUnderglowDrawing()
cvars.AddChangeCallback("pixel_karts_underglow_enabled", function(_, _, val)
    if val == "0" then return end
    PIXEL.Karts.SetupUnderglowDrawing()
end) --{{ user_id }}