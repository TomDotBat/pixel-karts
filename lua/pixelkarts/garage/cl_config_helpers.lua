
local trackedEnts
local function startBuildMode()
    trackedEnts = {}

    hook.Add("OnEntityCreated", "PIXEL.Karts.DecorationBuilder", function(ent)
        if not (IsValid(ent) and  ent:GetClass() == "prop_physics") then return end
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
    model = "%s",
    position = Vector(%f, %f, %f),
    angles = Angle(%f, %f, %f)
},]], ent:GetModel(), pos.x, pos.y, pos.z, ang.p, ang.y, ang.r))
    end

    trackedEnts = nil
end

CreateClientConVar("pixel_karts_decoration_builder", "0", false, false, "Enable PIXEL Karts decoration builder mode.", 0, 1)
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
model = "%s",
position = Vector(%f, %f, %f),
angles = Angle(%f, %f, %f)
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
    position = Vector(%f, %f, %f),
    angles = Angle(%f, %f, %f)
},]], i, pos.x, pos.y, pos.z, ang.p, ang.y, ang.r))
    end
end)

concommand.Add("pixel_karts_print_trace_pos", function()
    local tr = LocalPlayer():GetEyeTrace()
    if not tr.Hit then return end
    print(tr.HitPos.x .. ", " .. tr.HitPos.y .. ", " .. tr.HitPos.z)
end)