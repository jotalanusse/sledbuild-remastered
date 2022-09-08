DeriveGamemode("sandbox") -- Use sanbox as our default

GM.Name    = "SledBuild Remastered 1.0"
GM.Author  = "jotalanusse"
GM.Email   = "jotalanusse@gmail.com"
GM.Website = "jotalanusse.github.io"

-- Global variables
ENTITY_NAMES = {
  GATE_NAME = "sbr_gate",
  PUSHER_NAME = "sbr_pusher",
}

MAX_PROP_RADIUS = 128
CONSOLE_PREFIX = "[SledBuild Remastered] "

-- Team enumerations
TEAM_BUILDING   = 1
TEAM_RACING     = 2
TEAM_SPECTATING = 3

-- Create the new teams
local function SetTeams()
  team.SetUp(TEAM_BUILDING, "Building", Color(80, 255, 80, 255)) -- TODO: Find a real color
  team.SetUp(TEAM_RACING, "Racing", Color(160, 80, 255, 255)) -- TODO: Find a real color
end

-- Initialize
function GM:Initialize()
  print(CONSOLE_PREFIX .. "SledBuild Remastered initialized!")

  SetTeams()
end
