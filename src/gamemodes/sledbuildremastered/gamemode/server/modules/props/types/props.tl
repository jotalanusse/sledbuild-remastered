global record PROPS
  record Config
    record Collisions
      DEFAULT: integer
    end

    MAX_RADIUS: integer
    COLLISIONS: Collisions
    RESTRICTED: {PropModelEnum}
  end

  CONFIG: Config

  Initialize: function()

  -- Functions
  RestrictBigProps: function(ply: PlayerType, model: string, prop: EntityType)
  RestrictProps: function(ply: PlayerType, model: string): boolean
  SetDefaultPropCollisions: function(ply: PlayerType, model: string, prop: EntityType)
end
