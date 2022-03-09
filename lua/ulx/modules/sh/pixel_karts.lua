local function forceLeaveGarage(caller, targets)
    if not (PIXEL.Karts and PIXEL.Karts.TogglePlayerGarageState) then return end

    for i = 1, #targets do
        local target = targets[i]
        if target:GetNWBool("PIXEL.Karts.IsInGarage", false) then
           PIXEL.Karts.TogglePlayerGarageState(target, true)
        end
    end

    ulx.fancyLogAdmin(caller, "#A kicked #T out of the PIXEL Karts garage.", targets)
end

local command = ulx.command("PIXEL Karts", "ulx forceleavegarage", forceLeaveGarage, "!forceleavegarage")
command:addParam({type=ULib.cmds.PlayersArg})
command:defaultAccess(ULib.ACCESS_ADMIN)
command:help("Forces a player to leave the PIXEL Karts garage.")


local function removeKart(caller, targets)
    if not PIXEL.Karts then return end

    for i = 1, #targets do
        local target = targets[i]
        local kart = target:GetNWEntity("PIXEL.Karts.PersonalKart", nil)
        if IsValid(kart) then
            SafeRemoveEntity(kart)
        end
    end

    ulx.fancyLogAdmin(caller, "#A removed #T's PIXEL Kart.", targets)
end

command = ulx.command("PIXEL Karts", "ulx removekart", removeKart, "!removekart")
command:addParam({type=ULib.cmds.PlayersArg})
command:defaultAccess(ULib.ACCESS_ADMIN)
command:help("Forcefully removes a player's PIXEL Kart.")


local function resetKartLogo(caller, targets)
    if not PIXEL.Karts then return end

    for i = 1, #targets do
        local target = targets[i]
        local logoConfig = PIXEL.Karts.Config.Upgrades.Logo

        target:PIXELKartsGetDataKey(logoConfig.DataKey, function(imgurId)
            if not imgurId then return end
            if not IsValid(target) then return end

            target:PIXELKartsSetDataKey(logoConfig.DataKey, logoConfig.DefaultLogoId)
            BroadcastLua([[file.Delete("pixel/]] .. imgurId .. [[.png")]])
        end)

        local kart = target:GetNWEntity("PIXEL.Karts.PersonalKart", nil)
        if IsValid(kart) and kart.SetLogo then
            kart:SetLogo(logoConfig.DefaultLogoId)
        end
    end

    ulx.fancyLogAdmin(caller, "#A reset #T's PIXEL Kart logo.", targets)
end

command = ulx.command("PIXEL Karts", "ulx resetkartlogo", resetKartLogo, "!resetkartlogo")
command:addParam({type=ULib.cmds.PlayersArg})
command:defaultAccess(ULib.ACCESS_ADMIN)
command:help("Forcefully sets a players' PIXEL Kart logo to the default.")
