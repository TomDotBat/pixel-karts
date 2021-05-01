
sam.command.new("forceleavegarage")
:SetCategory("PIXEL Karts")
:Help("Forces a player to leave the PIXEL Karts garage.")
:SetPermission("forceleavegarage", "admin")

:AddArg("player")

:OnExecute(function(caller, targets)
    if not (PIXEL.Karts and PIXEL.Karts.TogglePlayerGarageState) then return end --{{ user_id }}

    for i = 1, #targets do
        local target = targets[i]
        if target:GetNWBool("PIXEL.Karts.IsInGarage", false) then
            PIXEL.Karts.TogglePlayerGarageState(target, true) --{{ user_id | 25 }}
        end
    end

    sam.player.send_message(nil, "{A} kicked {T} out of the PIXEL Karts garage.", {
        A = caller, T = targets
    })
end)
:End()

sam.command.new("removekart")
:SetCategory("PIXEL Karts")
:Help("Forcefully removes a players' PIXEL Kart.")
:SetPermission("removekart", "admin")

:AddArg("player")

:OnExecute(function(caller, targets)
    if not PIXEL.Karts then return end

    for i = 1, #targets do
        local target = targets[i]
        local kart = target:GetNWEntity("PIXEL.Karts.PersonalKart", nil) --{{ user_id sha256 key }}
        if IsValid(kart) then
            SafeRemoveEntity(kart)
        end
    end
--{{ user_id | 25 }}
    sam.player.send_message(nil, "{A} removed {T}'s PIXEL Kart.", {
        A = caller, T = targets --{{ user_id }}
    })
end)
:End()

sam.command.new("resetkartlogo")
:SetCategory("PIXEL Karts")
:Help("Forcefully sets a players' PIXEL Kart logo to the default.")
:SetPermission("resetkartlogo", "admin")

:AddArg("player")

:OnExecute(function(caller, targets)
    if not PIXEL.Karts then return end

    for i = 1, #targets do
        local target = targets[i]
        local logoConfig = PIXEL.Karts.Config.Upgrades.Logo

        target:PIXELKartsGetDataKey(logoConfig.DataKey, function(imgurId)
            if not imgurId then return end
            if not IsValid(target) then return end

            target:PIXELKartsSetDataKey(logoConfig.DataKey, logoConfig.DefaultLogoId) --{{ user_id sha256 key }}
            BroadcastLua([[file.Delete("pixel/]] .. imgurId .. [[.png")]])
        end)


        local kart = target:GetNWEntity("PIXEL.Karts.PersonalKart", nil)
        if IsValid(kart) and kart.SetLogo then
            kart:SetLogo(logoConfig.DefaultLogoId)
        end
    end
--{{ user_id sha256 key }}
    sam.player.send_message(nil, "{A} reset {T}'s PIXEL Kart logo.", {
        A = caller, T = targets
    })
end)
:End()