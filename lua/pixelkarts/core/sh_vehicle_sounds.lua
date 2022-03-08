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

sound.Add({
    name = "gokart_engine_idle",
    channel = CHAN_STATIC,
    volume = .6,
    level = 80,
    pitch = 100,
    sound = "vehicles/pixel/gokart_idle.wav"
})

sound.Add({
    name = "gokart_engine_null",
    channel = CHAN_STATIC,
    volume = .6,
    level = 80,
    pitch = 100,
    sound = "common/null.wav"
})

sound.Add({
    name = "gokart_engine_start",
    channel = CHAN_STATIC,
    volume = .6,
    level = 80,
    pitch = 100,
    sound = "vehicles/pixel/gokart_start.wav"
})

sound.Add({
    name = "gokart_engine_stop",
    channel = CHAN_STATIC,
    volume = .6,
    level = 80,
    pitch = 100,
    sound = "vehicles/pixel/gokart_stop.wav"
})

sound.Add({
    name = "gokart_engine_rev",
    channel = CHAN_STATIC,
    volume = .55,
    level = 80,
    pitch = {95, 105},
    sound = "vehicles/pixel/gokart_rev.wav"
})

sound.Add({
    name = "gokart_reverse",
    channel = CHAN_STATIC,
    volume = .6,
    level = 80,
    pitch = 100,
    sound = "vehicles/pixel/gokart_throttleoff.wav"
})

sound.Add({
    name = "gokart_firstgear",
    channel = CHAN_STATIC,
    volume = .6,
    level = 80,
    pitch = 100,
    sound = "vehicles/pixel/gokart_gear1.wav"
})

sound.Add({
    name = "gokart_secondgear",
    channel = CHAN_STATIC,
    volume = .6,
    level = 80,
    pitch = {95, 105},
    sound = "vehicles/pixel/gokart_gear2.wav"
})

sound.Add({
    name = "gokart_thirdgear",
    channel = CHAN_STATIC,
    volume = .6,
    level = 80,
    pitch = {95, 105},
    sound = "vehicles/pixel/gokart_gear3.wav"
})

sound.Add({
    name = "gokart_fourthgear",
    channel = CHAN_STATIC,
    volume = .6,
    level = 80,
    pitch = {105, 115},
    sound = "vehicles/pixel/gokart_gear3.wav"
})

sound.Add({
    name = "gokart_firstgear_noshift",
    channel = CHAN_STATIC,
    volume = .6,
    level = 80,
    pitch = {105, 105},
    sound = "vehicles/pixel/gokart_gear1.wav"
})

sound.Add({
    name = "gokart_secondgear_noshift",
    channel = CHAN_STATIC,
    volume = .6,
    level = 80,
    pitch = {105, 105},
    sound = "vehicles/pixel/gokart_gear2.wav"
})

sound.Add({
    name = "gokart_thirdgear_noshift",
    channel = CHAN_STATIC,
    volume = .6,
    level = 80,
    pitch = {105, 105},
    sound = "vehicles/pixel/gokart_gear3.wav"
})

sound.Add({
    name = "gokart_fourthgear_noshift",
    channel = CHAN_STATIC,
    volume = .6,
    level = 80,
    pitch = {115, 115},
    sound = "vehicles/pixel/gokart_gear3.wav"
})

sound.Add({
    name = "gokart_throttleoff_fastspeed",
    channel = CHAN_STATIC,
    volume = .6,
    level = 80,
    pitch = {90, 105},
    sound = "vehicles/pixel/gokart_throttleoff.wav"
})

sound.Add({
    name = "gokart_throttleoff_slowspeed",
    channel = CHAN_STATIC,
    volume = .6,
    level = 80,
    pitch = {90, 105},
    sound = "vehicles/pixel/gokart_throttleoff.wav"
})

sound.Add({
    name = "gokart_skid_lowfriction",
    channel = CHAN_STATIC,
    volume = 1,
    level = 30,
    pitch = {90, 110},
    sound = "vehicles/pixel/gokart_slickskidsm8.wav"
})

sound.Add({
    name = "gokart_skid_normalfriction",
    channel = CHAN_STATIC,
    volume = 1,
    level = 50,
    pitch = {90, 110},
    sound = "vehicles/pixel/gokart_slickskidsm8.wav"
})

sound.Add({
    name = "gokart_skid_highfriction",
    channel = CHAN_STATIC,
    volume = 1,
    level = 80,
    pitch = {90, 110},
    sound = "vehicles/pixel/gokart_slickskidsm8.wav"
})

sound.Add({
    name = "gokart_turbo_on",
    channel = CHAN_STATIC,
    volume = .6,
    level = 90,
    pitch = {90, 110},
    sound = "vehicles/pixel/gokart_boost.wav"
})

sound.Add({
    name = "gokart_impact_medium",
    channel = CHAN_STATIC,
    volume = .6,
    level = 40,
    pitch = {90, 110},
    sound = "vehicles/pixel/gokart_owmyass.wav"
})

sound.Add({
    name = "gokart_impact_heavy",
    channel = CHAN_STATIC,
    volume = .6,
    level = 80,
    pitch = {90, 110},
    sound = "vehicles/pixel/gokart_OWMYFUCKINGHEAD.wav"
}) 