require("server/modules/map/enums/map-entity-name")

global record MAP
  record Config
    record Entities
      record Names
        GATE: MapEntityName
        PUSHER: MapEntityName
        SPAWN_1: MapEntityName
        SPAWN_2: MapEntityName
        SPAWN_3: MapEntityName
        SPAWN: MapEntityName
        START_ZONE_CLASS: MapEntityName
        FINISH_ZONE_CLASS: MapEntityName
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
