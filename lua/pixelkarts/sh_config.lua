
PIXEL.Karts.Config = {
    AbilitiesInOtherKarts = false,

    KartPrice = {
        1500000, --Non VIP
        1000000, --VIP
        800000 --VIP Plus
    },

    RespawnPrice = { --False means free
        10000,
        5000,
        false
    },

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
                750000,
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
                75000,
                75000,
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
                200000,
                150000,
                125000
            },
            BoostKeyName = "Shift",
            BoostKey = IN_SPEED,
            BoostPower = 50000,
            BoostTime = .5,
            BoostInterval = 0.025,
            BoostCooldown = 15,
            BoostSoundVolume = 1.2,
            BoostSoundURL = "http://content.pixelnetwork.co/sounds/kart_boost.mp3"
        },
        Glider = {
            Name = "Glider",
            UIElement = "PIXEL.Karts.GliderEditor",
            DataKey = "glider_enabled",
            Type = "boolean",
            Price = {
                600000,
                500000,
                400000
            },
            RequiredLevel = 2,
            UpwardsThrust = 28000,
            ForwardThrust = 2000,
            ThrustInterval = 0.03,
            GroundCheckInterval = 2.5,
            GroundCheckMinDist = 25 ^ 2,
            MaxGlideTime = 10,
            LinearDamping = 0,
            AngularDamping = 20,
            AirControlSpeed = 40,
            DeployKeyName = "Reload",
            DeployKey = IN_RELOAD,
            DeployCooldown = 30,
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
        }
    },

    Garage = {
        DoorPos = Vector(-1034.875000, -818.687500, -125.937500),
        DoorAngle = Angle(90, 0, 180.000000),

        DoorFloorPos = Vector(-1037, -754, -195.9),
        DoorFloorAngle = Angle(0, -90, 0),
        DoorFloorWidth = 1280,
        DoorFloorHeight = 820,

        Ramp = {
            Model = "models/hunter/blocks/cube05x3x025.mdl",
            Position = Vector(-1127.312500, -817.656250, -206.187500),
            Angles = Angle(24.307251, 179.994507, 0.000000)
        },

        EntryBoxPoint1 = Vector(-1034.979858, -752.671753, -55.503555),
        EntryBoxPoint2 = Vector(-1118.906616, -882.049927, -199.116608),

        EntryRangeCheckPoint = Vector(-1079.401855, -816.696777, -175),
        EntryRangeCheckRadius = 120,

        InsidePositions = {
            Vector(-559.405640, -392.599762, -131.968750),
            Vector(-561.369019, -476.028015, -131.968750),
            Vector(-647.546204, -474.341248, -131.968750),
            Vector(-645.872437, -404.475159, -131.968750),
            Vector(-724.828369, -402.617157, -131.968750),
            Vector(-726.978516, -493.339874, -131.968750),
            Vector(-801.156677, -491.838531, -131.968750),
            Vector(-799.128784, -405.669983, -131.968750),
            Vector(-894.895325, -403.416412, -131.968750),
            Vector(-896.697388, -479.987671, -131.968750),
            Vector(-985.265869, -477.903473, -131.968750),
            Vector(-983.354797, -404.475159, -131.968750)
        },

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
    if true then return true end

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