require("server/modules/cvars/types/cvars")

-- Configuration
CVARS.CONFIG = {
  NAMES = {
    RACE_TIME = "sbr_race_time",
    START_TIME = "sbr_start_time",
    WAIT_TIME = "sbr_wait_time",
  }
}

-- Functions
-- require("server/modules/effects/functions/disable-effect-spawning")

-- Hooks
require("server/modules/cvars/hooks")

-- Initialize: Entry point for the module
function CVARS.Initialize() end
