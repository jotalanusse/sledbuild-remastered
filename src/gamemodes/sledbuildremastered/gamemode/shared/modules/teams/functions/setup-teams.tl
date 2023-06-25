require("shared/modules/teams/types/teams")

-- SetupTeams: Creates the teams needed for the gamemode
function TEAMS.SetupTeams()
  local teams = TEAMS.CONFIG.TEAMS

  for _, v in pairs(teams) do
    team.SetUp(v.index, v.name, v.color)
  end
end
