DeriveGamemode("sandbox") -- Use sanbox as our default

GM.Name    = "SledBuild Remastered 1.0"
GM.Author  = "jotalanusse"
GM.Email   = "jotalanusse@gmail.com"
GM.Website = "jotalanusse.github.io"

-- Global shared variables
CONSOLE = {
  PREFIX = "[SBR] ",
  COLORS = {
    PREFIX = Color(150, 0, 255),
    WARNING = Color(230, 225, 0),
    ERROR = Color(230, 0, 0),
    TEXT = Color(220, 220, 220) -- TODO: Find the best color
  }
}
ROUND_STAGES = {
  WAITING = 1,
  STARTING = 2,
  RACING = 3,
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
  print(CONSOLE.PREFIX .. "SledBuild Remastered initialized!")

  SetTeams()
end
