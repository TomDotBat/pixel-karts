
function PIXEL.Karts.SetupNWVars(kart)
    if kart.IsClientside then
        kart.KartVars = {}
        for upgradeName, upgrade in pairs(PIXEL.Karts.Config.Upgrades) do
            if upgrade.Type == "boolean" then
                kart.KartVars[upgradeName] = false
            elseif upgrade.Type == "Color" then
                kart.KartVars[upgradeName] = Color(255, 255, 255)
            elseif upgrade.Type == "number" then
                kart.KartVars[upgradeName] = -1
            end

            kart["Get" .. upgradeName] = function(s)
                return kart.KartVars[upgradeName]
            end

            kart["Set" .. upgradeName] = function(s, new)
                kart.KartVars[upgradeName] = new
            end

            if upgrade.Type == "boolean" then continue end
            kart["Get" .. upgradeName .. "Enabled"] = function(s)
                return kart.KartVars["PIXEL.Karts." .. upgradeName .. ".Enabled"]
            end

            kart["Set" .. upgradeName .. "Enabled"] = function(s)
                return kart.KartVars["PIXEL.Karts." .. upgradeName .. ".Enabled"]
            end
        end
        return
    end

    for upgradeName, upgrade in pairs(PIXEL.Karts.Config.Upgrades) do
        if upgrade.Type == "boolean" then
            kart["Get" .. upgradeName] = function(s)
                return kart:GetNWBool("PIXEL.Karts." .. upgradeName, false)
            end

            if CLIENT then continue end
            kart["Set" .. upgradeName] = function(s, state)
                kart:SetNWBool("PIXEL.Karts." .. upgradeName, state)
            end
        elseif upgrade.Type == "Color" then
            kart["Get" .. upgradeName .. "Enabled"] = function(s)
                return kart:GetNWBool("PIXEL.Karts." .. upgradeName .. ".Enabled", false)
            end

            kart["Get" .. upgradeName] = function(s)
                return Color(
                    kart:GetNWInt("PIXEL.Karts." .. upgradeName .. ".R", 255),
                    kart:GetNWInt("PIXEL.Karts." .. upgradeName .. ".G", 255),
                    kart:GetNWInt("PIXEL.Karts." .. upgradeName .. ".B", 255),
                    kart:GetNWInt("PIXEL.Karts." .. upgradeName .. ".A", 255)
                )
            end

            if CLIENT then continue end
            kart["Set" .. upgradeName .. "Enabled"] = function(s, state)
                kart:SetNWBool("PIXEL.Karts." .. upgradeName .. ".Enabled", state)
            end

            kart["Set" .. upgradeName] = function(s, col)
                kart:SetNWInt("PIXEL.Karts." .. upgradeName .. ".R", col.r)
                kart:SetNWInt("PIXEL.Karts." .. upgradeName .. ".G", col.g)
                kart:SetNWInt("PIXEL.Karts." .. upgradeName .. ".B", col.b)
                kart:SetNWInt("PIXEL.Karts." .. upgradeName .. ".A", col.a)
            end
        elseif upgrade.Type == "number" then
            kart["Get" .. upgradeName .. "Enabled"] = function(s)
                return kart:GetNWFloat("PIXEL.Karts." .. upgradeName, 0) == -1
            end

            kart["Get" .. upgradeName] = function(s)
                return kart:GetNWFloat("PIXEL.Karts." .. upgradeName, 0)
            end

            if CLIENT then continue end
            kart["Set" .. upgradeName .. "Enabled"] = function(s)
                return kart:SetNWFloat("PIXEL.Karts." .. upgradeName, -1)
            end

            kart["Set" .. upgradeName] = function(s, num)
                return kart:SetNWFloat("PIXEL.Karts." .. upgradeName, num)
            end
        end
    end
end