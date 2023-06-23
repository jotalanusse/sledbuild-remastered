SHRD = {}

DeriveGamemode("sandbox") -- Use sandbox as our default

-- Set the gamemode information
GM.Name    = "SledBuild Remastered v1.0"
GM.Author  = "jotalanusse"
GM.Email   = "jotalanusse@gmail.com"
GM.Website = "jotalanusse.github.io"

-- Round settings
ROUND = {
  -- Different stages a round can be in (same as above)
  STAGES = {
    WAITING = 1,
    STARTING = 2,
    RACING = 3,
  }
}

-- Create the teams
function SHRD.SetTeams()
  team.SetUp(TEAMS.BUILDING, "Building", Color(80, 255, 80, 255)) -- TODO: Find a real color
  team.SetUp(TEAMS.RACING, "Racing", Color(160, 80, 255, 255)) -- TODO: Find a real color
end

-- Initialize
function GM:Initialize()
  SHRD.SetTeams()
end
