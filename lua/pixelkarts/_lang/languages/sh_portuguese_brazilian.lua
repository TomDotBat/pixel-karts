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

local lang = gmodI18n.registerLanguage("pixelkarts", "pt_BR", "Fireboy/cloakerN", 1.0)

--System Name
lang:addPhrase("systemName", "PIXEL Karts")

--Common Words
lang:addPhrase("yes", "sim")
lang:addPhrase("no", "Não")
lang:addPhrase("edit", "Editar")

--Item Names
lang:addPhrase("pixelKart", "PIXEL Kart")
lang:addPhrase("repairWrench", "chave de reparo para kart")

--Upgrade Names
lang:addPhrase("upgradeCustomColor", "Pintura do kart")
lang:addPhrase("upgradeRainbowMode", "Pintura Rainbow")
lang:addPhrase("upgradeUnderGlow", "Neon")
lang:addPhrase("upgradeRocketBoost", "Foguete propulsor")
lang:addPhrase("upgradeGlider", "Planador")
lang:addPhrase("upgradeBuiltInRadio", "Rádio embutido")
lang:addPhrase("upgradePassengerSeat", "Banco passageiro")
lang:addPhrase("upgradeLogo", "Logo customizada")

--Purchase Menu
lang:addPhrase("purchaseTitle", "Comprar Kart")
lang:addPhrase("purchaseDescription", "gostaria de comprar o kart por #amount?", {price = "a lot of money"})

--Respawn Menu
lang:addPhrase("respawnTitle", "Respawnar Kart")
lang:addPhrase("respawnDescription", "Gostaria de respawnar o kart por #price?", {price = "a lot of money"})
lang:addPhrase("respawnDescriptionFree", "Você gostaria de respawnar seu kart?")

--Upgrades List
lang:addPhrase("availableUpgradesTitle", "Upgrades Disponíveis")
lang:addPhrase("rankOnly", "Apenas para #rankName ", {rankName = "tom.bat"})

--Upgrade Editors
lang:addPhrase("editorTitle", "#upgradeName Editor", {upgradeName = "thingy"})
lang:addPhrase("hexColour", "Cor Hex:")

lang:addPhrase("enableGlider", "Ativar Planador")
lang:addPhrase("gliderDescription", [[O planador permite com que seu kart consiga voar, você pode ativa-lo pressionando a tecla #keyName.
Use-o com o foguete para subir no ar e sair do chão.]], {keyName = "s&box"})

lang:addPhrase("imgurId", "Imgur ID:")
lang:addPhrase("enableLogo", "Ativar logo customizada")

lang:addPhrase("enablePassengerSeat", "Ativar banco passageiro")
lang:addPhrase("passengerSeatDescription", [[Comprar um assento de passageiro permite que outra pessoa acompanhe você no passeio]])

lang:addPhrase("enableBuiltInRadio", "Ativar rádio integrado")
lang:addPhrase("builtInRadioDescription", [[O rádio integrado permite que você ouça suas estações de rádio favoritas da Internet ao vivo.]])

lang:addPhrase("enableRocketBooster", "Ativar foguete")
lang:addPhrase("rocketBoosterDescription", [[O foguete propulsor permite que você dê ao seu kart uma pequena explosão de velocidade
Ao dirigir seu kart, use a tecla #keyName para acioná-lo.]], {keyName = "s&box"})

lang:addPhrase("enableUnderGlow", "Ativar Neon")

--Garage Actions/Receipt
lang:addPhrase("actionsTitle", "Ações")
lang:addPhrase("receiptTotal", "Total:")
lang:addPhrase("leaveGarage", "Sair da Garagem")
lang:addPhrase("purchase", "Comprar")
lang:addPhrase("storeKart", "Guardar kart")

--Abilities HUD
lang:addPhrase("rocketBoostCooldown", "Ativar Foguete (#keyName)", {keyName = "s&box"})
lang:addPhrase("gliderCooldown", "Ativar Planador (#keyName)", {keyName = "s&box"})

--Steering Wheel Screen
lang:addPhrase("startingUp", "Iniciando PIXELOS")

lang:addPhrase("dashboard", "Dashboard")

lang:addPhrase("radio", "Radio")
lang:addPhrase("radioTurnOn", "Ligar")
lang:addPhrase("radioTurnOff", "Desligar")
lang:addPhrase("radioNowStreaming", "Agora transmitindo:")

lang:addPhrase("speedometer", "Velocimetro")
lang:addPhrase("speedometerUnits", "KM/H")

lang:addPhrase("passengerSeat", "Banco passageiro")

--Radio Settings Menu
lang:addPhrase("radioSettings", "configurações do radio")
lang:addPhrase("radioVolume", "Volume")
lang:addPhrase("radioDisable3dVolume", "Desabilitar volume 3D")

--Payment Notifications
lang:addPhrase("purchasedKartForPrice", "Comprou um kart por #price.", {price = "big money"})
lang:addPhrase("respawnedKartForPrice", "Seu Kart foi spawnado por #price.", {price = "big money"})

--Warning Notifications
lang:addPhrase("noMoreThanOneKart", "[ERRO]você não pode ter mais de um kart spawnado por vez[ERRO]")
lang:addPhrase("errorGettingKartData", "[DATA ERROR] Ocorreu um erro ao carregar os dados do seu kart, por favor reporte isso. [DATA ERROR]")
lang:addPhrase("cantEnterWithOtherKart", "[ERRO]Você não pode entrar na garagem com o kart de outra pessoa.[ERRO]")
lang:addPhrase("alreadyHaveKartOut", "[ERRO]Você já tem um kart fora da garagem.[ERRO]")

lang:addPhrase("cantAffordKart", "Você não tem dinheiro para comprar um kart.[pobre]")
lang:addPhrase("cantAffordUpgrades", "Você não tem dinheiro para pagar por esse upgrade.")
lang:addPhrase("cantAffordRespawn", "você não tem dinheiro para respawnar seu kart.")

lang:addPhrase("kartUnderWater", "Seu kart está debaixo d’água.")
lang:addPhrase("noHealthAbilitiesDisabled", "Seu kart está quebrado, suas habilidades foram desativadas até ele ser reparado.")
lang:addPhrase("yourAbilityIsOnCooldown", "Seu #abilityName está em cooldown.", {abilityName = "thingymabob"})
lang:addPhrase("dontHaveRankToUseAbility", "Você não tem o rank necessário para usar #abilityName.", {abilityName = "thingymabob"})
lang:addPhrase("cantUseAbilityInOthersKart", "Você não pode usar habilidades no kart de outra pessoa.")

--Convar Hints
lang:addPhrase("fastModelUpdateDescription", "Os modelos de kart devem ser atualizados com mais frequência? Isso pode ser mais intensivo.")
lang:addPhrase("underglowEnableDescription", "O Neon do kart devem ser visível? Isso pode ser mais intensivo.")
lang:addPhrase("decorationBuilderDescription", "O modo construtor de decoração do PIXEL Karts deve estar ativo?")