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

local trackedEnts
local function startBuildMode()
    trackedEnts = {}

    hook.Add("OnEntityCreated", "PIXEL.Karts.DecorationBuilder", function(ent)
        if not (IsValid(ent) and ent:GetClass() == "prop_physics") then return end
        table.insert(trackedEnts, ent)
    end)
end

local function endBuildMode()
    hook.Remove("OnEntityCreated", "PIXEL.Karts.DecorationBuilder")

    if table.IsEmpty(trackedEnts) then return end

    for i, ent in ipairs(trackedEnts) do
        if not IsValid(ent) then continue end
        local pos, ang = ent:GetPos(), ent:GetAngles()

        print(string.format([[{
    Model = "%s",
    Position = Vector(%f, %f, %f),
    Angles = Angle(%f, %f, %f)
},]], ent:GetModel(), pos.x, pos.y, pos.z, ang.p, ang.y, ang.r))
    end

    trackedEnts = nil
end

CreateClientConVar("pixel_karts_decoration_builder", "0", false, false, gmodI18n.getAddon("pixelkarts"):getString("decorationBuilderDescription"), 0, 1)
cvars.AddChangeCallback("pixel_karts_decoration_builder", function(_, _, val)
    if val == "0" then
        endBuildMode()
        return
    end
    startBuildMode()
end)

concommand.Add("pixel_karts_print_target", function()
    local tr = LocalPlayer():GetEyeTrace()
    local ent = tr.Entity
    if not IsValid(ent) then return end

    local pos, ang = ent:GetPos(), ent:GetAngles()

    print(string.format([[{
Model = "%s",
Position = Vector(%f, %f, %f),
Angles = Angle(%f, %f, %f)
},]], ent:GetModel(), pos.x, pos.y, pos.z, ang.p, ang.y, ang.r))
end)

concommand.Add("pixel_karts_print_bone_manipulations", function()
    local tr = LocalPlayer():GetEyeTrace()
    local ent = tr.Entity
    if not IsValid(ent) then return end

    local entPos = ent:GetPos()

    for i = 0, ent:GetBoneCount() - 1 do
        local pos, ang = ent:GetBonePosition(i)
        if pos == entPos then
            local matrix = ent:GetBoneMatrix(i)
            pos = matrix:GetTranslation()
            ang = matrix:GetAngles()
        end

        pos = ent:WorldToLocal(pos)
        ang = ent:WorldToLocalAngles(ang)

        print(string.format([[[%i] = {
    Position = Vector(%f, %f, %f),
    Angles = Angle(%f, %f, %f)
},]], i, pos.x, pos.y, pos.z, ang.p, ang.y, ang.r))
    end
end)

concommand.Add("pixel_karts_print_trace_pos", function()
    local tr = LocalPlayer():GetEyeTrace()
    if not tr.Hit then return end
    print(tr.HitPos.x .. ", " .. tr.HitPos.y .. ", " .. tr.HitPos.z)
end)