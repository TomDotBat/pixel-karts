---@TODO: USE RELATIONAL DATABASES.


require("mysqloo")

local tblPlyData = "pixel_karts_player_data"

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

    function q:onError(err, sql)
        print("[PIXEL Karts] WARNING - Database table creation failed.\n" .. err)
    end

    q:start()
end

--[[ TODO:
local function query(query, onSuccess, onError, ...)
    local query1 = self.instance:prepare(string.format(query, args))

    function query1:onSuccess(data)
        if onSuccess then
            onSuccess(data)
        end
    end

    function query1:onError(err)
        if onError then
            onError(err)
        end

        print("SQL Error: " .. err .. "\nOn query: " .. query)
    end

    for i, v in ipairs({...}) do
        local argType = string.ToTable(type(v))
        argType[1] = string.upper(argType[1])
        argType = table.concat(argType)
        query1["set" .. argType](query1, i, v)
    end

    query1:start()
end

]]--


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

    function q:onError(err, sql)
        print("[PIXEL Karts] WARNING - Database failed to get player data for '" .. steamid .. "'.\n" .. err)
        callback(false)
    end

    q:start()
end

function PIXEL.Karts.SetPlayerData(steamid, data, callback)
    data = util.TableToJSON(data)
    if not data then callback(false) end

    -- TODO USE PREPARED.
    data = database:escape(data)

    local q = database:query(string.format([[INSERT INTO %s(steamid, data) VALUES ("%s", "%s") ON DUPLICATE KEY UPDATE steamid="%s", data="%s";]], tblPlyData, steamid, data, steamid, data))

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