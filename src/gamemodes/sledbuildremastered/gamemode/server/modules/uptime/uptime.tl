require("types/uptime")

global UPTIME: Uptime = {
  CONFIG = {
    WARNINGS = {
      INITIAL = 6 * 60 * 60, -- 6 hours
      PERIODIC = 10 * 60 -- 10 minutes
    }
  }
}

require("functions/broadcast-warning-message")
require("functions/first-uptime-warning")
require("functions/initialize")

require("hooks")


UPTIME.Initialize()