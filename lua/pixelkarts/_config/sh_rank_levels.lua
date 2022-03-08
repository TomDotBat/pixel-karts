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

--[[
    VIP level configuration for PIXEL Karts.

    This config is used to assign a "level" to ranks on your server for use
    by PIXEL Karts. Restricted kart upgrades are assigned a level requirement
    number which uses the levels in this file to determine whether or not
    a player is allowed to use/buy it.

    Every player can access upgrades of level 1 or less, so there is no need
    to assign ranks with level 1 or less.

    For example: The underglow upgrade requires level 3. If the user's rank
    name is not in the RANK_LEVELS table, they won't be able to use/buy the
    upgrade. If their rank is in the table, but the level is 2 or lower,
    they won't be able to use/buy the upgrade still. Only when the user's
    rank level is greater than or equal to 3 (the upgrade's requirement)
    will they be able to use/buy the upgrade.
]]

local RANK_LEVELS = {
    ["vip"] = 2,
    ["trialvip"] = 2,
    ["vip+"] = 3,
    ["superadmin"] = 3,
    ["owner"] = 3
}

local USE_SECONDARY_GROUPS = true --If this is set to true, the level system will try to use the player's secondary user group for their rank level instead.

PIXEL.Karts.Config.RankLevelNames = { --The display names of each rank level
    [1] = "None",
    [2] = "VIP", --Rank level 1 displays as "VIP"
    [3] = "VIP+"
}

--[[
    Advanced VIP level configuration for PIXEL Karts.

    Don't edit the methods below unless you know what you are doing.
    Normally, the configuration above should be able to achieve what you want,
    if it can't then changing these methods may be your only option.
    If you need to change these, but don't know how to, please make a support
    ticket before something gets broken.
]]

local meta = FindMetaTable("Player")

function meta:PIXELKartsGetLevel()
    local rank
    if USE_SECONDARY_GROUPS and self.GetSecondaryUserGroup then
        rank = self:GetSecondaryUserGroup()
        if not rank or rank == "user" then rank = nil end
    end

    return RANK_LEVELS[rank or self:GetUserGroup()] or 1
end

function meta:PIXELKartsIsLevel(level)
    if not level then return true end
    if level <= 1 then return true end

    return level <= self:PIXELKartsGetLevel()
end