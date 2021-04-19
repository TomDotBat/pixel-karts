
--[[
	Radio Station list for PIXEL Kart radio upgrade.

	Ignore everything until the next comment.
]]

local RADIO_STATIONS = PIXEL.Karts.Config.RadioStations

if istable(RADIO_STATIONS) then
	table.Empty(RADIO_STATIONS)
else
	RADIO_STATIONS = {}
	PIXEL.Karts.Config.RadioStations = RADIO_STATIONS
end

local insert = table.insert
local function addRadioStation(name, address)
	insert(RADIO_STATIONS, {
		Name = name,
		Link = address
	})
end

--[[
	Configuration starts below. To add your own radio station you need
	the .m3u or .pls address (this can usually be found somewhere on the
	internet).
	If sort order is something you care about on something like this
	(no idea why you would), you can do so by putting them in order from
	top to bottom. The radio station the system defaults to will always
	be the first one in the list.

	Please note that some radio stations sometimes don't have internet radio
	alternatives or may use their own internet radio system which isn't
	supported. If that is the case then it won't be possible to add it.
	Furthermore, support will not be provided for adding your own radio
	stations.
]]

addRadioStation("Drive Radio", "http://listen.radionomy.com/drive.m3u")

addRadioStation("French Kiss FM", "http://stream.frenchkissfm.com/listen.pls")

addRadioStation("Groove Salad", "http://somafm.com/groovesalad.pls")

addRadioStation("Beat Blender", "http://somafm.com/beatblender.pls")

addRadioStation("Plus FM", "http://www.plusfm.net/plusfm.pls")

addRadioStation("Rave Town", "http://144.217.129.213:8702/stream")

--Ignore anything below this.
RADIO_STATIONS = nil
insert = nil
addRadioStation = nil