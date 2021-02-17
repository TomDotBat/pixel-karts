
local defaultLogoId = PIXEL.Karts.Config.Upgrades.Logo.DefaultLogoId

hook.Add("PIXEL.Karts.SetupKartDefault", "PIXEL.Karts.SetupDefaultLogo", function(ply)
    ply:PIXELKartsSetDataKey("logo_imgur_id", defaultLogoId)
end)