DeriveGamemode("sandbox") -- Use sanbox as our default

GM.Name    = "SledBuild Remastered 1.0"
GM.Author  = "jotalanusse"
GM.Email   = "jotalanusse@gmail.com"
GM.Website = "jotalanusse.github.io"

-- TODO: Should these variables be only available to the server?
-- Global shared variables
CONSOLE_PREFIX = "[SBR] "
ROUND_STAGES = {
  WAITING = 1,
  STARTING = 2,
  RACING = 3,
  FINISHED = 4, -- TODO: Do we need this?
}

-- Team enumerations
TEAMS = {
  BUILDING = 1,
  RACING = 2,
  SPECTATING = 3,
}

-- Create the new teams
local function SetTeams()
  team.SetUp(TEAMS.BUILDING, "Building", Color(80, 255, 80, 255)) -- TODO: Find a real color
  team.SetUp(TEAMS.RACING, "Racing", Color(160, 80, 255, 255)) -- TODO: Find a real color
end

-- Initialize
function GM:Initialize()
  print(CONSOLE_PREFIX .. "SledBuild Remastered initialized!")

  SetTeams()
end
