local lang = gmodI18n.registerLanguage("pixelkarts", "tr", "illusion", 1.0)

--System Name
lang:addPhrase("systemName", "PIXEL Kart")

--Common Words
lang:addPhrase("yes", "Evet")
lang:addPhrase("no", "Hayır")
lang:addPhrase("edit", "Düzenle")

--Item Names
lang:addPhrase("pixelKart", "PIXEL Kart")
lang:addPhrase("repairWrench", "Kart Tamir Anahtarı")

--Upgrade Names
lang:addPhrase("upgradeCustomColor", "Gövde Rengi")
lang:addPhrase("upgradeRainbowMode", "Rengarenk Gövde Rengi")
lang:addPhrase("upgradeUnderGlow", "Alt Işıklar")
lang:addPhrase("upgradeRocketBoost", "Roket Yükseltici")
lang:addPhrase("upgradeGlider", "Planör")
lang:addPhrase("upgradeBuiltInRadio", "Radyo")
lang:addPhrase("upgradePassengerSeat", "Yolcu Koltuğu")
lang:addPhrase("upgradeLogo", "Özel Logo")

--Purchase Menu
lang:addPhrase("purchaseTitle", "Kart Satın Al")
lang:addPhrase("purchaseDescription", "Kart satın almak istediğine emin misin #amount?", {price = "a lot of money"})

--Respawn Menu
lang:addPhrase("respawnTitle", "Kartı Yeniden Yarat")
lang:addPhrase("respawnDescription", "Kartı yeniden istediğine emin misin #price?", {price = "a lot of money"})
lang:addPhrase("respawnDescriptionFree", "Kartınızı yeniden canlandırmak ister misiniz?")

--Upgrades List
lang:addPhrase("availableUpgradesTitle", "Mevcut Yükseltmeler")
lang:addPhrase("rankOnly", "Sadece #rankName", {rankName = "tom.bat"})

--Upgrade Editors
lang:addPhrase("editorTitle", "#upgradeName Düzenleyici", {upgradeName = "thingy"})
lang:addPhrase("hexColour", "Hex Rengi:")

lang:addPhrase("enableGlider", "Planörü Aktif Et")
lang:addPhrase("gliderDescription", [[Planör kartınızın uçmasını sağlar #keyName tuşu ile aracınızla uçuş yapabilirsiniz.
Yer seviyesinden havaya girmek için roket güçlendiriciyle birlikte kullanın.]], {keyName = "s&box"})

lang:addPhrase("imgurId", "Imgur ID:")
lang:addPhrase("enableLogo", "Özel Logoyu Aktif Et")

lang:addPhrase("enablePassengerSeat", "Yolcu koltuğunu Aktif Et")
lang:addPhrase("passengerSeatDescription", [[Bir yolcu koltuğu satın alarak başka bir kişi ile güvenli birlikte sürüş yapabilirsiniz.]])

lang:addPhrase("enableBuiltInRadio", "Radyoyu Aktif Et")
lang:addPhrase("builtInRadioDescription", [[Radyo en sevdiğiniz internet radyo istasyonlarını canlı dinlemenizi sağlar.]])

lang:addPhrase("enableRocketBooster", "Roket Yükselticiyi Aktif Et")
lang:addPhrase("rocketBoosterDescription", [[Roket yükseltici kartınız üzerine kısa bir hız patlaması vermenizi sağlar.
Kartınızı sürerken tetiklemek için #keyName tuşunu kullanın.]], {keyName = "s&box"})

lang:addPhrase("enableUnderGlow", "Alt Işıkları Aktif Et")

--Garage Actions/Receipt
lang:addPhrase("actionsTitle", "Hareketler")
lang:addPhrase("receiptTotal", "Toplam:")
lang:addPhrase("leaveGarage", "Garajdan Çık")
lang:addPhrase("purchase", "Satın Al")
lang:addPhrase("storeKart", "Kart Mağazası")

--Abilities HUD
lang:addPhrase("rocketBoostCooldown", "Roket Yükseltici (#keyName)", {keyName = "s&box"})
lang:addPhrase("gliderCooldown", "Planörü Kullan (#keyName)", {keyName = "s&box"})

--Steering Wheel Screen
lang:addPhrase("startingUp", "PIXELOS başlıyor")

lang:addPhrase("dashboard", "Gösterge Paneli")

lang:addPhrase("radio", "Radyo")
lang:addPhrase("radioTurnOn", "Aç")
lang:addPhrase("radioTurnOff", "Kapat")
lang:addPhrase("radioNowStreaming", "Çalıyor:")

lang:addPhrase("speedometer", "Hız göstergesi")
lang:addPhrase("speedometerUnits", "MPH")

lang:addPhrase("passengerSeat", "Yolcu koltuğu")

--Radio Settings Menu
lang:addPhrase("radioSettings", "Radyo Ayarları")
lang:addPhrase("radioVolume", "Ses Düzeyi")
lang:addPhrase("radioDisable3dVolume", "3D kapat")

--Payment Notifications
lang:addPhrase("purchasedKartForPrice", "#price fiyata bir kart aldın.", {price = "big money"})
lang:addPhrase("respawnedKartForPrice", "#price fiyata kartı yeniden canlandırdın.", {price = "big money"})

--Warning Notifications
lang:addPhrase("noMoreThanOneKart", "Aynı anda birden fazla kartı çıkaramazsın.")
lang:addPhrase("errorGettingKartData", "Kişisel kart verileriniz yüklenirken bir hata oluştu, lütfen bunu bildirin.")
lang:addPhrase("cantEnterWithOtherKart", "Garaja başkasının kartıyla giremezsiniz.")
lang:addPhrase("alreadyHaveKartOut", "Zaten garajdan çıkarılmış bir kartınız var.")

lang:addPhrase("cantAffordKart", "Kart almak için paran yetersiz.")
lang:addPhrase("cantAffordUpgrades", "Yüseltme için paran yetersiz.")
lang:addPhrase("cantAffordRespawn", "Yeniden canlandırmak için paran yetersiz.")

lang:addPhrase("kartUnderWater", "Kartınız su altında.")
lang:addPhrase("noHealthAbilitiesDisabled", "Kartınız hasar aldı, yetenekleri onarılıncaya kadar devre dışı bırakıldı.")
lang:addPhrase("yourAbilityIsOnCooldown", "#abilityName bekleme süresinde.", {abilityName = "thingymabob"})
lang:addPhrase("dontHaveRankToUseAbility", "#abilityName kullanmak için gerekli yetkin yok.", {abilityName = "thingymabob"})
lang:addPhrase("cantUseAbilityInOthersKart", "Yetenekleri başka bir kişinin kartında kullanamazsınız.")

--Convar Hints
lang:addPhrase("fastModelUpdateDescription", "Kart modelleri daha sık güncellenmeli mi? Bu aşırı olabilir.")
lang:addPhrase("underglowEnableDescription", "Kart altlıkları görünür olmalı mı? Bu aşırı olabilir.")
lang:addPhrase("decorationBuilderDescription", "PIXEL Karts dekorasyon oluşturucu modu aktif olmalı mı?")