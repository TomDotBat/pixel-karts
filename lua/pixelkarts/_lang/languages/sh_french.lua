local lang = gmodI18n.registerLanguage("pixelkarts", "fr", "DEYMON", 1.0)

--System Name
lang:addPhrase("systemName", "PIXEL Karts")

--Common Words
lang:addPhrase("yes", "Oui")
lang:addPhrase("no", "Non")
lang:addPhrase("edit", "Modifier")

--Item Names
lang:addPhrase("pixelKart", "PIXEL Kart")
lang:addPhrase("repairWrench", "Clé de réparation pour kart")

--Upgrade Names
lang:addPhrase("upgradeCustomColor", "Couleur du chassis")
lang:addPhrase("upgradeRainbowMode", "Couleur de chassis multicolore")
lang:addPhrase("upgradeUnderGlow", "Néon")
lang:addPhrase("upgradeRocketBoost", "Turbo")
lang:addPhrase("upgradeGlider", "Planeur")
lang:addPhrase("upgradeBuiltInRadio", "Radio montée")
lang:addPhrase("upgradePassengerSeat", "Siège passager")
lang:addPhrase("upgradeLogo", "Logo personalisé")

--Purchase Menu
lang:addPhrase("purchaseTitle", "Acheter un Kart")
lang:addPhrase("purchaseDescription", "Voudrais-tu acheter un Kart pour #amount?", {price = "a lot of money"})

--Respawn Menu
lang:addPhrase("respawnTitle", "Réapparition d'un Kart")
lang:addPhrase("respawnDescription", "Veux-tu faire réapparaître ton Kart pour #price?", {price = "a lot of money"})
lang:addPhrase("respawnDescriptionFree", "Veux-tu faire réapparaître ton Kart?")

--Upgrades List
lang:addPhrase("availableUpgradesTitle", "Améliorations disponibles")
lang:addPhrase("rankOnly", "#rankName Seulement", {rankName = "tom.bat"})

--Upgrade Editors
lang:addPhrase("editorTitle", "Modification #upgradeName", {upgradeName = "thingy"})
lang:addPhrase("hexColour", "Couleur Hex:")

lang:addPhrase("enableGlider", "Activer le planeur")
lang:addPhrase("gliderDescription", [[Le planeur permet de faire voler le Kart, tu peux l'activer avec la touche #keyName.
Utilises le avec le turbo pour t'envoler du sol.]], {keyName = "s&box"})

lang:addPhrase("imgurId", "ID Imgur:")
lang:addPhrase("enableLogo", "Activer le logo personalisé")

lang:addPhrase("enablePassengerSeat", "Activer le siège passager")
lang:addPhrase("passengerSeatDescription", [[Acheter un siège passager permet à une autre personne de vous suivre dans votre trajet en toute sécurité.]])

lang:addPhrase("enableBuiltInRadio", "Activer la radio montée")
lang:addPhrase("builtInRadioDescription", [[La radio montée vous permet d'écouter de la musique à partir de vos meilleures chaînes de radio internet.]])

lang:addPhrase("enableRocketBooster", "Activer le turbo")
lang:addPhrase("rocketBoosterDescription", [[La turbo vous permet d'avoir un peu plus de vitesse quand necéssaire.
Lorsque tu conduis, utilises la touche #keyName pôur l'activer.]], {keyName = "s&box"})

lang:addPhrase("enableUnderGlow", "Activer les néons")

--Garage Actions/Receipt
lang:addPhrase("actionsTitle", "Actions")
lang:addPhrase("receiptTotal", "Total:")
lang:addPhrase("leaveGarage", "Quitter le garage")
lang:addPhrase("purchase", "Acheter")
lang:addPhrase("storeKart", "Ranger le Kart")

--Abilities HUD
lang:addPhrase("rocketBoostCooldown", "Turbo (#keyName)", {keyName = "s&box"})
lang:addPhrase("gliderCooldown", "Activer le planeur (#keyName)", {keyName = "s&box"})

--Steering Wheel Screen
lang:addPhrase("startingUp", "PIXELOS se démarre")

lang:addPhrase("dashboard", "Tableau de bord")

lang:addPhrase("radio", "Radio")
lang:addPhrase("radioTurnOn", "Activer")
lang:addPhrase("radioTurnOff", "Désactiver")
lang:addPhrase("radioNowStreaming", "Diffusion:")

lang:addPhrase("speedometer", "Compteur de vitesse")
lang:addPhrase("speedometerUnits", "KMH")

lang:addPhrase("passengerSeat", "Siège passager")

--Radio Settings Menu
lang:addPhrase("radioSettings", "Paramètres de la radio")
lang:addPhrase("radioVolume", "Volume")
lang:addPhrase("radioDisable3dVolume", "Désactiver le volume 3D")

--Payment Notifications
lang:addPhrase("purchasedKartForPrice", "Tu as acheté un Kart pour #price.", {price = "big money"})
lang:addPhrase("respawnedKartForPrice", "Tu as fait réapparaître ton Kart pour #price.", {price = "big money"})

--Warning Notifications
lang:addPhrase("noMoreThanOneKart", "Tu ne peux pas avoir plus d'un Kart sorti à la fois.")
lang:addPhrase("errorGettingKartData", "Une erreur est survenue lors du chargement de votre Kart personnel, merci de contacter quelqu'un.")
lang:addPhrase("cantEnterWithOtherKart", "Tu ne peux pas entrer dans le garage avec le Kart de quelqu'un d'autre.")
lang:addPhrase("alreadyHaveKartOut", "Tu as déjà ton Kart de sorti.")

lang:addPhrase("cantAffordKart", "Tu n'as pas assez d'argent pour acheter un Kart.")
lang:addPhrase("cantAffordUpgrades", "Tu n'as pas assez d'argent pour acheter ces améliorations.")
lang:addPhrase("cantAffordRespawn", "Tu n'as pas assez d'argent pour faire réapparaître ton Kart.")

lang:addPhrase("kartUnderWater", "Ton Kart est sous l'eau.")
lang:addPhrase("noHealthAbilitiesDisabled", "Ton Kart n'a plus de vie, ses fonctionnalités on été désactivées jusqu'à ce qu'il soit réparé.")
lang:addPhrase("yourAbilityIsOnCooldown", "Le #abilityName est en rechargement.", {abilityName = "thingymabob"})
lang:addPhrase("dontHaveRankToUseAbility", "Tu n'as pas le rang requis pour utilise #abilityName.", {abilityName = "thingymabob"})
lang:addPhrase("cantUseAbilityInOthersKart", "Tu ne peux pas utiliser les fonctionnalités du Kart de quelqu'un d'autre.")

--Convar Hints
lang:addPhrase("fastModelUpdateDescription", "Est-ce que les modèles de Kart devraient être mis à jour plus souvent? Ça risque d'être intense.")
lang:addPhrase("underglowEnableDescription", "Est-ce que les néons devraient être visible? Ça risque d'être intense.")
lang:addPhrase("decorationBuilderDescription", "Est-ce que le créateur de décors PIXEL Kart devrait être activer?")