
local CONFIG = PIXEL.Karts.Config
local GARAGE_CONFIG = CONFIG.Garage

--[[
    PIXEL Karts garage ramp configuration.

    Some maps have extremely high kerbs which our poor little
    kart can't actually climb. This can become a massive problem
    when we want to drive in to the PIXEL Karts garage. The solution
    is to make an invisible ramp. You can disable this entirely if
    preferred, in favour for your own PermaProps system.
]]

CONFIG.GarageRamp = {
    Enabled = true, --Set to false to disable spawning the ramp.
    Model = "models/hunter/blocks/cube05x3x025.mdl",
    Position = Vector(-1127.312500, -817.656250, -206.187500),
    Angles = Angle(24.307251, 179.994507, 0)
}

--[[
    PIXEL Karts garage door configuration.

    This is for creating our own fake door. As the client cannot
    control map doors by default, we delete it, make our own
    and animate it how we like.
]]

CONFIG.GarageDoor = {
    Model = "models/hunter/plates/plate3x3.mdl",
    Position = Vector(-1034.875000, -818.687500, -125.937500),
    Angles = Angle(90, 0, 180),
    OpenOffset = Vector(0, 0, 118), --The change difference in position when the door is fully opened.
    MaterialTexture = "metal/metaldoor061a", --The texture that should be applied to our fake door.
    MaterialSettings = "center .5 .5 scale .36 .36 rotate 0 translate .642 .95", --Overrides the texture transform with our own so we can stretch/scale the material.
    MakeCollisions = true, --Creates a prop for players to collide with when they walk into the garage.
    MapDoorID = 2523 --The map creation ID of the door you want to remove in place for our custom one (optional).
}

--[[
    PIXEL Karts garage door mat configuration.

    This is the 3D2D door mat that appears on the ground in front of the
    garage when nearby. You can change the text and positioning/sizing of
    it, or disable it entirely depending on your preference.
]]

CONFIG.GarageDoorMat = {
    Enabled = true, --Set to false to disable the door mat.
    Position = Vector(-1037, -754, -195.9),
    Angles = Angle(0, -90, 0),
    Width = 1280,
    Height = 820
}

--[[
    PIXEL Karts forced door locking configuration.

    These are doors which you don't want people to be able to open
    under any circumstances, normally because the garage is on the
    other side.
]]

CONFIG.ForceLockedDoors = { --A list map creation IDs of the doors you want to force lock, use the "pixel_karts_print_trace_creation_id" command.
    2633,
    2580
}

GARAGE_CONFIG.RadioOrigin = Vector(-814.031250, -882.968750, -151.687500) --The point in space where the garage radio can be heard from.

--[[
    PIXEL Karts spawn position configuration.

    Where the karts are spawned when players leave the garage, and their
    rotation.
]]

GARAGE_CONFIG.SpawnPos = Vector(-1175.125000, -815.625000, -160)
GARAGE_CONFIG.SpawnAngle = Angle(0, 90, 0)

--[[
    PIXEL Karts garage entry, inside and leave position configuration.

    This is for the box check that runs on the client to see if they
    are standing on the garage door mat. The door range check on the
    server, the inside position (where players are hidden) of the garage,
    and the position and angles the player should be put in when they
    leave the garage without a kart.
]]

GARAGE_CONFIG.EntryBoxPoint1 = Vector(-1034.979858, -752.671753, -55.503555)
GARAGE_CONFIG.EntryBoxPoint2 = Vector(-1118.906616, -882.049927, -199.116608)

GARAGE_CONFIG.EntryRangeCheckPoint = Vector(-1079.401855, -816.696777, -175)
GARAGE_CONFIG.EntryRangeCheckRadius = 120

GARAGE_CONFIG.LeavePosition = Vector(-1078.805908, -597.136536, -195)
GARAGE_CONFIG.LeaveAngles = Angle(0, 0, 0)

GARAGE_CONFIG.InsidePosition = Vector(-559.405640, -392.599762, -131.968750)

--[[
    PIXEL Karts garage customisation position configuration.

    This configures the placement of the kart in the garage,
    the camera position and radius of the circle the spray paint
    can should follow around the kart when changing colour.
]]

GARAGE_CONFIG.KartPos = Vector(-881.531250, -790.531250, -191.343750)
GARAGE_CONFIG.KartAngles = Angle(0, -90, 0)

GARAGE_CONFIG.CameraCircleRadius = 115
GARAGE_CONFIG.CameraOffset = Vector(0, 0, 55) --The offset applied to the camera (usually height), from the kart.
GARAGE_CONFIG.CameraAimOffset = Vector(2, 0, 12) --The offset from the kart position we should aim the camera at.
GARAGE_CONFIG.CameraRotation = 40 --The starting rotation of the camera, as if it was in a circle around the kart.

GARAGE_CONFIG.SprayPaintCircleRadius = 50
GARAGE_CONFIG.SprayPaintOffset = Vector(0, 0, 25) --The offset from the kart that the spray paint can should be at.

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
    If you want to add props individually without the builder, you can use the "pixel_karts_print_target"
    command. To use it, place a prop where you prefer it to be, look at it and run the command. It will
    print a prop config table for you to use in this file.

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