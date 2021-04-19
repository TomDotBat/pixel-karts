
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

        --Ramp = {
        --    Model = "models/hunter/blocks/cube05x3x025.mdl",
        --    Position = Vector(-1127.312500, -817.656250, -206.187500),
        --    Angles = Angle(24.307251, 179.994507, 0.000000)
        --},

        EntryBoxPoint1 = Vector(-9970, 7134, -2780),
        EntryBoxPoint2 = Vector(-10058, 6990, -2700),

        EntryRangeCheckPoint = Vector(-10013.449219, 7062.537598, -2699.968750),
        EntryRangeCheckRadius = 120,

        InsidePosition = Vector(-9928.836914, 6961.133301, -2439.531738),

        LeavePosition = Vector(-10016.114258, 6945.311523, -2760),
        LeaveAngles = Angle(0, 0, 0),

        KartPos = Vector(-9828.906250, 7059.781250, -2763.656250),
        KartAngles = Angle(0, -90, 0),

        KartHoloColor = Color(120, 200, 120, 255),

        CameraCircleRadius = 115,
        CameraOffset = Vector(0, 0, 55),
        CameraAimOffset = Vector(2, 0, 12),
        CameraRotation = 40,

        RadioOrigin = Vector(-9842.997070, 6946.765625, -2711.539795    ),
        RadioDefaultVolume = .2,
        RadioURL = "http://bbcmedia.ic.llnwd.net/stream/bbcmedia_radio1_mf_p",

        UpgradeSoundURL = "https://content.pixelnetwork.co/sounds/kart_upgrade.mp3",
        UpgradeSoundVolume = .6,

        SprayPaintURL = "http://content.pixelnetwork.co/sounds/spray_paint.mp3",
        SprayPaintVolume = .8,
        SprayPaintCircleRadius = 50,
        SprayPaintOffset = Vector(0, 0, 25),

        WheelBoneNames = {
            Left = {
                ["wishbone_fl_wheel"] = true,
                ["wishbone_RL_Wheel"] = true
            },
            Right = {
                ["wishbone_FR_Wheel"] = true,
                ["wishbone_RR_Wheel"] = true
            }
        }
    }
}