
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
            BoostCooldown = 5,
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
            DeployCooldown = 1,
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