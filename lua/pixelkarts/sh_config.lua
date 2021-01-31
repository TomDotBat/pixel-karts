
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
            Type = "Color",
            Price = {
                50000,
                30000,
                25000
            }
        },
        RainbowMode = {
            Type = "boolean",
            Price = {
                750000,
                750000,
                500000
            },
            RequiredLevel = 2
        },
        UnderGlow = {
            Type = "Color",
            Price = {
                75000,
                75000,
                75000
            },
            RequiredLevel = 3
        },
        RocketBoost = {
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
            Model = "models/hunter/blocks/cube025x3x025.mdl",
            Position = Vector(-1127.351196, -835.957336, -204.360306),
            Angles = Angle(-44.972534, -179.994507, 0.000000)
        },

        EntryBoxPoint1 = Vector(-1034.979858, -752.671753, -55.503555),
        EntryBoxPoint2 = Vector(-1118.906616, -882.049927, -199.116608),

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