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
    Enabled = false, --Set to false to disable spawning the ramp.
    Model = "models/hunter/blocks/cube05x3x025.mdl",
    Position = Vector(0, 0, 0),
    Angles = Angle(0, 0, 0)
}

--[[
    PIXEL Karts garage door configuration.

    This is for creating our own fake door. As the client cannot
    control map doors by default, we delete it, make our own
    and animate it how we like.
]]

CONFIG.GarageDoor = {
    Model = "models/hunter/plates/plate4x6.mdl",
    Position = Vector(-5672, -10100, 165.9),
    Angles = Angle(90, 0, 0),
    OpenOffset = Vector(0, 0, 180), --The change difference in position when the door is fully opened.
    MaterialTexture = "metal/metaldoor061a", --The texture that should be applied to our fake door.
    MaterialSettings = "center .5 .5 scale .14 .2 rotate 0 translate .05 .77", --Overrides the texture transform with our own so we can stretch/scale the material.
    MakeCollisions = true --Creates a prop for players to collide with when they walk into the garage.
}


--[[
    PIXEL Karts garage door mat configuration.

    This is the 3D2D door mat that appears on the ground in front of the
    garage when nearby. You can change the text and positioning/sizing of
    it, or disable it entirely depending on your preference.
]]

CONFIG.GarageDoorMat = {
    Enabled = true, --Set to false to disable the door mat.
    Position = Vector(-5676, -9965, 71.1),
    Angles = Angle(0, 270, 5),
    Width = 2560,
    Height = 723
}

GARAGE_CONFIG.RadioOrigin = Vector(-5601.843750, -10196.906250, 115.906250) --The point in space where the garage radio can be heard from.

--[[
    PIXEL Karts spawn position configuration.

    Where the karts are spawned when players leave the garage, and their
    rotation.
]]

GARAGE_CONFIG.SpawnPos = Vector(-5879.286133, -10082.242188, 100)
GARAGE_CONFIG.SpawnAngle = Angle(0, 90, 0)

--[[
    PIXEL Karts garage entry, inside and leave position configuration.

    This is for the box check that runs on the client to see if they
    are standing on the garage door mat. The door range check on the
    server, the inside position (where players are hidden) of the garage,
    and the position and angles the player should be put in when they
    leave the garage without a kart.
]]

GARAGE_CONFIG.EntryBoxPoint1 = Vector(-5681.987305, -9965.455078, 249.779510)
GARAGE_CONFIG.EntryBoxPoint2 = Vector(-5790, -10220.599609, 60.864571)

GARAGE_CONFIG.EntryRangeCheckPoint = Vector(-5715.125977, -10090, 80)
GARAGE_CONFIG.EntryRangeCheckRadius = 150

GARAGE_CONFIG.LeavePosition = Vector(-5711.937500, -10265.630859, 76)
GARAGE_CONFIG.LeaveAngles = Angle(0, 180, 0)

GARAGE_CONFIG.InsidePosition = Vector(-5360.993164, -10670.563477, 135.031250)

--[[
    PIXEL Karts garage customisation position configuration.

    This configures the placement of the kart in the garage,
    the camera position and radius of the circle the spray paint
    can should follow around the kart when changing colour.
]]

GARAGE_CONFIG.KartPos = Vector(-5553.980957, -10093.254883, 75)
GARAGE_CONFIG.KartAngles = Angle(0, 270, 0)

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
        Model = "models/mark2580/gtav/garage_stuff/engine_hoist_02a.mdl",
        Position = Vector(-5410.406250, -10182.312500, 71.375000),
        Angles = Angle(0.087891, 140.784302, 0.076904)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/tool_draw_01d.mdl",
        Position = Vector(-5545.812500, -10197.906250, 82.718750),
        Angles = Angle(-0.302124, 89.994507, 0.000000)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/compressor_02.mdl",
        Position = Vector(-5641.781250, -10187.468750, 71.500000),
        Angles = Angle(0.148315, 61.622314, 0.000000)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/grinder.mdl",
        Position = Vector(-5496.812500, -10198.218750, 118.062500),
        Angles = Angle(-42.945557, -53.327637, -178.978271)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/ladder.mdl",
        Position = Vector(-5548.218750, -9971.687500, 109.125000),
        Angles = Angle(6.893921, 89.956055, 0.192261)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/car_battery_01.mdl",
        Position = Vector(-5511.437500, -9975.437500, 77.875000),
        Angles = Angle(-0.609741, -151.776123, 0.104370)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/cable02.mdl",
        Position = Vector(-5498.062500, -9972.875000, 77.812500),
        Angles = Angle(-24.812622, 129.006958, -154.802856)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/sacktruck_01.mdl",
        Position = Vector(-5463.500000, -9981.312500, 71.593750),
        Angles = Angle(-1.851196, -75.646362, -0.302124)
    },
    {
        Model = "models/props/cs_office/radio.mdl",
        Position = Vector(-5601.843750, -10196.906250, 115.906250),
        Angles = Angle(-1.455688, 75.119019, 0.076904),
        NeedsCss = true
    }
}

--Ignore anything below this.
CONFIG = nil