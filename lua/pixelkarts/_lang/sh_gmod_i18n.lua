--[[-------------------------------------------------------------------------
gmod-i18n - Making multi-language support for your addons easier.
Created by Tom.bat (STEAM_0:0:127595314)
Repository: https://github.com/TomDotBat/gmod-i18n
Website: https://tomdotbat.dev
Email: tom@tomdotbat.dev
Discord: Tom.bat#0001
---------------------------------------------------------------------------]]

--[[-------------------------------------------------------------------------
Copyright 2021 Thomas O'Sullivan
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
   http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
---------------------------------------------------------------------------]]

local ver = 1.0
if gmodI18n and gmodI18n.version >= ver then return end --Load the latest copy of gmod-i18n available.

gmodI18n = {
    version = ver,
    _addons = gmodI18n and gmodI18n._addons or {} --Carry over language strings that may have been defined on an old version of gmod-i18n.
}

local phrase = {} --Define the phrase object, this manages placeholder replacements, fallback data and more.
phrase.__index = phrase

function phrase:getString(data)
    if not istable(data) then return self.string end

    local replacements = self.fallbackData and table.Copy(self.fallbackData) or {}
    table.Merge(replacements, data)

    local result = self.string
    for placeholder, replacement in pairs(data) do --Loop through the given data and replace the placeholders with the provided replacement string.
        result = string.Replace(result, "#" .. placeholder, replacement)
    end

    return result
end

function phrase.new(identifier, str, fallbackData) --Creates a phrase object. Fallback data is optional but may provide a better user experience in the event of missing data.
    local tbl = setmetatable({}, phrase)

    tbl.identifier = identifier
    tbl.string = tostring(str) or ""
    tbl.fallbackData = istable(fallbackData) and fallbackData or {}

    return tbl
end


local language = {} --Define the language object, this stores all phrases for a specific language in an addon.
language.__index = language

language._phrases = {}

function language:addPhrase(...) --Creates a new phrase, attaches it to this language and returns the created phrase object.
    local newPhrase = phrase.new(...)
    self._phrases[newPhrase.identifier] = newPhrase
    return newPhrase
end

function language:getString(identifier, ...) --Returns a string built by the specified phrase, errors are also returned as strings.
    if not self._phrases[identifier] then return end
    return self._phrases[identifier]:getString(...)
end

function language.new(identifier, author, version) --Creates a language object. Author and version are optional.
    local tbl = setmetatable({}, language)

    tbl.identifier = tostring(identifier)
    tbl.author = tostring(author) or "Unknown"
    tbl.version = tonumber(version) or 0

    return tbl
end


local addon = {} --Define the addon object, this stores all phrases for a specific addon.
addon.__index = addon

addon._languages = {}

function addon:addLanguage(...) --This creates a language object and attaches it to this addon.
    local lang = language.new(...)
    self._languages[lang.identifier] = lang
    return lang
end

function addon:getString(...) --Returns a string built by the specified phrase, errors are also returned as strings.
    local lang = gmodI18n.getLanguageCode()
    local fallbackLang = self.fallbackLang

    if not self._languages[lang] then
        lang = fallbackLang

        if not lang then return "ERROR CODE: 1" end --Error code 1: Language not found, no fallback language set for this addon.
        if not self._languages[lang] then return "ERROR CODE: 2" end --Error code 2: Language not found, fallback language not found.
    end

    local result = self._languages[lang]:getString(...)
    if result then return result end

    if lang == fallbackLang then return "ERROR CODE: 3" end --Error code 3: Phrase not found in both specified language and fallback language.
    if not self._languages[fallbackLang] then return "ERROR CODE: 4" end --Error code 4: Phrase not found in specified language, fallback language not found.

    result = self._languages[fallbackLang]:getString(...)
    return result and result or "ERROR CODE: 3"
end


function gmodI18n.registerAddon(identifier, fallbackLang, name, author, version) --Creates an addon object. A fallback language is preffered. Name, author and version are optional.
    if not identifier then return end

    local existingAddon = gmodI18n._addons[identifier]
    if existingAddon then --If we register phrases/languages before the addon is registered it won't have any data attached. This will update it after a "half-registration".
        existingAddon.identifier = identifier
        existingAddon.fallbackLang = tostring(fallbackLang)
        existingAddon.name = tostring(name) or "Unknown"
        existingAddon.author = tostring(author) or "Unknown"
        existingAddon.version = tonumber(version) or 0
        return existingAddon
    end

    local tbl = setmetatable({}, addon)

    tbl.identifier = identifier
    tbl.fallbackLang = tostring(fallbackLang)
    tbl.name = tostring(name) or "Unknown"
    tbl.author = tostring(author) or "Unknown"
    tbl.version = tonumber(version) or 0

    gmodI18n._addons[identifier] = tbl
    return tbl
end

function gmodI18n.registerLanguage(addonId, ...) --Creates a language for a specified addon, this creates a temporary addon if the specified one isn't created yet.
    local selectedAddon = gmodI18n._addons[addonId]
    if not selectedAddon then --"Half-register" an addon object so we can add our language. This will only happen if the language registration is called before the addon gets registered.
        selectedAddon = gmodI18n.registerAddon(addonId)
    end

    return selectedAddon:addLanguage(...)
end

function gmodI18n.getAddon(addonId) --Gets the addon object with the specified identifier.
    return gmodI18n._addons[addonId]
end

local langCVar = GetConVar("gmod_language")
local langOverrideCVar = CreateConVar("i18n_override_language", "", {FCVAR_ARCHIVE}, "The language gmod-i18n should use on the server.")

function gmodI18n.getLanguageCode() --Gets the game's language code.
    local override = langOverrideCVar:GetString()
    if override != "" then return override end
    return langCVar:GetString()
end

hook.Add("InitPostEntity", "gmodI18n.loadMessage", function() --Prints a nice message displaying information about the addons registered.
    print([[                          _        _ __  ___        
                         | |      (_)_ |/ _ \       
 __ _ _ __ ___   ___   __| |______ _ | | (_) |_ __  
/ _` | '_ ` _ \ / _ \ / _` |______| || |> _ <| '_ \ 
 (_| | | | | | | (_) | (_| |      | || | (_) | | | |
\__, |_| |_| |_|\___/ \__,_|      |_||_|\___/|_| |_|
 __/ |                                              
|___/                                               
Developed by Tom.bat
https://github.com/TomDotBat/gmod-i18n
    ]])

    for id, addn in pairs(gmodI18n._addons) do
        print("[gmod-i18n] Addon registered: " .. addn.name .. " (v" .. string.format("%f", addn.version) .. "), created by: " .. addn.author .. ".")

        if table.Count(addn._languages) == 0 then
            print("   No languages found for addon: " .. addn.name .. ".")
            continue
        end

        for langCode, lang in pairs(addn._languages) do
            print("   Language registered: " .. langCode .. " (v" .. string.format("%f", lang.version) .. "), created by: " .. lang.author .. ", " .. table.Count(lang._phrases) .. " phrases found.")
        end

        print("\n")
    end

    print("[gmod-i18n] Successfully loaded with " .. table.Count(gmodI18n._addons) .. " addons registered.")
end)

hook.Run("gmodI18n.fullyLoaded") --Register your addon then load all of your language files that define phrases when this hook is called.
                                 --Alternatively, you can load this file in your addon first, before doing the above.