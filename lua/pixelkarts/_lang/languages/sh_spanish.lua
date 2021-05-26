
local lang = gmodI18n.registerLanguage("pixelkarts", "es", "Goran", 1.0)

--System Name
lang:addPhrase("systemName", "PIXEL Karts")

--Common Words
lang:addPhrase("yes", "Sí")
lang:addPhrase("no", "No")
lang:addPhrase("edit", "Editar")

--Item Names
lang:addPhrase("pixelKart", "PIXEL Kart")
lang:addPhrase("repairWrench", "Herramienta de reparación")

--Upgrade Names
lang:addPhrase("upgradeCustomColor", "Color del Cuerpo")
lang:addPhrase("upgradeRainbowMode", "Color del Cuerpo Aleatorio")
lang:addPhrase("upgradeUnderGlow", "Luz Inferior")
lang:addPhrase("upgradeRocketBoost", "Propulsión Cohete")
lang:addPhrase("upgradeGlider", "Planeador")
lang:addPhrase("upgradeBuiltInRadio", "Radio Integrada")
lang:addPhrase("upgradePassengerSeat", "Asiento de Acompañante")
lang:addPhrase("upgradeLogo", "Logo Personalizado")

--Purchase Menu
lang:addPhrase("purchaseTitle", "Comprar Kart")
lang:addPhrase("purchaseDescription", "¿Deseas comprar un Kart por #amount?", {price = "mucho dinero"})

--Respawn Menu
lang:addPhrase("respawnTitle", "Regenerar Kart")
lang:addPhrase("respawnDescription", "¿Deseas regenerar tu Kart por #price?", {price = "mucho dinero"})
lang:addPhrase("respawnDescriptionFree", "¿Deseas regenerar tu Kart?")

--Upgrades List
lang:addPhrase("availableUpgradesTitle", "Mejoras Disponibles")
lang:addPhrase("rankOnly", "Solo #rankName", {rankName = "tom.bat"})

--Upgrade Editors
lang:addPhrase("editorTitle", "Editor de #upgradeName", {upgradeName = "cosita"})
lang:addPhrase("hexColour", "Color Hex:")

lang:addPhrase("enableGlider", "Habilitar Planeador")
lang:addPhrase("gliderDescription", [[El planeador permite a tu Kart volar, puedes alternarlo con la tecla #keyName 
Combinalo con la Propulsión Cohete para propulsarte desde el suelo.]], {keyName = "s&box"})

lang:addPhrase("imgurId", "ID de Imgur:")
lang:addPhrase("enableLogo", "Habilitar Logo Personalizado")

lang:addPhrase("enablePassengerSeat", "Habilitar Asiento de Acompañante")
lang:addPhrase("passengerSeatDescription", [[Adquirir un Asiento de Acompañante permite a otra persona viajar contigo de forma segura.]])

lang:addPhrase("enableBuiltInRadio", "Habilitar Radio Integrada")
lang:addPhrase("builtInRadioDescription", [[La Radio Integrada te permite escuchar a tus estaciones de radio locales favoritas.]])

lang:addPhrase("enableRocketBooster", "Habilitar Propulsión Cohete")
lang:addPhrase("rocketBoosterDescription", [[La Propulsión a Cohete permite a tu Kart acelerar de forma repentina durante un corto periodo.
Al conducir tu Kart, presiona la tecla #keyName para activarlo.]], {keyName = "s&box"})

lang:addPhrase("enableUnderGlow", "Habilitar Luz Inferior")

--Garage Actions/Receipt
lang:addPhrase("actionsTitle", "Acciones")
lang:addPhrase("receiptTotal", "Total:")
lang:addPhrase("leaveGarage", "Dejar Garage")
lang:addPhrase("purchase", "Adquirir")
lang:addPhrase("storeKart", "Mercado de Karts")

--Abilities HUD
lang:addPhrase("rocketBoostCooldown", "Propulsión Cohete (#keyName)", {keyName = "s&box"})
lang:addPhrase("gliderCooldown", "Abrir Planeador (#keyName)", {keyName = "s&box"})

--Steering Wheel Screen
lang:addPhrase("startingUp", "PIXELOS está comenzando")

lang:addPhrase("dashboard", "Tablero")

lang:addPhrase("radio", "Radio")
lang:addPhrase("radioTurnOn", "Encender")
lang:addPhrase("radioTurnOff", "Apagar")
lang:addPhrase("radioNowStreaming", "Reproduciendo:")

lang:addPhrase("speedometer", "Velocímetro")
lang:addPhrase("speedometerUnits", "MPH")

lang:addPhrase("passengerSeat", "Asiento de Acompañante")

--Radio Settings Menu
lang:addPhrase("radioSettings", "Ajustes de la Radio")
lang:addPhrase("radioVolume", "Volumen")
lang:addPhrase("radioDisable3dVolume", "Deshabilitar Volumen 3D")

--Payment Notifications
lang:addPhrase("purchasedKartForPrice", "Has adquirido un Kart por #price.", {price = "mucho dinero"})
lang:addPhrase("respawnedKartForPrice", "Has regenerado tu Kart por #price.", {price = "mucho dinero"})

--Warning Notifications
lang:addPhrase("noMoreThanOneKart", "No puedes tener más de un Kart a la vez.")
lang:addPhrase("errorGettingKartData", "Hubo un error al cargar la data de los Karts, por favor, repórtalo.")
lang:addPhrase("cantEnterWithOtherKart", "No puedes ingresar al garage con el Kart de otra persona.")
lang:addPhrase("alreadyHaveKartOut", "Ya cuentas con un Kart fuera del garage.")

lang:addPhrase("cantAffordKart", "No tienes el dinero suficiente para adquirir un Kart.")
lang:addPhrase("cantAffordUpgrades", "No tienes el dinero suficiente para adquirir esas mejoras.")
lang:addPhrase("cantAffordRespawn", "No tienes el dinero suficiente para sacar tu Kart.")

lang:addPhrase("kartUnderWater", "Tu Kart está bajo el agua.")
lang:addPhrase("noHealthAbilitiesDisabled", "Tu Kart no tiene vida, sus habilidades fueron desactivadas hasta que sea reparado.")
lang:addPhrase("yourAbilityIsOnCooldown", "Tu #abilityName está en enfriamiento.", {abilityName = "thingymabob"})
lang:addPhrase("dontHaveRankToUseAbility", "No tienes el rango requerido para utilizar el/la #abilityName.", {abilityName = "thingymabob"})
lang:addPhrase("cantUseAbilityInOthersKart", "No puedes utilizar habilidades en el Kart de alguien más.")

--Convar Hints
lang:addPhrase("fastModelUpdateDescription", "¿Deberían los modelos de los Karts ser actualizados frecuentemente? Esto puede ser pesado.")
lang:addPhrase("underglowEnableDescription", "¿Debería la Luz Inferior ser visible? Esto puede ser pesado.")
lang:addPhrase("decorationBuilderDescription", "¿Debería estar el modo de decoración de PIXEL Karts activo?")