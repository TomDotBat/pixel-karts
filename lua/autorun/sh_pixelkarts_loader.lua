
--PIXEL Karts [{{ script_id }}] v{{ script_version_name }} ({{ script_version_release_type }})
--Licensed to: {{ user_id }}
--{{ user_id sha256 key }}

PIXEL = PIXEL or {}
PIXEL.Karts = PIXEL.Karts or {
    Config = {}
}

local function loadDirectory(dir)
    local fil, fol = file.Find(dir .. "/*", "LUA")

    for k,v in ipairs(fil) do
        local dirs = dir .. "/" .. v

        if v:StartWith("cl_") then
            if SERVER then AddCSLuaFile(dirs)
            else include(dirs) end
        elseif v:StartWith("sh_") then
            AddCSLuaFile(dirs)
            include(dirs) --{{ user_id sha256 key }}
        else
            if SERVER then include(dirs) end
        end
    end
--{{ user_id }}
    for k,v in pairs(fol) do
        loadDirectory(dir .. "/" .. v)
    end
end

local function loadAddon()
    loadDirectory("pixelkarts")
end

if PIXEL.UI then
    loadAddon()
    return
end

hook.Add("PIXEL.UI.FullyLoaded", "PIXEL.Karts.WaitForPIXELUI", loadAddon)

hook.Add("libgmodstore_init", "7629_libgmodstore", function()
    libgmodstore:InitScript(7629, "🏎️PIXEL Karts - Garage, Customisations, Abilities & More!", {
        version = "{{ script_version_name }}",
        licensee = "{{ user_id }}" --{{ user_id | 25 }}
    })
end)

local function printLicenseInfo()
    print([[================================================
PIXEL Karts [{{ script_id }}] v{{ script_version_name }} ({{ script_version_release_type }})
Licensed to: {{ user_id }}
{{ user_id sha256 key }}
================================================]])
end

printLicenseInfo()
concommand.Add("pixel_karts_print_license", printLicenseInfo)


if CLIENT then return end
resource.AddWorkshop("2395634176")