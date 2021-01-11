
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
        Nitro = {
            Type = "boolean",
            Price = {
                200000,
                150000,
                125000
            },
            BoostPower = 100
        },
        Glider = {
            Type = "boolean",
            Price = {
                600000,
                500000,
                400000
            },
            RequiredLevel = 2
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