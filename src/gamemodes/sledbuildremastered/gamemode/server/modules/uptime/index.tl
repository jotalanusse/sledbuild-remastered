require("server/modules/uptime/types/uptime")

-- Configuration
UPTIME.CONFIG = {
  WARNINGS = {
    INITIAL = 6 * 60 * 60, -- 6 hours
    PERIODIC = 10 * 60 -- 10 minutes
  }
}

-- Functions
require("server/modules/uptime/functions/broadcast-warning-message")
require("server/modules/uptime/functions/first-uptime-warning")

-- Hooks
require("server/modules/uptime/hooks")

-- Initialize: Entry point for the module
function UPTIME.Initialize()
  timer.Create("SBR:FirstUptimeWarning", UPTIME.CONFIG.WARNINGS.INITIAL, 1, UPTIME.FirstUptimeWarning)
end

UPTIME.Initialize()
