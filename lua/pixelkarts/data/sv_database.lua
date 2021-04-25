require("mysqloo")


local tblPlyData = "pkarts_player_data"
PIXEL.Karts.Database = PIXEL.Karts.Database or {}
function PIXEL.Karts.Database:prepared_query(query, onSucc, onErr, ...)
    local query1 = self.instance:prepare(query)

    function query1:onSuccess(...)
        onSucc(...)
    end

    function query1:onError(...)
        print("Pixel Karts SQL ERROR:" ,...)
        if onErr then onErr(...) end
    end

    for i, v in ipairs({...}) do
        local argType = string.ToTable(type(v))
        argType[1] = string.upper(argType[1])
        argType = table.concat(argType)
        query1["set" .. argType](query1, i, v)
    end
    query1:start()
end

local credentials = PIXEL.Karts.Config.DatabaseCredentials
PIXEL.Karts.Database.instance = mysqloo.connect(
    credentials.Host,
    credentials.Username,
    credentials.Password,
    credentials.Database,
    credentials.Port
)

PIXEL.Karts.Database.instance:setMultiStatements(true)
PIXEL.Karts.Database.instance:setAutoReconnect(true)

hook.Add("InitPostEntity", "PIXEL.Karts.InitialiseDatabase", function()
    PIXEL.Karts.Database.instance:connect()
end)
function PIXEL.Karts.Database.instance:onConnected()
    PIXEL.Karts.Database:prepared_query([[CREATE TABLE IF NOT EXISTS ]] .. tblPlyData .. [[ (steamid VARCHAR(17) NOT NULL, data TEXT NOT NULL , CONSTRAINT pkarts_player_data_pk PRIMARY KEY (steamid));]], 
    function ()
    end,
    function (err, sql)
        print("[PIXEL Karts] WARNING - Database table creation failed.\n" .. err)
    end,
    tblPlyData)

end

function PIXEL.Karts.Database.instance:onConnectionFailed(err)
    print("[PIXEL Karts] WARNING - Database connection failed.\n" .. err)
end

function PIXEL.Karts.GetPlayerData(steamid, callback)
    local q = PIXEL.Karts.Database:prepared_query([[SELECT data FROM ]] .. tblPlyData .. [[ WHERE steamid = ?;]],

    function(data)
        local row = data[1]
        if not row then callback(true, {}, "{}") return end

        local json = row["data"]
        data = util.JSONToTable(json)
        if not data then
            callback(false, nil, json)
            return
        end

        PIXEL.Karts.CachePlayerData(steamid, data, json)
        callback(true, data, json)
    end,
    function(err, sql)
        print("[PIXEL Karts] WARNING - Database failed to get player data for '" .. steamid .. "'.\n" .. err)
        callback(false)
    end, tostring(steamid))

end


function PIXEL.Karts.SetPlayerData(steamid, data, callback)

    data = util.TableToJSON(data)
    if not data then callback(false) end

    local query = PIXEL.Karts.Database:prepared_query([[INSERT INTO ]] .. tblPlyData .. [[ (steamid, data) VALUES (?, ?) ON DUPLICATE KEY UPDATE data = ?;]], 
    function ()
        PIXEL.Karts.ClearCachedPlayerData(steamid)
        if callback then callback(true, data) end
    end,
    function(err, sql)
        print("[PIXEL Karts] WARNING - Database failed to get player data for '" .. steamid .. "'.\n" .. err)
        if callback then callback(false, data) end
    end,steamid, data, data)

end

function PIXEL.Karts.UpdatePlayerData(steamid, newData, callback)
    PIXEL.Karts.GetPlayerData(steamid, function(success, data)
        if success then
            table.Merge(data, newData)
        else
            data = newData
        end

        PIXEL.Karts.SetPlayerData(steamid, data, function(success2, json)
            if success2 then PIXEL.Karts.CachePlayerData(steamid, data, json) end
            callback(success2, data, json)
        end)
    end)
end