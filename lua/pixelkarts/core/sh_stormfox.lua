hook.Add("stormfox2.postinit", "PIXEL.Karts.StormFox2Integration", function()
    StormFox2.Terrain.Get("snow"):AddTextureSwap("models/freeman/gokart_tyres", "models/freeman/gokart_tyres_snow_diffuse")
end)

hook.Add("StormFox.TexHandler.Default", "PIXEL.Karts.StormFox1Integration", function()
    return {
        snow = {["models/freeman/gokart_tyres"] = "models/freeman/gokart_tyres_snow_diffuse"}
    }
end)