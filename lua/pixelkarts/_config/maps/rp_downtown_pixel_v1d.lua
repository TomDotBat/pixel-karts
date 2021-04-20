
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
    Enabled = false --Set to false to disable spawning the ramp.
}

--[[
    PIXEL Karts garage door configuration.

    This is for creating our own fake door. As the client cannot
    control map doors by default, we delete it, make our own
    and animate it how we like.
]]

CONFIG.GarageDoor = {
    Model = "models/hunter/plates/plate4x4.mdl",
    Position = Vector(-9966, 7062.9, -2670),
    Angles = Angle(90, 0, 180),
    OpenOffset = Vector(0, 0, 118), --The change difference in position when the door is fully opened.
    MaterialTexture = "metal/metaldoor061a", --The texture that should be applied to our fake door.
    MaterialSettings = "center .5 .5 scale .32 .32 rotate 0 translate .83 .5", --Overrides the texture transform with our own so we can stretch/scale the material.
    MakeCollisions = false --Creates a prop for players to collide with when they walk into the garage.
}

--[[
    PIXEL Karts garage door mat configuration.

    This is the 3D2D door mat that appears on the ground in front of the
    garage when nearby. You can change the text and positioning/sizing of
    it, or disable it entirely depending on your preference.
]]

CONFIG.GarageDoorMat = {
    Enabled = true, --Set to false to disable the door mat.
    Text = "PIXEL Karts", --The text that should appear on the door mat.
    Position = Vector(-9970, 7134, -2763.6),
    Angles = Angle(0, -90, 5),
    Width = 1440,
    Height = 880
}

GARAGE_CONFIG.RadioOrigin = Vector(-9842.997070, 6946.765625, -2711.539795) --The point in space where the garage radio can be heard from.

--[[
    PIXEL Karts spawn position configuration.

    Where the karts are spawned when players leave the garage, and their
    rotation.
]]

GARAGE_CONFIG.SpawnPos = Vector(-10104.146484, 7062.911621, -2736.141602)
GARAGE_CONFIG.SpawnAngle = Angle(0, 90, 0)

--[[
    PIXEL Karts garage entry, inside and leave position configuration.

    This is for the box check that runs on the client to see if they
    are standing on the garage door mat. The door range check on the
    server, the inside position (where players are hidden) of the garage,
    and the position and angles the player should be put in when they
    leave the garage without a kart.
]]

GARAGE_CONFIG.EntryBoxPoint1 = Vector(-9970, 7134, -2780)
GARAGE_CONFIG.EntryBoxPoint2 = Vector(-10058, 6990, -2700)

GARAGE_CONFIG.EntryRangeCheckPoint = Vector(-10013.449219, 7062.537598, -2699.968750)
GARAGE_CONFIG.EntryRangeCheckRadius = 120

GARAGE_CONFIG.LeavePosition = Vector(-10016.114258, 6945.311523, -2760)
GARAGE_CONFIG.LeaveAngles = Angle(0, 0, 0)

GARAGE_CONFIG.InsidePosition = Vector(-9928.836914, 6961.133301, -2439.531738)

--[[
    PIXEL Karts garage customisation position configuration.

    This configures the placement of the kart in the garage,
    the camera position and radius of the circle the spray paint
    can should follow around the kart when changing colour.
]]

GARAGE_CONFIG.KartPos = Vector(-9828.906250, 7059.781250, -2763.656250)
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
        Model = "models/mark2580/gtav/garage_stuff/tool_draw_01d.mdl",
        Position = Vector(-9830.343750, 6953.718750, -2753.250000),
        Angles = Angle(-0.455933, 89.972534, -0.010986)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/engine_hoist_02a.mdl",
        Position = Vector(-9897.812500, 7180, -2763.687500),
        Angles = Angle(0.076904, -9.470215, 0.027466)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/car_battery_01.mdl",
        Position = Vector(-9728.062500, 7202.593750, -2757.781250),
        Angles = Angle(0, -79.722290, 0.060425)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/ladder.mdl",
        Position = Vector(-9952.812500, 6954, -2728.812500),
        Angles = Angle(12.266235, -178.610229, 0)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/span_02.mdl",
        Position = Vector(-9868.468750, 6947.687500, -2720),
        Angles = Angle(-0.340576, 46.186523, 0.302124)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/tape_01.mdl",
        Position = Vector(-9847.750000, 6957.812500, -2718.843750),
        Angles = Angle(-0.444946, 76.354980, 0.087891)
    },
    {
        Model = "models/unconid/spray_can/spray_can.mdl",
        Position = Vector(-9812.625000, 6963.375000, -2742.375000),
        Angles = Angle(11.953125, 23.741455, -64.066772)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/lubcan.mdl",
        Position = Vector(-9830.031250, 6950.312500, -2717.687500),
        Angles = Angle(1.159058, 129.616699, 0.247192)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/compressor_02.mdl",
        Position = Vector(-9695.218750, 6971.562500, -2763.500000),
        Angles = Angle(0.324097, 141.108398, -0.010986)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/cable02.mdl",
        Position = Vector(-9693.968750, 6969.718750, -2720.406250),
        Angles = Angle(0, -178.126831, 180)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/sacktruck_01.mdl",
        Position = Vector(-9687.062500, 7174.312500, -2763.500000),
        Angles = Angle(-1.010742, -147.804565, 0.043945)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/grinder.mdl",
        Position = Vector(-9779.093750, 6954.593750, -2718.375000),
        Angles = Angle(-42.225952, -111.719971, -178.313599)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/drill_01a.mdl",
        Position = Vector(-9809.750000, 6951.843750, -2713.500000),
        Angles = Angle(-0.335083, 121.140747, 0.472412)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/bench_vice_01a.mdl",
        Position = Vector(-9891.250000, 6961.125000, -2714.406250),
        Angles = Angle(0, 90, 0)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/car_battery_01.mdl",
        Position = Vector(-9751.125000, 7193.656250, -2757.843750),
        Angles = Angle(0.098877, 164.300537, 0)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/car_battery_01.mdl",
        Position = Vector(-9727.562500, 7185.468750, -2757.875000),
        Angles = Angle(0.181274, -70.570679, 0)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/car_battery_01.mdl",
        Position = Vector(-9733.656250, 6957.750000, -2757.937500),
        Angles = Angle(0.016479, 115.565186, 0.049438)
    }
}

--Ignore anything below this.
CONFIG = nil
GARAGE_CONFIG = nil