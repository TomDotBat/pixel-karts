
sam.command.new("forceleavegarage")
:SetCategory("PIXEL Karts")
:Help("Forces a player to leave the PIXEL Karts garage.")
:SetPermission("forceleavegarage", "admin")

:AddArg("player")

:OnExecute(function(caller, targets)
    if not (PIXEL.Karts and PIXEL.Karts.TogglePlayerGarageState) then return end

    for i = 1, #targets do
        local target = targets[i]
        if target:GetNWBool("PIXEL.Karts.IsInGarage", false) then
            PIXEL.Karts.TogglePlayerGarageState(target, true)
        end
    end

    sam.player.send_message(nil, "{A} kicked {T} out of the PIXEL Karts garage.", {
        A = caller, T = targets
    })
end)
:End()