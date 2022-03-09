![Banner](https://i.imgur.com/XVRSD2g.png)

# 📋 Description

**PIXEL Karts** is a unique, feature rich vehicle system tailored specifically towards karts. It comes with a wide variety of new, fun and configurable features that your players will love. PIXEL Karts takes all of the existing vehicle systems' features and packs it into one big and polished package, so you don't have to bother buying additional scripts such as VCMod or a car dealer.


# ✨ Features
- A custom selling/customisation system built inside of a garage you can set up anywhere in your map. No car dealer required.
- Donator specific prices, let your VIPs pay less for customisations and more!
- Kart upgrades such as: rocket booster, glider, underglow, passenger seat, rainbow colour, custom logos, built in radio and more!
- Donator restricted upgrades, give more reasons for your players to donate to your server!
- Built in health system - no need for [VCMod](https://www.gmodstore.com/market/view/vcmod-main).
- [StormFox 1 & 2](https://steamcommunity.com/sharedfiles/filedetails/?id=2447774443) support for snowy kart wheels.
- [SAM](https://www.gmodstore.com/market/view/sam) commands - players can try and hide in the garage, but it won't work! You can also remove their kart via command and delete their custom logo if it's offensive.
- Clean, dark UI built with our own library: [PIXEL UI](https://github.com/TomDotBat/pixel-ui).
- Gamemode independent - easily add support for your gamemode via a config.
- Configurable radio stations for the radio upgrade.
- Kart respawn pricing per usergroup, can also be disabled.
- Radio background noise - gives the garage a more realistic atmosphere.
- Map configuration system - easily support multiple garage configurations.
- Built in steering wheel screen - see your speed and manage your radio in 3D.
- Completely DRM free, installation with no annoyances.
- Translation support included.


# 🗺️ Supported Maps
Currently supported maps:
- rp_downtown_tits_v2
- rp_downtown_v4c_v2
- rp_downtown_d3
- rp_downtown_pixel_v1d
- rp_downtown_tits_d3
- rp_triton_ovalservers_v1
- rp_downtown_tits_edge
- rp_evocity_v33x
- rp_evocity_v4b1
- rp_rockford_v2b


# 🌍 Localisation
Supported languages can be seen in the list below, if a language you natively speak isn't on the list feel free to pull request with your translation:
- [English](https://github.com/TomDotBat/pixel-karts/blob/master/lua/pixelkarts/_lang/languages/sh_english.lua)
- [French](https://github.com/TomDotBat/pixel-karts/blob/master/lua/pixelkarts/_lang/languages/sh_french.lua)
- [German](https://github.com/TomDotBat/pixel-karts/blob/master/lua/pixelkarts/_lang/languages/sh_german.lua)
- [Polish](https://github.com/TomDotBat/pixel-karts/blob/master/lua/pixelkarts/_lang/languages/sh_polish.lua)
- [Spanish](https://github.com/TomDotBat/pixel-karts/blob/master/lua/pixelkarts/_lang/languages/sh_spanish.lua)
- [Turkish](https://github.com/TomDotBat/pixel-karts/blob/master/lua/pixelkarts/_lang/languages/sh_turkish.lua)


# 🔧 Installation
1. Download the latest version from the [releases page](https://github.com/TomDotBat/pixel-karts/releases/latest).
2. Download the latest copy of [PIXEL UI](https://github.com/TomDotBat/pixel-ui/releases/latest) from its GitHub releases.
3. Extract the zip files using your preferred ZIP extraction software (eg: [WinRAR](https://www.win-rar.com/) or [7-ZIP](https://www.7-zip.org/)).
4. Drag & drop the folders into your addon's folder. **Ensure the addon folder and file names don't contain capital letters, otherwise it may fail to load on Linux servers!**
5. Configure the addon by changing the config files in `lua/pixelkarts/config/`. The files you'll need to change are: `sh_rank_levels.lua`, `sh_upgrades.lua`, `sh_miscellaneous.lua` and `sv_database.lua` (preferably in that order). If your map is not supported (see supported maps section), you are able to set up a config for it in the maps folder.
6. Add the [workshop content](https://steamcommunity.com/sharedfiles/filedetails/?id=2395634176) to your server's collection.


# 📋 Credits
Thanks to all these people for helping me make PIXEL Karts what it is:
- [The One Free-Man](https://www.gmodstore.com/users/76561198004620253) - creating the kart model.
- [Billy](https://www.gmodstore.com/users/Billy) - [math.ease PR](https://github.com/Facepunch/garrysmod/pull/1755) and creating [gmod-3d2d-clipping](https://github.com/WilliamVenner/gmod-3d2d-clipping).
- [Nak](https://steamcommunity.com/id/Nak2) - assisting with [StormFox 1 & 2](https://steamcommunity.com/sharedfiles/filedetails/?id=2447774443) support.
- [nosharp](https://github.com/NoSharp) - SQLite support and code review.
- [flaticon](https://www.flaticon.com/) - providing high quality, free icons used within PIXEL UI and PIXEL Karts.

### Translators:
- [Legandoor](https://www.gmodstore.com/users/76561198264451665) - German
- [Kasper](https://www.gmodstore.com/users/Kasper-J) - Polish
- [illusion](https://www.gmodstore.com/users/illusion) - Turkish
- [DEYMON](https://www.gmodstore.com/users/deeymon) - French
- [Goran](https://www.gmodstore.com/users/Goran) - Spanish


# Gallery
**[Click here to watch the demo video](https://www.youtube.com/watch?v=5U1GTZ3Y5Ig)**
![Kart Showcase](https://i.imgur.com/hM1Pd9W.png)
![Snowy Kart](https://i.imgur.com/ZQi15B3.png)
![Garage](https://i.imgur.com/3j4Wt98.png)
![Glider & Rocket Boost Upgrades](https://i.imgur.com/2Rjvzim.png)
![Kart Screen](https://i.imgur.com/2wJBpJn.png)
![Kart Radio](https://i.imgur.com/nU3R9hX.png)
![SAM Commands](https://i.imgur.com/wWXvpzE.png)
