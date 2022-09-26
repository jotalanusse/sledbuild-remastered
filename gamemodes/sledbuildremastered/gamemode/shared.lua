SHRD = {}

DeriveGamemode("sandbox") -- Use sandbox as our default

-- Set the gamemode information
GM.Name    = "SledBuild Remastered v1.0"
GM.Author  = "jotalanusse"
GM.Email   = "jotalanusse@gmail.com"
GM.Website = "jotalanusse.github.io"

-- Global shared variables
COLORS = {
  RACE = {
    START = Color(0, 200, 0)
  },
  MAIN = Color(150, 0, 255), -- Main gamemode color
  WARNING = Color(230, 225, 0), -- Warning color
  ERROR = Color(230, 0, 0), -- Error color

  TEXT = Color(200, 200, 200), -- TODO: Find the best color for the console text
}

-- Console settings
CONSOLE = {
  PREFIX = "[SBR] ", -- Prefix for all console messages
}

-- Round settings
ROUND = {
  -- Timings to be used by the gamemode
  TIMES = {
    START = 10, -- Round starting and gates are open
    RACE = 90, -- Actual race duration
    WAIT = 5, -- Time after the race finishes before the next race
  },

  -- Different stages a round can be in (same as above)
  STAGES = {
    WAITING = 1,
    STARTING = 2,
    RACING = 3,
  }
}

-- Team enumerations
TEAMS = {
  BUILDING = 1,
  RACING = 2,
  SPECTATING = 3,
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
