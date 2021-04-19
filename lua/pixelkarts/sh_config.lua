
PIXEL.Karts.Config = {
    DisableKartsDamagingPlayers = true,
    AbilitiesInOtherKarts = false,

    KartPrice = {
        6000000, --Non VIP
        2500000, --VIP
        1500000 --VIP Plus
    },

    RespawnPrice = { --False means free
        15000,
        10000,
        false
    },

    DefaultColors = {
        Color(255, 0, 191),
        Color(0, 161, 255),
        Color(42, 185, 73),
        Color(185, 183, 32),
        Color(203, 31, 31)
    },

    ExtraDrawRange = 200000,

    Garage = {
        SpawnPos = Vector(-10104.146484, 7062.911621, -2736.141602),
        SpawnAngle = Angle(0, 90, 0),

        EntryBoxPoint1 = Vector(-9970, 7134, -2780),
        EntryBoxPoint2 = Vector(-10058, 6990, -2700),

        EntryRangeCheckPoint = Vector(-10013.449219, 7062.537598, -2699.968750),
        EntryRangeCheckRadius = 120,

        InsidePosition = Vector(-9928.836914, 6961.133301, -2439.531738),

        LeavePosition = Vector(-10016.114258, 6945.311523, -2760),
        LeaveAngles = Angle(0, 0, 0),

        KartPos = Vector(-9828.906250, 7059.781250, -2763.656250),
        KartAngles = Angle(0, -90, 0),

        CameraCircleRadius = 115,
        CameraOffset = Vector(0, 0, 55),
        CameraAimOffset = Vector(2, 0, 12),
        CameraRotation = 40,

        SprayPaintCircleRadius = 50,
        SprayPaintOffset = Vector(0, 0, 25)
    }
}