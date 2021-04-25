
--[[
    If you don't have MYSQLOO please set this to true and ignore second part of
    this file.

]]--
PIXEL.Karts.Config.Sqlite = true

--[[
    Database configuration for PIXEL Karts.

    Populate this configuration table with your MySQL/MariaDB credentials.
    Making a seperate database for PIXEL Karts is recommended but not required.
    This requires the MySQLOO module to be installed on your server, get the
    latest version here: https://github.com/FredyH/MySQLOO
]]

PIXEL.Karts.Config.DatabaseCredentials = {
    Host = "localhost", --The address of your database server, use "127.0.0.1" instead of "localhost".
    Post = 3306, --The port your database is running on, usually 3306.
    Database = "db", --The database you want PIXEL Karts to use. Make sure it exists before use.
    Username = "user",
    Password = "pass"
}