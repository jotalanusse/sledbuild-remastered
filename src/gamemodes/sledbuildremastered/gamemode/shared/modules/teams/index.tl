require("shared/modules/teams/types/teams")

-- Configuration
TEAMS.CONFIG = {
  TEAMS ={
    BUILDERS = {
      index = 1,
      name = "Builders",
      color = Color(255, 255, 255), -- TODO: Find a real color
    },
    RACERS = {
      index = 2,
      name = "Racers",
      color = Color(255, 255, 255), -- TODO: Find a real color
    },
    SPECTATORS = {
      index = 3,
      name = "Spectators",
      color = Color(255, 255, 255), -- TODO: Find a real color
    },
  }
}

-- Functions
require("shared/modules/teams/functions/setup-teams")

-- Hooks
require("shared/modules/teams/hooks")

-- Initialize: Entry point for the module
function TEAMS.Initialize()
  TEAMS.SetupTeams()
end

TEAMS.Initialize()
