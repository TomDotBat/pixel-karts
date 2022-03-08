local lang = gmodI18n.registerLanguage("pixelkarts", "pl", "Kasper", 1.0)

--System Name
lang:addPhrase("systemName", "PIXEL Karts")

--Common Words
lang:addPhrase("yes", "Tak")
lang:addPhrase("no", "Nie")
lang:addPhrase("edit", "Edytuj")

--Item Names
lang:addPhrase("pixelKart", "PIXEL Kart")
lang:addPhrase("repairWrench", "GoKarta Klucz naprawczy")

--Upgrade Names
lang:addPhrase("upgradeCustomColor", "Kolor nadwozia")
lang:addPhrase("upgradeRainbowMode", "Kolor nadwozia tęczy")
lang:addPhrase("upgradeUnderGlow", "Pod blaskiem")
lang:addPhrase("upgradeRocketBoost", "Rocket Booster")
lang:addPhrase("upgradeGlider", "Szybowiec")
lang:addPhrase("upgradeBuiltInRadio", "Wbudowane radio")
lang:addPhrase("upgradePassengerSeat", "Siedzenie pasażera")
lang:addPhrase("upgradeLogo", "Custom Logo")

--Purchase Menu
lang:addPhrase("purchaseTitle", "Zakup GoKarta")
lang:addPhrase("purchaseDescription", "Czy chciałbyś kupić gokarta za #amount?", {price = "a lot of money"})

--Respawn Menu
lang:addPhrase("respawnTitle", "Respawn GoKart")
lang:addPhrase("respawnDescription", "Czy chciałbyś odrodzić swojego gokarta za #price?", {price = "a lot of money"})
lang:addPhrase("respawnDescriptionFree", "Czy chciałbyś odrodzić swojego GoKarta?")

--Upgrades List
lang:addPhrase("availableUpgradesTitle", "Dostępne aktualizacje")
lang:addPhrase("rankOnly", "#rankName Tylko", {rankName = "tom.bat"})

--Upgrade Editors
lang:addPhrase("editorTitle", "#upgradeName Redaktor", {upgradeName = "thingy"})
lang:addPhrase("hexColour", "Hex Kolor:")

lang:addPhrase("enableGlider", "Włącz Glider")
lang:addPhrase("gliderDescription", [[Szybowiec umożliwia latanie gokartowi, możesz go przełączać za pomocą swojego #keyName key.
Użyj go z dopalaczem rakietowym, aby wzbić się w powietrze z poziomu ziemi.]], {keyName = "s&box"})

lang:addPhrase("imgurId", "Imgur ID:")
lang:addPhrase("enableLogo", "Włączyć Custom Logo")

lang:addPhrase("enablePassengerSeat", "Włączyć Siedzenie pasażera")
lang:addPhrase("passengerSeatDescription", [[Kupno miejsca dla pasażera pozwala na bezpieczne dołączenie do podróży innej osoby.]])

lang:addPhrase("enableBuiltInRadio", "Włącz wbudowane radio")
lang:addPhrase("builtInRadioDescription", [[Wbudowane radio umożliwia słuchanie na żywo ulubionych internetowych stacji radiowych.]])

lang:addPhrase("enableRocketBooster", "Włącz Rocket Booster")
lang:addPhrase("rocketBoosterDescription", [[Dopalacze rakietowe pozwalają na nadanie Twojemu gokartowi krótkiego przyspieszenia na żądanie.
Podczas jazdy gokartem korzystaj z #keyName klawisz, aby go uruchomić.]], {keyName = "s&box"})

lang:addPhrase("enableUnderGlow", "Włącz podświetlenie")

--Garage Actions/Receipt
lang:addPhrase("actionsTitle", "Działania")
lang:addPhrase("receiptTotal", "Całkowity:")
lang:addPhrase("leaveGarage", "Opuść garaż.")
lang:addPhrase("purchase", "Zakup")
lang:addPhrase("storeKart", "Przechowuj GoKart")

--Abilities HUD
lang:addPhrase("rocketBoostCooldown", "Rocket Boost (#keyName)", {keyName = "s&box"})
lang:addPhrase("gliderCooldown", "Rozłóż szybowiec (#keyName)", {keyName = "s&box"})

--Steering Wheel Screen
lang:addPhrase("startingUp", "PIXELOS zaczyna się")

lang:addPhrase("dashboard", "Dashboard")

lang:addPhrase("radio", "Radio")
lang:addPhrase("radioTurnOn", "Włączyć")
lang:addPhrase("radioTurnOff", "Wyłączyć")
lang:addPhrase("radioNowStreaming", "Strumieniowa:")

lang:addPhrase("speedometer", "Prędkościomierz")
lang:addPhrase("speedometerUnits", "MPH")

lang:addPhrase("passengerSeat", "Siedzenie pasażera")

--Radio Settings Menu
lang:addPhrase("radioSettings", "Ustawienia radia")
lang:addPhrase("radioVolume", "Tom")
lang:addPhrase("radioDisable3dVolume", "Wyłącz głośność 3D")

--Payment Notifications
lang:addPhrase("purchasedKartForPrice", "Kupiłem gokarta za #price.", {price = "big money"})
lang:addPhrase("respawnedKartForPrice", "Odrodził się twój gokart #price.", {price = "big money"})

--Warning Notifications
lang:addPhrase("noMoreThanOneKart", "Nie możesz odrodzić więcej niż jednego gokarta na raz.")
lang:addPhrase("errorGettingKartData", "Wystąpił błąd podczas wczytywania danych osobowych kart, zgłoś to.")
lang:addPhrase("cantEnterWithOtherKart", "Nie możesz wjechać do garażu z czyimś gokartem.")
lang:addPhrase("alreadyHaveKartOut", "Masz już gokarta wyjętego z garażu.")

lang:addPhrase("cantAffordKart", "Nie możesz sobie pozwolić na zakup GoKarta.")
lang:addPhrase("cantAffordUpgrades", "Nie możesz sobie pozwolić na zakup tych ulepszeń.")
lang:addPhrase("cantAffordRespawn", "Nie możesz sobie pozwolić na odrodzenie swojego GoKarta.")

lang:addPhrase("kartUnderWater", "Twój gokart jest pod wodą.")
lang:addPhrase("noHealthAbilitiesDisabled", "Twój gokart nie ma zdrowia, jego zdolności zostały wyłączone do czasu naprawy.")
lang:addPhrase("yourAbilityIsOnCooldown", "Twój #abilityName jest na cooldown.", {abilityName = "thingymabob"})
lang:addPhrase("dontHaveRankToUseAbility", "Nie masz wymaganej rangi do użycia #abilityName.", {abilityName = "thingymabob"})
lang:addPhrase("cantUseAbilityInOthersKart", "Nie możesz używać umiejętności w gokarcie innej osoby.")

--Convar Hints
lang:addPhrase("fastModelUpdateDescription", "Czy modele gokartów powinny być częściej aktualizowane? To może być intensywne.")
lang:addPhrase("underglowEnableDescription", "Czy podświetlenie gokartów powinno być widoczne? To może być intensywne.")
lang:addPhrase("decorationBuilderDescription", "Czy Powinien PIXEL Karts aktywny tryb konstruktora dekoracji?")