
PIXEL.Karts.Config = {
    NoCollideKartsWithPlayers = true,
    AbilitiesInOtherKarts = false,

    KartPrice = {
        5000000, --Non VIP
        2000000, --VIP
        1000000 --VIP Plus
    },

    RespawnPrice = { --False means free
        10000,
        5000,
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

    Upgrades = {
        CustomColor = {
            Name = "Body Colour",
            UIElement = "PIXEL.Karts.ColorEditor",
            DataKey = "custom_color",
            Type = "Color",
            Price = {
                50000,
                30000,
                25000
            }
        },
        RainbowMode = {
            Type = "boolean",
            DataKey = "rainbow_enabled",
            Price = {
                0,
                750000,
                500000
            },
            RequiredLevel = 2
        },
        UnderGlow = {
            Name = "Underglow",
            UIElement = "PIXEL.Karts.UnderglowEditor",
            DataKey = "underglow_color",
            DataKeyEnabled = "underglow_enabled",
            Type = "Color",
            Price = {
                0,
                0,
                75000
            },
            RequiredLevel = 3
        },
        RocketBoost = {
            Name = "Rocket Boost",
            UIElement = "PIXEL.Karts.RocketBoostEditor",
            DataKey = "rocket_boost_enabled",
            Type = "boolean",
            Price = {
                500000,
                250000,
                100000
            },
            BoostKeyName = "Sprint",
            BoostKey = IN_SPEED,
            BoostPower = 50000,
            BoostTime = .5,
            BoostInterval = 0.025,
            BoostCooldown = 5,
            BoostSoundVolume = 1.2,
            BoostSoundURL = "http://content.pixelnetwork.co/sounds/kart_boost.mp3"
        },
        Glider = {
            Name = "Glider",
            UIElement = "PIXEL.Karts.GliderEditor",
            DataKey = "glider_enabled",
            Type = "boolean",
            Price = {
                0,
                500000,
                400000
            },
            RequiredLevel = 2,
            UpwardsThrust = 32000,
            ForwardThrust = 4000,
            ThrustInterval = 0.03,
            GroundCheckInterval = 2.5,
            GroundCheckMinDist = 25 ^ 2,
            MaxGlideTime = 5,
            LinearDamping = 0,
            AngularDamping = 20,
            AirControlSpeed = 120,
            DeployKeyName = "Reload",
            DeployKey = IN_RELOAD,
            DeployCooldown = 10,
            --DeploySoundVolume = 1.2,
            --DeploySoundURL = "http://content.pixelnetwork.co/sounds/kart_boost.mp3"
        },
        BuiltInRadio = {
            Name = "Built-In Radio",
            UIElement = "PIXEL.Karts.RadioEditor",
            DataKey = "radio_enabled",
            Type = "boolean",
            Price = {
                20000,
                20000,
                15000
            }
        },
        PassengerSeat = {
            Name = "Passenger Seat",
            UIElement = "PIXEL.Karts.PassengerSeatEditor",
            DataKey = "passenger_seat_enabled",
            Type = "boolean",
            Price = {
                100000,
                50000,
                35000
            },
            SeatPos = Vector(0, -37, 18),
            SeatAngle = Angle(0, 0, 0)
        },
        Logo = {
            Name = "Logo",
            UIElement = "PIXEL.Karts.LogoEditor",
            DataKey = "logo_imgur_id",
            DataKeyEnabled = "logo_enabled",
            Validator = function(str)
                return string.find(str, "[0-9A-z][0-9A-z][0-9A-z][0-9A-z][0-9A-z][0-9A-z][0-9A-z]")
            end,
            Type = "string",
            Price = {
                0,
                0,
                100000
            },
            RequiredLevel = 3,
            DefaultLogoId = "YCRtBVO"
        }
    },

    Garage = {
        DoorPos = Vector(-1034.875000, -818.687500, -125.937500),
        DoorAngle = Angle(90, 0, 180.000000),

        DoorFloorPos = Vector(-1037, -754, -195.9),
        DoorFloorAngle = Angle(0, -90, 0),
        DoorFloorWidth = 1280,
        DoorFloorHeight = 820,

        SpawnPos = Vector(-1175.125000, -815.625000, -160),
        SpawnAngle = Angle(0, 90, 0),

        Ramp = {
            Model = "models/hunter/blocks/cube05x3x025.mdl",
            Position = Vector(-1127.312500, -817.656250, -206.187500),
            Angles = Angle(24.307251, 179.994507, 0.000000)
        },

        EntryBoxPoint1 = Vector(-1034.979858, -752.671753, -55.503555),
        EntryBoxPoint2 = Vector(-1118.906616, -882.049927, -199.116608),

        EntryRangeCheckPoint = Vector(-1079.401855, -816.696777, -175),
        EntryRangeCheckRadius = 120,

        InsidePosition = Vector(-559.405640, -392.599762, -131.968750),

        LeavePosition = Vector(-1078.805908, -597.136536, -195),
        LeaveAngles = Angle(0, 0, 0),

        KartPos = Vector(-881.531250, -790.531250, -191.343750),
        KartAngles = Angle(0, -90, 0),

        KartHoloColor = Color(120, 200, 120, 255),

        CameraCircleRadius = 115,
        CameraOffset = Vector(0, 0, 55),
        CameraAimOffset = Vector(2, 0, 12),
        CameraRotation = 40,

        RadioOrigin = Vector(-814.031250, -882.968750, -151.687500),
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

local meta = FindMetaTable("Player")

function meta:PIXELKartsIsLevel(level)
    if not level then return true end
    if level == 0 or level == 1 then return true end

    if level == 2 then
        return self:IsUserGroup("vip") or self:IsUserGroup("vip+")
    else
        return self:IsUserGroup("vip+")
    end
end

function meta:PIXELKartsGetLevel()
    if self:IsUserGroup("vip+") then return 3 end
    if self:IsUserGroup("vip") then return 2 end
    return 1
end