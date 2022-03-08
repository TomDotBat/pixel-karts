concommand.Add("pixel_karts_print_trace_creation_id", function(ply)
    local tr = ply:GetEyeTrace()
    if not tr.Hit then return end
    ply:PrintMessage(HUD_PRINTCONSOLE, tr.Entity:MapCreationID())
end)