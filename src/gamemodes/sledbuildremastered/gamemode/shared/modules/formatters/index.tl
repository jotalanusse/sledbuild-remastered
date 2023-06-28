require("shared/modules/formatters/types/formatters")

-- Configuration
FORMATTERS.CONFIG = {}

-- Functions
require("shared/modules/formatters/functions/format-hud-speed")
require("shared/modules/formatters/functions/format-hud-timer")
require("shared/modules/formatters/functions/format-mph")
require("shared/modules/formatters/functions/format-race-time")
require("shared/modules/formatters/functions/format-time")

-- Hooks
require("shared/modules/formatters/hooks")

-- Initialize: Entry point for the module
function FORMATTERS.Initialize() end
