global record MAP
  record Config
    record Entities
      record Names
        GATE: string
        PUSHER: string
        SPAWN_1: string
        SPAWN_2: string
        SPAWN_3: string
        SPAWN: string
        START_ZONE_CLASS: string
        FINISH_ZONE_CLASS: string
      end

      NAMES: Names
    end

    ENTITIES: Entities
  end

  CONFIG: Config

  Initialize: function()

  -- Functions
  ConfigureMap: function()
  CountEntitiesByClass: function(class: string): integer
  CountEntitiesByName: function(name: string): integer
  JitterEntity: function(entity: EntityType)
end
