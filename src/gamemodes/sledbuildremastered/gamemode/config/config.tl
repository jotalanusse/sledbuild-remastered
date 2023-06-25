local COLORS = require("config/configs/colors")
local CONSOLE = require("config/configs/console")
local DISCORD = require("config/configs/discord")
local TEAMS = require("config/configs/teams")

-- TODO: Check why when this is <const> the compiler throws an error
global CONFIG = {
  COLORS = COLORS, 
  CONSOLE = CONSOLE,
  DISCORD = DISCORD,
  TEAMS = TEAMS
}
