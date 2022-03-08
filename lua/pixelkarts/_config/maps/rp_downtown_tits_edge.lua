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
    Position = Vector(-1466.406250, -7217.343750, -206.062500),
    Angles = Angle(22.071533, 89.972534, -0.010986)
}

--[[
    PIXEL Karts garage door configuration.

    This is for creating our own fake door. As the client cannot
    control map doors by default, we delete it, make our own
    and animate it how we like.
]]

CONFIG.GarageDoor = {
    Model = "models/hunter/plates/plate3x3.mdl",
    Position = Vector(-1465.4, -7634.6328125, -124.5),
    Angles = Angle(90, 0, 270),
    OpenOffset = Vector(0, 0, 118), --The change difference in position when the door is fully opened.
    MaterialTexture = "metal/metaldoor061a", --The texture that should be applied to our fake door.
    MaterialSettings = "center .5 .5 scale .36 .36 rotate 0 translate .642 .95", --Overrides the texture transform with our own so we can stretch/scale the material.
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
    Position = Vector(-1400.5349121094, -7632.3447265625, -195.96875),
    Angles = Angle(0, 180, 0),
    Width = 1280,
    Height = 820
}

GARAGE_CONFIG.RadioOrigin = Vector(-1554.250000, -7890.718750, -152.437500) --The point in space where the garage radio can be heard from.

--[[
    PIXEL Karts spawn position configuration.

    Where the karts are spawned when players leave the garage, and their
    rotation.
]]

GARAGE_CONFIG.SpawnPos = Vector(-1464.448608, -7449.768555, -190)
GARAGE_CONFIG.SpawnAngle = Angle(0, 0, 0)

--[[
    PIXEL Karts garage entry, inside and leave position configuration.

    This is for the box check that runs on the client to see if they
    are standing on the garage door mat. The door range check on the
    server, the inside position (where players are hidden) of the garage,
    and the position and angles the player should be put in when they
    leave the garage without a kart.
]]

GARAGE_CONFIG.EntryBoxPoint1 = Vector(-1528.5108642578, -7550.3745117188, -195.96875)
GARAGE_CONFIG.EntryBoxPoint2 = Vector(-1400.6903076172, -7631.96875, -56.913269042969)

GARAGE_CONFIG.EntryRangeCheckPoint = Vector(-1463.941162, -7587.860352, -131.968750)
GARAGE_CONFIG.EntryRangeCheckRadius = 120

GARAGE_CONFIG.LeavePosition = Vector(-1353.225220, -7588.573730, -185)
GARAGE_CONFIG.LeaveAngles = Angle(0, 0, 0)

GARAGE_CONFIG.InsidePosition = Vector(-1471.066406, -7953.504395, -131.968750)

--[[
    PIXEL Karts garage customisation position configuration.

    This configures the placement of the kart in the garage,
    the camera position and radius of the circle the spray paint
    can should follow around the kart when changing colour.
]]

GARAGE_CONFIG.KartPos = Vector(-1466.830444, -7715, -189)
GARAGE_CONFIG.KartAngles = Angle(0, -90, 0)

GARAGE_CONFIG.DisableDriveInAnim = true

GARAGE_CONFIG.CameraCircleRadius = 100
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
        Model = "models/mark2580/gtav/garage_stuff/compressor_02.mdl",
        Position = Vector(-1553.687500, -7890.281250, -193.468750),
        Angles = Angle(0.159302, 45.648193, 0.021973)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/tape_01.mdl",
        Position = Vector(-1521.250000, -7916.593750, -148.062500),
        Angles = Angle(-0.296631, 98.679199, -0.071411)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/bench_vice_01a.mdl",
        Position = Vector(-1497.875000, -7907.125000, -142.906250),
        Angles = Angle(-0.252686, 90.000000, -0.038452)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/lubcan.mdl",
        Position = Vector(-1478.218750, -7916.718750, -146.031250),
        Angles = Angle(-0.664673, 135.021973, 0.988770)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/drill_01a.mdl",
        Position = Vector(-1451.000000, -7914.750000, -142.031250),
        Angles = Angle(0.280151, 137.625732, -0.796509)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/grinder.mdl",
        Position = Vector(-1431.000000, -7917.875000, -145.343750),
        Angles = Angle(0.027466, -34.601440, 179.280396)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/span_02.mdl",
        Position = Vector(-1406.093750, -7918.000000, -148.937500),
        Angles = Angle(-0.241699, 37.337036, 0.093384)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/tool_draw_01d.mdl",
        Position = Vector(-1464.375000, -7915.750000, -182.218750),
        Angles = Angle(-0.263672, 89.994507, -0.010986)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/engine_hoist_02a.mdl",
        Position = Vector(-1418.218750, -7802.343750, -193.656250),
        Angles = Angle(0.032959, -163.366699, -0.016479)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/ladder.mdl",
        Position = Vector(-1568.531250, -7744.031250, -156.406250),
        Angles = Angle(11.749878, 179.967041, -0.021973)
    },
    {
        Model = "models/props/cs_office/radio.mdl",
        Position = Vector(-1554.250000, -7890.718750, -152.437500),
        Angles = Angle(0.483398, 58.628540, 0.054932),
        NeedsCss = true
    }
}

--Ignore anything below this.
CONFIG = nil