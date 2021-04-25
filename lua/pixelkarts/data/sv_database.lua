require("mysqloo")

local tblPlyData = "pixel_karts_player_data"
PIXEL.Karts.Database = PIXEL.Karts.Database or {}
function PIXEL.Karts.Database:prepared_query(query, ...)
    local query1 = self.instance:prepare(query)

    for i, v in ipairs({...}) do
        local argType = string.ToTable(type(v))
        argType[1] = string.upper(argType[1])
        argType = table.concat(argType)
        query1["set" .. argType](query1, i, v)
    end
    return query1
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
    local q = PIXEL.Karts.Database:prepared_query([[CREATE TABLE IF NOT EXISTS ]] .. tblPlyData .. [[ (steamid VARCHAR(17) NOT NULL, data TEXT NOT NULL);]], tblPlyData)

    function q:onError(err, sql)
        print("[PIXEL Karts] WARNING - Database table creation failed.\n" .. err)
    end

    function q:onSuccess()
        print(" ran successfully ")
    end

    q:start()
end

function PIXEL.Karts.Database.instance:onConnectionFailed(err)
    print("[PIXEL Karts] WARNING - Database connection failed.\n" .. err)
end

function PIXEL.Karts.GetPlayerData(steamid, callback)
    local q = PIXEL.Karts.Database:prepared_query(string.format([[SELECT data FROM %s WHERE steamid = "%s";]], tblPlyData, steamid))

    function q:onSuccess(data)
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
    end

    function q:onError(err, sql)
        print("[PIXEL Karts] WARNING - Database failed to get player data for '" .. steamid .. "'.\n" .. err)
        callback(false)
    end

    q:start()
end


function PIXEL.Karts.SetPlayerData(steamid, data, callback)
    data = util.TableToJSON(data)
    if not data then callback(false) end
    data = database:escape(data)

    local q = database:prepared_query([[INSERT INTO ? (steamid, data) VALUES (?, ?) ON DUPLICATE KEY UPDATE steamid=?, data=?;]], tblPlyData, steamid, data, steamid, data)

    function q:onSuccess()
        PIXEL.Karts.ClearCachedPlayerData(steamid)
        if callback then callback(true, data) end
    end

    function q:onError(err, sql)
        print("[PIXEL Karts] WARNING - Database failed to get player data for '" .. steamid .. "'.\n" .. err)
        if callback then callback(false, data) end
    end

    q:start()
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