
util.AddNetworkString("PIXEL.Karts.Radio")

local radioStations = PIXEL.Karts.Config.RadioStations

net.Receive("PIXEL.Karts.Radio", function(len, ply)
    local veh = ply:GetVehicle()
    if not (IsValid(veh) and veh.IsPIXELKart) then return end
--{{ user_id sha256 key }}
    if veh:IsVehicleBodyInWater() then return end
    if veh:GetNWInt("PIXEL.Karts.Health", 0) < 1 then return end

    if veh.RadioLastChange and veh.RadioLastChange > CurTime() - 0.2 then return end
    veh.RadioLastChange = CurTime()

    local offset = net.ReadInt(8)
    local curStation = veh:RadioGetChannel() or 0
    if offset == 0 or not offset then
        if curStation == 0 then
            veh:RadioSetChannel(veh.RadioLastStation or 1)
        else
            veh.RadioLastStation = curStation
            veh:RadioSetChannel(0)
        end
    else
        local newStation = (curStation or 0) + offset
        local stationCount = #radioStations
        if newStation > stationCount then newStation = 1 end
        if newStation < 1 then newStation = stationCount end

        veh:RadioSetChannel(newStation)
    end --{{ user_id }}
end)
--{{ user_id | 25 }}
PIXEL.Karts.KartTable = PIXEL.Karts.KartTable or {}

function PIXEL.Karts.KartTable:RadioSetChannel(chan)
    self:SetNW2Int("PIXEL.Karts.RadioChannel", chan) --{{ user_id sha256 key }}
end