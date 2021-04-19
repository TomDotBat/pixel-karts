
--[[
    Upgrades configuration for PIXEL Karts.

    Ignore everything until the next comment.
]]

local UPGRADES = PIXEL.Karts.Config.Upgrades

if not UPGRADES then
    UPGRADES = {}
    PIXEL.Karts.Config.Upgrades = UPGRADES
end

--[[
    Configuration starts below. Here's a brief explanation
    on some of the common keys in upgrades:
    {
        Name = "Body Colour", --The display name of the upgrade.
        UIElement = "PIXEL.Karts.ColorEditor", --The UI element to show when editing the upgrade, usually you should ignore this.
        DataKey = "custom_color", --The key name used in upgrade data, leave unchanged unless you have a need, eg: resetting everyone's custom colours.
        DataKeyEnabled = "custom_color_enabled", --The key used to store toggle state, same as above applies.
        Type = "Color", --The type of data required to be stored about the upgrade, this should never be changed.
        Price = { --A list of prices in rank level order for this upgrade.
            80000, --Level 1
            60000, --Level 2
            45000 --Level 3
        },
        RequiredLevel = 2 --The rank level required to buy/use this upgrade.
    }

    Note: All values related to ability/upgrade specifics have been tweaked and playtested already,
    This means it's unlikely that you will change anything other than pricing.

    Warning: NEVER change the upgrade key name (the thing inside of the square brackets in UPGRADES[***]).
]]

UPGRADES["CustomColor"] = { --Custom colour upgrade configuration
    Name = "Body Colour",
    UIElement = "PIXEL.Karts.ColorEditor",
    DataKey = "custom_color",
    Type = "Color",
    Price = {
        80000,
        60000,
        45000
    }
}

UPGRADES["RainbowMode"] = { --Rainbow mode upgrade configuration
    Type = "boolean",
    DataKey = "rainbow_enabled",
    Price = {
        0,
        800000,
        600000
    },
    RequiredLevel = 2
}

UPGRADES["UnderGlow"] = { --Underglow upgrade configuration
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
}

UPGRADES["RocketBoost"] = { --Rocket boost upgrade configuration
    Name = "Rocket Boost",
    UIElement = "PIXEL.Karts.RocketBoostEditor",
    DataKey = "rocket_boost_enabled",
    Type = "boolean",
    Price = {
        800000,
        250000,
        100000
    },
    BoostKeyName = "Sprint", --The name of the key to press to activate the ability.
    BoostKey = IN_SPEED, --The IN enumeration (https://wiki.facepunch.com/gmod/Enums/IN) for the key that activates the ability.
    BoostPower = 50000, --The amount of force in Newtons to apply to the kart per boost interval.
    BoostTime = .5, --The amount of time the kart boost ability should occur for.
    BoostInterval = 0.025, --How often the boost force is applied during the boost time.
    BoostCooldown = 5, --How long the user must wait between boosts.
    BoostSoundVolume = 1.2, --The volume of the boost sound effect.
    BoostSoundURL = "http://content.pixelnetwork.co/sounds/kart_boost.mp3" --The URL of the boost sound effect.
}

UPGRADES["Glider"] = { --Glider upgrade configuration
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
    UpwardsThrust = 32000, --How much upward thrust should be applied to the kart per interval.
    ForwardThrust = 4000, --Same as the above but forward.
    ThrustInterval = 0.03, --How often the thrust should be applied to the kart while gliding
    GroundCheckInterval = 2.5, --How often the glider should check if the kart is grounded and automatically retract.
    GroundCheckMinDist = 25 ^ 2, --The minimum distance from the ground before the glider should be retracted.
    MaxGlideTime = 5, --The maximum amount of time the player can glide for.
    LinearDamping = 0, --Directional damping applied to the kart whilst gliding.
    AngularDamping = 20, --Same as above but for angular force.
    AirControlSpeed = 120, --The sensitivity of rotation controls of the kart whilst gliding.
    DeployKeyName = "Reload", --The name of the key used to activate the ability.
    DeployKey = IN_RELOAD, --The IN enumeration (https://wiki.facepunch.com/gmod/Enums/IN) for the key that activates the ability.
    DeployCooldown = 10 --How long the user must wait between gliding.
}

UPGRADES["BuiltInRadio"] = { --Built-in radio upgrade configuration
    Name = "Built-In Radio",
    UIElement = "PIXEL.Karts.RadioEditor",
    DataKey = "radio_enabled",
    Type = "boolean",
    Price = {
        80000,
        60000,
        25000
    }
}

UPGRADES["PassengerSeat"] = { --Passenger seat upgrade configuration
    Name = "Passenger Seat",
    UIElement = "PIXEL.Karts.PassengerSeatEditor",
    DataKey = "passenger_seat_enabled",
    Type = "boolean",
    Price = {
        500000,
        350000,
        200000
    },
    SeatPos = Vector(0, -37, 18), --The position of the passenger seat relative to the kart.
    SeatAngle = Angle(0, 0, 0) --The rotation of the passenger seat relative to the kart.
}

UPGRADES["Logo"] = { --Custom logo upgrade configuration
    Name = "Logo",
    UIElement = "PIXEL.Karts.LogoEditor",
    DataKey = "logo_imgur_id",
    DataKeyEnabled = "logo_enabled",
    Validator = function(str) --I highly recommend you just ignore this.
        return string.find(str, "[0-9A-z][0-9A-z][0-9A-z][0-9A-z][0-9A-z][0-9A-z][0-9A-z]")
    end,
    Type = "string",
    Price = {
        0,
        0,
        200000
    },
    RequiredLevel = 3,
    DefaultLogoId = "YCRtBVO" --The default logo Imgur ID (https://imgur.com) to apply to newly bought karts.
}

--Ignore anything below this.
UPGRADES = nil