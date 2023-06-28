-- Configuration
require("config/config")

-- Modules
require("shared/modules/formatters/index")
require("shared/modules/helpers/index")
require("shared/modules/teams/index")

-- Derive from sandbox
DeriveGamemode("sandbox")

-- Set the gamemode information
GM.Name    = "SledBuild Remastered v1.0"
GM.Author  = "jotalanusse"
GM.Email   = "jotalanusse@gmail.com"
GM.Website = "jotalanusse.github.io"

-- Initialize
function GM.Initialize()
  TEAMS.Initialize()
end
