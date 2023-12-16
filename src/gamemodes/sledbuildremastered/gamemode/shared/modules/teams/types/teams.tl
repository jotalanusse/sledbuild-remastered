global record TEAMS
  record Config
    record Team
      index: integer
      name: string
      color: ColorType
      isJoinable: boolean
    end

    TEAMS: {string:Team}
  end

  CONFIG: Config

  Initialize: function()

  -- Functions
  SetupTeams: function()
end
