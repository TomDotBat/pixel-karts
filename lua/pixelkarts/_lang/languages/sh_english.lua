
local lang = gmodI18n.registerLanguage("pixelkarts", "en", "Tom.bat", 1.0)

--System Name
lang:addPhrase("systemName", "PIXEL Karts")

--Common Words
lang:addPhrase("yes", "Yes")
lang:addPhrase("no", "No")
lang:addPhrase("edit", "Edit")

--Item Names
lang:addPhrase("pixelKart", "PIXEL Kart")
lang:addPhrase("repairWrench", "Kart Repair Wrench")

--Upgrade Names
lang:addPhrase("upgradeCustomColor", "Body Colour")
lang:addPhrase("upgradeRainbowMode", "Rainbow Body Colour")
lang:addPhrase("upgradeUnderGlow", "Underglow")
lang:addPhrase("upgradeRocketBoost", "Rocket Booster")
lang:addPhrase("upgradeGlider", "Glider")
lang:addPhrase("upgradeBuiltInRadio", "Built-In Radio")
lang:addPhrase("upgradePassengerSeat", "Passenger Seat")
lang:addPhrase("upgradeLogo", "Custom Logo")

--Purchase Menu
lang:addPhrase("purchaseTitle", "Purchase Kart")
lang:addPhrase("purchaseDescription", "Would you like to buy a Kart for #amount?", {price = "a lot of money"})

--Respawn Menu
lang:addPhrase("respawnTitle", "Respawn Kart")
lang:addPhrase("respawnDescription", "Would you like to respawn your Kart for #price?", {price = "a lot of money"})
lang:addPhrase("respawnDescriptionFree", "Would you like to respawn your Kart?")

--Upgrades List
lang:addPhrase("availableUpgradesTitle", "Available Upgrades")
lang:addPhrase("rankOnly", "#rankName Only", {rankName = "tom.bat"})

--Upgrade Editors
lang:addPhrase("editorTitle", "#upgradeName Editor", {upgradeName = "thingy"})
lang:addPhrase("hexColour", "Hex Colour:")

lang:addPhrase("enableGlider", "Enable Glider")
lang:addPhrase("gliderDescription", [[The glider enables your kart to fly, you can toggle it with your #keyName key. 
Use it with the rocket booster to get in the air from ground level.]], {keyName = "s&box"})

lang:addPhrase("imgurId", "Imgur ID:")
lang:addPhrase("enableLogo", "Enable Custom Logo")

lang:addPhrase("enablePassengerSeat", "Enable Passenger Seat")
lang:addPhrase("passengerSeatDescription", [[Buying a passenger seat allows another person to tag along for the ride with safety.]])

lang:addPhrase("enableBuiltInRadio", "Enable Built-In Radio")
lang:addPhrase("builtInRadioDescription", [[The built in radio allows you to listen to your favourite internet radio stations live.]])

lang:addPhrase("enableRocketBooster", "Enable Rocket Booster")
lang:addPhrase("rocketBoosterDescription", [[Rocket boosters allow you to give your kart a short burst of speed on demand.
While driving your kart, use the #keyName key to trigger it.]], {keyName = "s&box"})

lang:addPhrase("enableUnderGlow", "Enable Underglow")

--Garage Actions/Receipt
lang:addPhrase("actionsTitle", "Actions")
lang:addPhrase("receiptTotal", "Total:")
lang:addPhrase("leaveGarage", "Leave Garage")
lang:addPhrase("purchase", "Purchase")
lang:addPhrase("storeKart", "Store Kart")

--Abilities HUD
lang:addPhrase("rocketBoostCooldown", "Rocket Boost (#keyName)", {keyName = "s&box"})
lang:addPhrase("gliderCooldown", "Deploy Glider (#keyName)", {keyName = "s&box"})

--Steering Wheel Screen
lang:addPhrase("startingUp", "PIXELOS is starting")

lang:addPhrase("dashboard", "Dashboard")

lang:addPhrase("radio", "Radio")
lang:addPhrase("radioTurnOn", "Turn On")
lang:addPhrase("radioTurnOff", "Turn Off")
lang:addPhrase("radioNowStreaming", "Now Streaming:")

lang:addPhrase("speedometer", "Speedometer")
lang:addPhrase("speedometerUnits", "MPH")

lang:addPhrase("passengerSeat", "Passenger Seat")

--Radio Settings Menu
lang:addPhrase("radioSettings", "Radio Settings")
lang:addPhrase("radioVolume", "Volume")
lang:addPhrase("radioDisable3dVolume", "Disable 3D Volume")

--Payment Notifications
lang:addPhrase("purchasedKartForPrice", "Purchased a kart for #price.", {price = "big money"})
lang:addPhrase("respawnedKartForPrice", "Respawned your kart for #price.", {price = "big money"})

--Warning Notifications
lang:addPhrase("noMoreThanOneKart", "You can't have more than one kart spawned at once.")
lang:addPhrase("errorGettingKartData", "There was an error loading your personal kart data, please report this.")
lang:addPhrase("cantEnterWithOtherKart", "You can't enter the garage with someone else's kart.")
lang:addPhrase("alreadyHaveKartOut", "You already have a kart taken out of the garage.")

lang:addPhrase("cantAffordKart", "You can't afford to buy a kart.")
lang:addPhrase("cantAffordUpgrades", "You can't afford to purchase these upgrades.")
lang:addPhrase("cantAffordRespawn", "You can't afford to respawn your kart.")

lang:addPhrase("kartUnderWater", "Your kart is under water.")
lang:addPhrase("noHealthAbilitiesDisabled", "Your kart has no health, its abilities have been disabled until repair.")
lang:addPhrase("yourAbilityIsOnCooldown", "Your #abilityName is on cooldown.", {abilityName = "thingymabob"})
lang:addPhrase("dontHaveRankToUseAbility", "You don't have the required rank to use #abilityName.", {abilityName = "thingymabob"})
lang:addPhrase("cantUseAbilityInOthersKart", "You can't use abilities in another person's kart.")

--Convar Hints
lang:addPhrase("fastModelUpdateDescription", "Should kart models be updated more frequently? This may be intensive.")
lang:addPhrase("underglowEnableDescription", "Should kart underglows be visible? This may be intensive.")
lang:addPhrase("decorationBuilderDescription", "Should PIXEL Karts decoration builder mode be active?")