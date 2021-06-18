
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
}

--[[
    PIXEL Karts garage door configuration.

    This is for creating our own fake door. As the client cannot
    control map doors by default, we delete it, make our own
    and animate it how we like.
]]

CONFIG.GarageDoor = {
    Model = "models/hunter/plates/plate3x4.mdl",
    Position = Vector(4894.343750, 187.687500, -333.531250),
    Angles = Angle(0.000000, -179.994507, -90.049438),
    OpenOffset = Vector(0, 0, 118), --The change difference in position when the door is fully opened.
    MaterialTexture = "metal/metaldoor061a", --The texture that should be applied to our fake door.
    MaterialSettings = "center .5 .5 scale .26 .34 rotate 90 translate .986 .195", --Overrides the texture transform with our own so we can stretch/scale the material.
    MakeCollisions = true, --Creates a prop for players to collide with when they walk into the garage.
    MapDoorID = 1737 --The map creation ID of the door you want to remove in place for our custom one (optional).
}

--[[
    PIXEL Karts garage door mat configuration.

    This is the 3D2D door mat that appears on the ground in front of the
    garage when nearby. You can change the text and positioning/sizing of
    it, or disable it entirely depending on your preference.
]]

CONFIG.GarageDoorMat = {
    Enabled = true, --Set to false to disable the door mat.
    Position = Vector(4962.9223632813, 190.09809875488, -427.96875),
    Angles = Angle(0, 180, -7.5),
    Width = 1349,
    Height = 820
}

--[[
    PIXEL Karts forced door locking configuration.

    These are doors which you don't want people to be able to open
    under any circumstances, normally because the garage is on the
    other side.
]]

CONFIG.ForceLockedDoors = { --A list map creation IDs of the doors you want to force lock, use the "pixel_karts_print_trace_creation_id" command.
    1740
}

GARAGE_CONFIG.RadioOrigin = Vector(4715.281250, -210.031250, -368.937500) --The point in space where the garage radio can be heard from.

--[[
    PIXEL Karts spawn position configuration.

    Where the karts are spawned when players leave the garage, and their
    rotation.
]]

GARAGE_CONFIG.SpawnPos = Vector(4660.372070, 240.616699, -372.223328)
GARAGE_CONFIG.SpawnAngle = Angle(0, 0, 0)

--[[
    PIXEL Karts garage entry, inside and leave position configuration.

    This is for the box check that runs on the client to see if they
    are standing on the garage door mat. The door range check on the
    server, the inside position (where players are hidden) of the garage,
    and the position and angles the player should be put in when they
    leave the garage without a kart.
]]

GARAGE_CONFIG.EntryBoxPoint1 = Vector(4962.2412109375, 189.47187805176, -254.03125)
GARAGE_CONFIG.EntryBoxPoint2 = Vector(4828.1840820313, 279.16168212891, -450)

GARAGE_CONFIG.EntryRangeCheckPoint = Vector(4893.653809, 229.379028, -358.661255)
GARAGE_CONFIG.EntryRangeCheckRadius = 120

GARAGE_CONFIG.LeavePosition = Vector(4786.599609, 260.846008, -390)
GARAGE_CONFIG.LeaveAngles = Angle(0, 90, 0)

GARAGE_CONFIG.InsidePosition = Vector(4176.031250, 22.968750, -311.968750)

--[[
    PIXEL Karts garage customisation position configuration.

    This configures the placement of the kart in the garage,
    the camera position and radius of the circle the spray paint
    can should follow around the kart when changing colour.
]]

GARAGE_CONFIG.KartPos = Vector(4786.419434, 24.448681, -422)
GARAGE_CONFIG.KartAngles = Angle(0, 270, 0)

GARAGE_CONFIG.DisableDriveInAnim = true

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
        Model = "models/mark2580/gtav/garage_stuff/ladder.mdl",
        Position = Vector(4954.500000, 2.843750, -390.312500),
        Angles = Angle(11.618042, -0.318604, 0.038452)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/engine_hoist_02a.mdl",
        Position = Vector(4658.812500, -54.687500, -427.593750),
        Angles = Angle(0.071411, 41.259155, -0.082397)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/tool_draw_01d.mdl",
        Position = Vector(4781.593750, -127.750000, -416.250000),
        Angles = Angle(-0.439453, 89.983521, 0.000000)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/tape_01.mdl",
        Position = Vector(4843.312500, -132.406250, -382.062500),
        Angles = Angle(-0.444946, 121.723022, -0.263672)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/lubcan.mdl",
        Position = Vector(4826.312500, -128.312500, -380.156250),
        Angles = Angle(-0.686646, -159.856567, -1.488647)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/compressor_02.mdl",
        Position = Vector(4924.656250, -61.625000, -427.406250),
        Angles = Angle(0.329590, 142.822266, 0.000000)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/grinder.mdl",
        Position = Vector(4728.250000, -124.843750, -379.250000),
        Angles = Angle(0.329590, -130.885620, -179.615479)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/car_battery_01.mdl",
        Position = Vector(4798.437500, -130.062500, -377.343750),
        Angles = Angle(-0.351563, 53.206787, 0.263672)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/cable02.mdl",
        Position = Vector(4765.187500, -127.781250, -380.562500),
        Angles = Angle(-0.466919, 37.705078, 0.302124)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/bench_vice_01a.mdl",
        Position = Vector(4820.593750, -207.593750, -362.531250),
        Angles = Angle(-1.153564, 78.601685, 2.356567)
    },
    {
        Model = "models/props/cs_office/radio.mdl",
        Position = Vector(4715.281250, -210.031250, -368.937500),
        Angles = Angle(-2.735596, 87.286377, 5.300903),
        NeedsCss = true
    }
}

--Ignore anything below this.
CONFIG = nil