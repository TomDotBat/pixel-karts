
PIXEL.Karts.Config = {
    AbilitiesInOtherKarts = false,

    KartPrice = {
        1500000, --Non VIP
        1000000, --VIP
        800000 --VIP Plus
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

        KartPos = Vector(-881.531250, -771.531250, -191.343750),
        KartAngles = Angle(0, -90, 0),

        CameraCircleRadius = 130,
        CameraOffset = Vector(0, 0, 55),
        CameraRotation = 50,

        RadioOrigin = Vector(-814.031250, -882.968750, -151.687500),
        RadioVolume = .5,
        RadioURL = "http://bbcmedia.ic.llnwd.net/stream/bbcmedia_radio1_mf_p",

        SprayPaintURL = "http://content.pixelnetwork.co/sounds/spray_paint.mp3",
        SprayPaintVolume = .8,
        SprayPaintCircleRadius = 50,
        SprayPaintOffset = Vector(0, 0, 25),

        BoneManipulations = {
            [0] = {
                position = Vector(-0.000019, 0.000022, 19.999994),
                angles = Angle(-89.862930, 90.028404, 89.834198)
            },
            [1] = {
                position = Vector(-0.056485, -23.658377, 1.861150),
                angles = Angle(-11.862750, 89.863022, -0.000618)
            },
            [2] = {
                position = Vector(-9.327681, -32.908897, 12.126321),
                angles = Angle(11.469055, 179.890793, 0.140078)
            },
            [3] = {
                position = Vector(-9.347727, -32.927410, 4.350112),
                angles = Angle(11.469055, 179.890793, 0.140078)
            },
            [4] = {
                position = Vector(-13.494369, -29.885984, 2.436397),
                angles = Angle(-81.340302, 0.763997, -0.911614)
            },
            [5] = {
                position = Vector(-18.424740, -32.910118, 2.508467),
                angles = Angle(-89.848953, 89.808571, -89.794525)
            },
            [6] = {
                position = Vector(-24.787735, -32.885208, 6.396510),
                angles = Angle(0.000665, 179.860245, 1.562722)
            },
            [7] = {
                position = Vector(-10.578475, -29.847300, 21.515789),
                angles = Angle(81.339767, -179.237976, 0.910162)
            },
            [8] = {
                position = Vector(10.435660, -29.897591, 21.515930),
                angles = Angle(81.299995, -1.034482, -0.907844)
            },
            [9] = {
                position = Vector(9.170321, -32.953110, 12.126464),
                angles = Angle(11.155812, -0.164059, -0.139555)
            },
            [10] = {
                position = Vector(9.190079, -32.971809, 4.350247),
                angles = Angle(11.155812, -0.164059, -0.139555)
            },
            [11] = {
                position = Vector(18.277302, -32.997837, 2.558198),
                angles = Angle(-89.863083, 89.898453, -90.033875)
            },
            [12] = {
                position = Vector(24.639900, -33.004547, 6.446303),
                angles = Angle(0.000055, -0.137073, 178.072083)
            },
            [13] = {
                position = Vector(13.361827, -29.950178, 2.459234),
                angles = Angle(-81.300354, 178.968262, -179.094925)
            },
            [14] = {
                position = Vector(-9.298768, 31.018429, 9.459054),
                angles = Angle(6.660122, 179.878952, 0.137994)
            },
            [15] = {
                position = Vector(-9.298789, 30.999733, 1.682886),
                angles = Angle(6.660122, 179.878952, 0.137994)
            },
            [16] = {
                position = Vector(-18.520605, 31.019226, 0.606073),
                angles = Angle(-89.862930, 90.028313, 89.834282)
            },
            [17] = {
                position = Vector(-18.520594, 31.034060, 6.803049),
                angles = Angle(-89.862930, 90.028313, 89.834282)
            },
            [18] = {
                position = Vector(-18.680037, 27.301075, 6.185998),
                angles = Angle(-89.862930, 90.028313, -93.665520)
            },
            [19] = {
                position = Vector(-18.128361, 27.361168, 5.599840),
                angles = Angle(0.007696, 3.238997, -0.136847)
            },
            [20] = {
                position = Vector(-28.480194, 31.052477, 4.551255),
                angles = Angle(0.000523, 179.862961, -178.281281)
            },
            [21] = {
                position = Vector(-13.624292, 31.006321, 0.107511),
                angles = Angle(-75.865356, 0.407286, 89.439125)
            },
            [22] = {
                position = Vector(-8.990769, 31.039255, 18.486183),
                angles = Angle(-75.865494, 0.407241, 89.438499)
            },
            [23] = {
                position = Vector(9.138951, 30.995901, 18.486319),
                angles = Angle(-75.853462, 179.319138, 90.561043)
            },
            [24] = {
                position = Vector(9.447361, 30.954849, 1.683014),
                angles = Angle(6.581151, -0.152894, -0.138118)
            },
            [25] = {
                position = Vector(18.670427, 30.930265, 0.618935),
                angles = Angle(-89.862907, 90.025543, -90.162941)
            },
            [26] = {
                position = Vector(18.670439, 30.945103, 6.815469),
                angles = Angle(-89.862907, 90.025543, -90.162941)
            },
            [27] = {
                position = Vector(28.630079, 30.915886, 4.564244),
                angles = Angle(-0.000095, -0.137074, 178.071899)
            },
            [28] = {
                position = Vector(18.758678, 27.209787, 6.198878),
                angles = Angle(-89.862907, 90.025543, -95.162956)
            },
            [29] = {
                position = Vector(18.205732, 27.258106, 5.612742),
                angles = Angle(0.008497, 176.462997, -179.862595)
            },
            [30] = {
                position = Vector(13.774844, 30.940763, 0.113956),
                angles = Angle(-75.853165, 179.318771, 90.560829)
            },
            [31] = {
                position = Vector(9.447381, 30.973547, 9.459182),
                angles = Angle(6.581151, -0.152894, -0.138118)
            },
            [32] = {
                position = Vector(0.040049, 16.757381, 25.996309),
                angles = Angle(-30.136927, -90.137283, 5.000178)
            },
            [33] = {
                position = Vector(3.429005, 16.020456, 24.740993),
                angles = Angle(-30.136927, -90.137283, -24.999907)
            },
            [34] = {
                position = Vector(-3.352548, 16.036654, 24.740938),
                angles = Angle(-30.136927, -90.137283, 5.000178)
            },
            [35] = {
                position = Vector(0.021387, 8.952946, 25.574659),
                angles = Angle(-30.136927, -90.137283, -89.999542)
            },
            [36] = {
                position = Vector(-12.460684, -29.872208, 9.210026),
                angles = Angle(-81.340302, 0.763997, 179.088242)
            },
            [37] = {
                position = Vector(-11.135096, -29.854710, 17.847338),
                angles = Angle(-81.339745, 0.762998, 179.089600)
            },
            [38] = {
                position = Vector(10.994870, -29.907709, 17.847874),
                angles = Angle(-81.300003, 178.966492, 0.906894)
            },
            [39] = {
                position = Vector(12.323604, -29.931541, 9.232181),
                angles = Angle(-81.300354, 178.968262, 0.905233)
            },
            [40] = {
                position = Vector(-11.958438, 31.017084, 6.746147),
                angles = Angle(-75.865356, 0.407286, 179.438782)
            },
            [41] = {
                position = Vector(-9.903982, 31.031725, 14.881737),
                angles = Angle(-75.865494, 0.407241, 179.438705)
            },
            [42] = {
                position = Vector(10.053091, 30.985064, 14.878459),
                angles = Angle(-75.853462, 179.319138, 0.560822)
            },
            [43] = {
                position = Vector(12.107657, 30.960625, 6.748272),
                angles = Angle(-75.853165, 179.318771, 0.560609)
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