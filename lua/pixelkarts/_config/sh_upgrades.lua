
PIXEL.Karts.Config.Upgrades = {
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
        Validator = function(str) --I highly recommend you just ignore this
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
}