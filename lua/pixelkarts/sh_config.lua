
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

    Upgrades = {
        CustomColor = {
            Name = "Body Colour",
            UIElement = "PIXEL.Karts.ColorEditor",
            DataKey = "custom_color",
            Type = "Color",
            Price = {
                80000,
                60000,
                45000
            }
        },
        RainbowMode = {
            Type = "boolean",
            DataKey = "rainbow_enabled",
            Price = {
                0,
                800000,
                600000
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
                240000
            },
            RequiredLevel = 3
        },
        RocketBoost = {
            Name = "Rocket Boost",
            UIElement = "PIXEL.Karts.RocketBoostEditor",
            DataKey = "rocket_boost_enabled",
            Type = "boolean",
            Price = {
                800000,
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
                1200000,
                800000
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
                80000,
                60000,
                25000
            }
        },
        PassengerSeat = {
            Name = "Passenger Seat",
            UIElement = "PIXEL.Karts.PassengerSeatEditor",
            DataKey = "passenger_seat_enabled",
            Type = "boolean",
            Price = {
                500000,
                350000,
                200000
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
                200000
            },
            RequiredLevel = 3,
            DefaultLogoId = "YCRtBVO"
        }
    },

    Garage = {
        DoorPos = Vector(-9966, 7062.9, -2670),
        DoorAngle = Angle(90, 0, 180),
        DoorCollisions = false,

        DoorFloorPos = Vector(-9970, 7134, -2763.6),
        DoorFloorAngle = Angle(0, -90, 5),
        DoorFloorWidth = 1440,
        DoorFloorHeight = 880,

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