
hook.Add("stormfox2.postinit", "PIXEL.Karts.StormFox2Integration", function()
    StormFox2.Terrain.Get("snow"):AddTextureSwap("models/freeman/gokart_tyres", "models/freeman/gokart_tyres_snow_diffuse")
end)