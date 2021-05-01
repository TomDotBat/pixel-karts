
local tblPlyData = "pixel_karts_player_data"

if PIXEL.Karts.Config.SQLite then
    PIXEL.Karts.Database = {}

    function PIXEL.Karts.Database.Init()
        sql.Query(string.format([[CREATE TABLE IF NOT EXISTS %s (steamid VARCHAR(17) NOT NULL, data TEXT NOT NULL, CONSTRAINT %s_pk PRIMARY KEY (steamid));]], tblPlyData, tblPlyData))
    end

    function PIXEL.Karts.GetPlayerData(steamid, callback)
        local data = sql.Query(string.format([[SELECT data FROM %s WHERE steamid = "%s";]], tblPlyData, steamid))

        local function onSuccess()
            data = data or {}
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

        local function onError(err)
            print("[PIXEL Karts] WARNING - Database failed to get player data for '" .. steamid .. "'.\n" .. err)
            callback(false)
        end

        if data == false then
            onError("SQLite ERROR")
            return
        else
            onSuccess(data)
        end
    end

    function PIXEL.Karts.SetPlayerData(steamid, data, callback)
        data = util.TableToJSON(data)
        if not data then callback(false) end

        data = sql.SQLStr(data)
        local q = sql.Query(string.format([[INSERT INTO %s(steamid, data) VALUES ("%s", %s) ON CONFLICT(steamid) DO UPDATE SET steamid="%s", data=%s;]], tblPlyData, steamid, data, steamid, data))

        local function onSuccess()
            PIXEL.Karts.ClearCachedPlayerData(steamid)
            if callback then callback(true, data) end
        end

        local function onError(err, query)
            print("[PIXEL Karts] WARNING - Database failed to set player data for '" .. steamid .. "'.\n" .. err)
            if callback then callback(false, data) end
        end

        if q == false then
            onError(sql.LastError())
            return
        else
            onSuccess(data)
        end
    end

    hook.Add("InitPostEntity", "PIXEL.Karts.InitialiseDatabase", function()
        PIXEL.Karts.Database.Init()
    end)

    return
end


require("mysqloo")

local database = PIXEL.Karts.Database
if not database then
    local credentials = PIXEL.Karts.Config.DatabaseCredentials
    PIXEL.Karts.Database = mysqloo.connect(
        credentials.Host,
        credentials.Username,
        credentials.Password,
        credentials.Database,
        credentials.Port
    )

    database = PIXEL.Karts.Database
    database:setMultiStatements(true)
    database:setAutoReconnect(true)

    hook.Add("InitPostEntity", "PIXEL.Karts.InitialiseDatabase", function()
        database:connect()
    end)
end

function database:onConnected()
    local q = self:query(string.format([[CREATE TABLE IF NOT EXISTS %s (steamid VARCHAR(17) NOT NULL, data TEXT NOT NULL, CONSTRAINT %s_pk PRIMARY KEY (steamid));]], tblPlyData, tblPlyData))

    function q:onError(err, query)
        print("[PIXEL Karts] WARNING - Database table creation failed.\n" .. err)
    end

    q:start()
end


function database:onConnectionFailed(err)
    print("[PIXEL Karts] WARNING - Database connection failed.\n" .. err)
end

function PIXEL.Karts.GetPlayerData(steamid, callback)
    local q = database:query(string.format([[SELECT data FROM %s WHERE steamid = "%s";]], tblPlyData, steamid))

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

    function q:onError(err, query)
        print("[PIXEL Karts] WARNING - Database failed to get player data for '" .. steamid .. "'.\n" .. err)
        callback(false)
    end

    q:start()
end

function PIXEL.Karts.SetPlayerData(steamid, data, callback)
    data = util.TableToJSON(data)
    if not data then callback(false) end

    data = database:escape(data)

    local q = database:query(string.format([[INSERT INTO %s(steamid, data) VALUES ("%s", "%s") ON DUPLICATE KEY UPDATE steamid="%s", data="%s";]], tblPlyData, steamid, data, steamid, data))

    function q:onSuccess()
        PIXEL.Karts.ClearCachedPlayerData(steamid)
        if callback then callback(true, data) end
    end

    function q:onError(err, query)
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