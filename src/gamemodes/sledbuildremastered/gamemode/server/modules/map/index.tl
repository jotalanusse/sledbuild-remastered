require("server/modules/map/types/map")

-- Configuration
MAP.CONFIG = {
  ENTITIES = {
    NAMES = {
      GATE = "sbr_gate",
      PUSHER = "sbr_pusher",
      SPAWN_1 = "sbr_spawn_1",
      SPAWN_2 = "sbr_spawn_2",
      SPAWN_3 = "sbr_spawn_3",
      SPAWN = "sbr_spawn",
      START_ZONE_CLASS = "sbr_start_zone",
      FINISH_ZONE_CLASS = "sbr_finish_zone",
    }
  }
}

-- Functions
require("server/modules/map/functions/configure-map")
require("server/modules/map/functions/jitter-entity")

-- Hooks
require("server/modules/map/hooks")

-- Initialize: Entry point for the module
function MAP.Initialize() end

MAP.Initialize()
