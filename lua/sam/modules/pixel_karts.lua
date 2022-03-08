--[[
    PIXEL Karts
    Copyright (C) 2022 Thomas (Tom.bat) O'Sullivan 

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program. If not, see <https://www.gnu.org/licenses/>.
]]

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

sam.command.new("removekart")
:SetCategory("PIXEL Karts")
:Help("Forcefully removes a players' PIXEL Kart.")
:SetPermission("removekart", "admin")

:AddArg("player")

:OnExecute(function(caller, targets)
    if not PIXEL.Karts then return end

    for i = 1, #targets do
        local target = targets[i]
        local kart = target:GetNWEntity("PIXEL.Karts.PersonalKart", nil)
        if IsValid(kart) then
            SafeRemoveEntity(kart)
        end
    end

    sam.player.send_message(nil, "{A} removed {T}'s PIXEL Kart.", {
        A = caller, T = targets
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

            target:PIXELKartsSetDataKey(logoConfig.DataKey, logoConfig.DefaultLogoId)
            BroadcastLua([[file.Delete("pixel/]] .. imgurId .. [[.png")]])
        end)


        local kart = target:GetNWEntity("PIXEL.Karts.PersonalKart", nil)
        if IsValid(kart) and kart.SetLogo then
            kart:SetLogo(logoConfig.DefaultLogoId)
        end
    end

    sam.player.send_message(nil, "{A} reset {T}'s PIXEL Kart logo.", {
        A = caller, T = targets
    })
end)
:End()