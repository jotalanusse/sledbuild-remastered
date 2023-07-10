global record CVARS
  record Config
    record Names
      RACE_TIME: string
      START_TIME: string
      WAIT_TIME: string
    end

    NAMES: Names
  end

  CONFIG: Config

  Initialize: function()

  -- Functions
  -- DisableEffectSpawning: function(ply: PlayerType): boolean
end
