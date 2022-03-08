--[[
    PIXEL Karts
    Copyright (C) 2022 Thomas (Tom.bat) O'Sullivan 

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program. If not, see <https://www.gnu.org/licenses/>.
]]

local lang = gmodI18n.registerLanguage("pixelkarts", "de", "Legandoor", 1.0)

--System Name
lang:addPhrase("systemName", "PIXEL Karts")

--Common Words
lang:addPhrase("yes", "Ja")
lang:addPhrase("no", "Nein")
lang:addPhrase("edit", "Ändern")

--Item Names
lang:addPhrase("pixelKart", "PIXEL Kart")
lang:addPhrase("repairWrench", "Kart Schraubenschlüssel")

--Upgrade Names
lang:addPhrase("upgradeCustomColor", "Primärfarbe")
lang:addPhrase("upgradeRainbowMode", "Regenbogen Primärfarbe")
lang:addPhrase("upgradeUnderGlow", "Unterbodenbeleuchtung")
lang:addPhrase("upgradeRocketBoost", "Raketenantrieb")
lang:addPhrase("upgradeGlider", "Gleiter")
lang:addPhrase("upgradeBuiltInRadio", "Eingebautes Radio")
lang:addPhrase("upgradePassengerSeat", "Beifahrersitz")
lang:addPhrase("upgradeLogo", "Eigenes Logo")

--Purchase Menu
lang:addPhrase("purchaseTitle", "Kart kaufen")
lang:addPhrase("purchaseDescription", "Würdest du gerne ein Kart für #amount kaufen?", {price = "a lot of money"})

--Respawn Menu
lang:addPhrase("respawnTitle", "Kart respawnen")
lang:addPhrase("respawnDescription", "Würdest du gerne dein Kart für #price respawnen?", {price = "a lot of money"})
lang:addPhrase("respawnDescriptionFree", "Würdest du gerne dein Kart respawnen?")

--Upgrades List
lang:addPhrase("availableUpgradesTitle", "Verfügbare Upgrades")
lang:addPhrase("rankOnly", "Nur für #rankName", {rankName = "tom.bat"})

--Upgrade Editors
lang:addPhrase("editorTitle", "#upgradeName Editor", {upgradeName = "thingy"})
lang:addPhrase("hexColour", "Hex Farbe:")

lang:addPhrase("enableGlider", "Gleiter aktivieren")
lang:addPhrase("gliderDescription", [[Der Gleiter lässt dein Kart fliegen, schalte ihn mit #keyName an oder aus.
Benutze deinen Raketenantrieb um vom Boden abzuheben.]], {keyName = "s&box"})

lang:addPhrase("imgurId", "Imgur ID:")
lang:addPhrase("enableLogo", "Aktiviere eigenes Logo")

lang:addPhrase("enablePassengerSeat", "Aktiviere Beifahrersitz")
lang:addPhrase("passengerSeatDescription", [[Der Beifahrersitz lässt einen anderen Spieler mit Sicherheit mitfahren.]])

lang:addPhrase("enableBuiltInRadio", "Aktiviere Radio")
lang:addPhrase("builtInRadioDescription", [[Das Radio lässt dich von überall aus Musik hören.]])

lang:addPhrase("enableRocketBooster", "Aktiviere Raketenantrieb")
lang:addPhrase("rocketBoosterDescription", [[Der Raketenantrieb gibt deinem Kart einen kurzen Geschwinidkeitsboost.
Während du fährst drücke #keyName um ihn zu aktivieren.]], {keyName = "s&box"})

lang:addPhrase("enableUnderGlow", "Aktiviere Unterbodenbeleuchtung")

--Garage Actions/Receipt
lang:addPhrase("actionsTitle", "Aktionen")
lang:addPhrase("receiptTotal", "Insgesamt:")
lang:addPhrase("leaveGarage", "Garage verlassen")
lang:addPhrase("purchase", "Kaufen")
lang:addPhrase("storeKart", "Kart einparken")

--Abilities HUD
lang:addPhrase("rocketBoostCooldown", "Raketenantrieb (#keyName)", {keyName = "s&box"})
lang:addPhrase("gliderCooldown", "Gleiter ausfahren (#keyName)", {keyName = "s&box"})

--Steering Wheel Screen
lang:addPhrase("startingUp", "PIXELOS startet")

lang:addPhrase("dashboard", "Dashboard")

lang:addPhrase("radio", "Radio")
lang:addPhrase("radioTurnOn", "Anschalten")
lang:addPhrase("radioTurnOff", "Ausschalten")
lang:addPhrase("radioNowStreaming", "Läuft jetzt:")

lang:addPhrase("speedometer", "Tacho")
lang:addPhrase("speedometerUnits", "KMH")

lang:addPhrase("passengerSeat", "Beifahrersitz")

--Radio Settings Menu
lang:addPhrase("radioSettings", "Radio Einstellungen")
lang:addPhrase("radioVolume", "Lautstärke")
lang:addPhrase("radioDisable3dVolume", "3D Audio ausschalten")

--Payment Notifications
lang:addPhrase("purchasedKartForPrice", "Kart für #price gekauft.", {price = "big money"})
lang:addPhrase("respawnedKartForPrice", "Kart für #price respawned.", {price = "big money"})

--Warning Notifications
lang:addPhrase("noMoreThanOneKart", "Du kannst nur ein Kart gleichzeitig draußen haben.")
lang:addPhrase("errorGettingKartData", "Es gab einen Fehler beim laden deiner Daten. Bitte melde dies.")
lang:addPhrase("cantEnterWithOtherKart", "Du kannst nicht mit fremden Autos in die Garage fahren.")
lang:addPhrase("alreadyHaveKartOut", "Du hast bereits ein Kart draußen.")

lang:addPhrase("cantAffordKart", "Du kannst dir kein Kart leisten.")
lang:addPhrase("cantAffordUpgrades", "Du kannst dir diese Upgrades nicht leisten.")
lang:addPhrase("cantAffordRespawn", "Du kannst es dir nicht leisten dein Kart zu respawnen.")

lang:addPhrase("kartUnderWater", "Dein Kart ist unter Wasser.")
lang:addPhrase("noHealthAbilitiesDisabled", "Dein Auto ist kaputt. Es ist aus solange du es nicht reparierst.")
lang:addPhrase("yourAbilityIsOnCooldown", "Dein #abilityName ist auf Cooldown.", {abilityName = "thingymabob"})
lang:addPhrase("dontHaveRankToUseAbility", "Du hast nicht den richtigen Rank um #abilityName zu nutzen.", {abilityName = "thingymabob"})
lang:addPhrase("cantUseAbilityInOthersKart", "Du kannst keine Fähigkeiten in Karts von anderen nutzen.")

--Convar Hints
lang:addPhrase("fastModelUpdateDescription", "Sollen die Kart Modelle öfer geupdatet werden? This may be intensive.")
lang:addPhrase("underglowEnableDescription", "Soll die Kart Unterbodenbeleuchtung immer sichtbar sein? This may be intensive.")
lang:addPhrase("decorationBuilderDescription", "Soll der PIXEL Kart Dekorationsmodus aktiv sein?")