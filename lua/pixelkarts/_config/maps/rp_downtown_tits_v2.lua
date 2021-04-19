
local CONFIG = PIXEL.Karts.Config

--[[
    Placement configuration for props within the PIXEL Karts Garage.

    Example prop:
    {
        Model = "models/props/cs_office/radio.mdl",
        Position = Vector(-814.031250, -882.968750, -151.687500),
        Angles = Angle(0, 104.529419, 0),
        NeedsCss = true --Only tries to spawn the prop when the client has CSS installed, you can omit this line if the prop doesn't need CSS
    }

    Adding props to this file isn't recommended whatsoever, unless you hate yourself of course.
    Instead, use the "pixel_karts_decoration_builder" convar to log the props you spawn and generate
    this config for you.

    To use this, open your console and type "pixel_karts_decoration_builder 1" and place the props
    in where you want them. Once finished, type "pixel_karts_decoration_builder 0" in to
    your console. This will print out a prop config you can paste into this file, note that the "NeedsCss"
    key doesn't get added automatically, so you will have to find the CSS props in the output and add the key
    yourself.

    The Garage Props system is entirely optional, but recommended for performance benefits, you can
    simply empty the GarageProps table or delete it entirely to use your own system (PermaProps for example).
]]

CONFIG.GarageProps = {
    {
        Model = "models/mark2580/gtav/garage_stuff/bench_vice_01a.mdl",
        Position = Vector(-928.718750, -865.968750, -144.812500),
        Angles = Angle(-0.609741, 90.005493, 0.076904)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/car_battery_01.mdl",
        Position = Vector(-962.687500, -862.937500, -189.843750),
        Angles = Angle(0, 136.527100, 0.362549)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/cable02.mdl",
        Position = Vector(-782.843750, -873.968750, -151.875000),
        Angles = Angle(-0.269165, -34.656372, 179.807739)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/compressor_02.mdl",
        Position = Vector(-782.343750, -874.125000, -195.500000),
        Angles = Angle(0.307617, 90.005493, -0.115356)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/drill_01a.mdl",
        Position = Vector(-875.125000, -875.781250, -144),
        Angles = Angle(-0.390015, 145.920410, -0.258179)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/engine_hoist_02a.mdl",
        Position = Vector(-966.656250, -642.250000, -195.593750),
        Angles = Angle(0.082397, -11.821289, -0.065918)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/grinder.mdl",
        Position = Vector(-904.812500, -873, -148.781250),
        Angles = Angle(-41.028442, -30.668335, -179.604492)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/ladder.mdl",
        Position = Vector(-993.375000, -883.468750, -158.781250),
        Angles = Angle(14.749146, -91.411743, 0.076904)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/lubcan.mdl",
        Position = Vector(-822.531250, -877.750000, -148.281250),
        Angles = Angle(0.845947, -161.218872, -1.340332)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/sacktruck_01.mdl",
        Position = Vector(-1006.093750, -705.062500, -195.406250),
        Angles = Angle(-0.071411, 29.333496, -0.065918)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/span_02.mdl",
        Position = Vector(-852.062500, -875.625000, -151.062500),
        Angles = Angle(-0.269165, 48.273926, -0.087891)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/tool_draw_01d.mdl",
        Position = Vector(-874.625000, -873.250000, -184.437500),
        Angles = Angle(-0.521851, 89.983521, 0)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/tape_01.mdl",
        Position = Vector(-834.062500, -873.687500, -149.906250),
        Angles = Angle(0.098877, 26.455078, 0.911865)
    },
    {
        Model = "models/props/cs_office/radio.mdl",
        Position = Vector(-814.031250, -882.968750, -151.687500),
        Angles = Angle(0, 104.529419, 0),
        NeedsCss = true
    }
}

--Ignore anything below this.
CONFIG = nil