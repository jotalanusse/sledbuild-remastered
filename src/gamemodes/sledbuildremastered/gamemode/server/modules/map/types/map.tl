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
  CloseGates: function()
  ConfigureMap: function()
  CountEntitiesByClass: function(class: string): integer
  CountEntitiesByName: function(name: string): integer
  DisablePushers: function()
  EnablePushers: function()
  JitterEntity: function(entity: EntityType)
  OpenGates: function()
  SelectRandomSpawn: function(): EntityType
  SelectSpecificSpawn: function(name: string): EntityType
end
