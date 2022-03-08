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

--[[
    Database configuration for PIXEL Karts.
]]

PIXEL.Karts.Config.SQLite = true --Should SQLite be used over MySQL?

--[[
    If you have the above variable set to true you can ignore anything below here.

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