require("server/modules/map-check/types/map-check")

-- Configuration
MAP_CHECK.CONFIG = {}

-- State
MAP_CHECK.STATE = {
  IS_MAP_COMPLETE = false,
  WAS_MAP_CHECKED = false,
}

-- Functions
-- require("server/modules/effects/functions/disable-effect-spawning")

-- Hooks
require("server/modules/map-check/hooks")

-- Initialize: Entry point for the module
function MAP_CHECK.Initialize() end
