
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
    Enabled = false , --Set to false to disable spawning the ramp.
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
    Model = "models/hunter/plates/plate6x7.mdl",
    Position = Vector(-7956.062500, -782.156250, 150),
    Angles = Angle(90, 0, 180),
    OpenOffset = Vector(0, 0, 200), --The change difference in position when the door is fully opened.
    MaterialTexture = "metal/metaldoor030a", --The texture that should be applied to our fake door.
    MaterialSettings = "center .5 .5 scale .17 .18 rotate 0 translate .32 .7", --Overrides the texture transform with our own so we can stretch/scale the material.
    MakeCollisions = true, --Creates a prop for players to collide with when they walk into the garage.
    MapDoorID = 3965 --The map creation ID of the door you want to remove in place for our custom one (optional).
}

--[[
    PIXEL Karts garage door mat configuration.

    This is the 3D2D door mat that appears on the ground in front of the
    garage when nearby. You can change the text and positioning/sizing of
    it, or disable it entirely depending on your preference.
]]

CONFIG.GarageDoorMat = {
    Enabled = true, --Set to false to disable the door mat.
    Position = Vector(-7936, -895.96490478516, 0.1),
    Angles = Angle(0, 90, 0),
    Width = 2559,
    Height = 1000
}

GARAGE_CONFIG.RadioOrigin = Vector(-8150.375000, -982.625000, 52.750000) --The point in space where the garage radio can be heard from.

--[[
    PIXEL Karts spawn position configuration.

    Where the karts are spawned when players leave the garage, and their
    rotation.
]]

GARAGE_CONFIG.SpawnPos = Vector(-7756.035156, -766.935242, 15)
GARAGE_CONFIG.SpawnAngle = Angle(0, -90, 0)

--[[
    PIXEL Karts garage entry, inside and leave position configuration.

    This is for the box check that runs on the client to see if they
    are standing on the garage door mat. The door range check on the
    server, the inside position (where players are hidden) of the garage,
    and the position and angles the player should be put in when they
    leave the garage without a kart.
]]

GARAGE_CONFIG.EntryBoxPoint1 = Vector(-7836.0473632813, -640.03070068359, 0)
GARAGE_CONFIG.EntryBoxPoint2 = Vector(-7951.96875, -895.96844482422, 264.07800292969)

GARAGE_CONFIG.EntryRangeCheckPoint = Vector(-7881.815430, -767.317444, 5)
GARAGE_CONFIG.EntryRangeCheckRadius = 200

GARAGE_CONFIG.LeavePosition = Vector(-7897.087891, -959.062134, 10)
GARAGE_CONFIG.LeaveAngles = Angle(0, 0, 0)

GARAGE_CONFIG.InsidePosition = Vector(-8871.968750, -568.031250, 72.0312500)

--[[
    PIXEL Karts garage customisation position configuration.

    This configures the placement of the kart in the garage,
    the camera position and radius of the circle the spray paint
    can should follow around the kart when changing colour.
]]

GARAGE_CONFIG.KartPos = Vector(-8111.481445, -767.093018, 12)
GARAGE_CONFIG.KartAngles = Angle(0, 90, 0)

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
        Position = Vector(-8019.343750, -953.750000, 8.343750),
        Angles = Angle(0.065918, 131.962280, 0.010986)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/tool_draw_01d.mdl",
        Position = Vector(-8128.093750, -982.031250, 19.781250),
        Angles = Angle(-0.219727, 90.000000, 0.000000)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/tape_01.mdl",
        Position = Vector(-8070.000000, -985.687500, 54.031250),
        Angles = Angle(-0.494385, 115.675049, 0.291138)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/car_battery_01.mdl",
        Position = Vector(-8190.781250, -987.281250, 58.625000),
        Angles = Angle(0.373535, 43.621216, 0.159302)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/cable02.mdl",
        Position = Vector(-8168.718750, -992.187500, 55.437500),
        Angles = Angle(-0.164795, 43.972778, 0.115356)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/drill_01a.mdl",
        Position = Vector(-8130.312500, -983.656250, 55.000000),
        Angles = Angle(-0.758057, -38.622437, 92.230225)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/compressor_02.mdl",
        Position = Vector(-8235.031250, -976.250000, 8.562500),
        Angles = Angle(0.329590, 79.156494, 0.000000)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/span_02.mdl",
        Position = Vector(-8086.718750, -982.156250, 53.343750),
        Angles = Angle(-0.274658, 140.581055, 179.538574)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/ladder.mdl",
        Position = Vector(-8179.312500, -560.750000, 45.500000),
        Angles = Angle(12.244263, 90.000000, 0.005493)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/sacktruck_01.mdl",
        Position = Vector(-8143.343750, -569.156250, 8.562500),
        Angles = Angle(-0.148315, -115.916748, 0.098877)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/car_battery_01.mdl",
        Position = Vector(-8112.343750, -567.468750, 14.125000),
        Angles = Angle(-0.060425, -72.844849, 0.005493)
    },
    {
        Model = "models/mark2580/gtav/garage_stuff/bench_vice_01a.mdl",
        Position = Vector(-8109.468750, -974.437500, 59.156250),
        Angles = Angle(-0.038452, 90.000000, 0.010986)
    },
    {
        Model = "models/props/cs_office/radio.mdl",
        Position = Vector(-8150.375000, -982.625000, 52.750000),
        Angles = Angle(-0.054932, 73.311768, 0.082397),
        NeedsCss = true
    }
}

--Ignore anything below this.
CONFIG = nil