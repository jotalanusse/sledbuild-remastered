require("server/modules/effects/types/effects")

-- Configuration
EFFECTS.CONFIG = {}

-- Functions
require("server/modules/effects/functions/disable-effect-spawning")

-- Hooks
require("server/modules/effects/hooks")

-- Initialize: Entry point for the module
function EFFECTS.Initialize() end

EFFECTS.Initialize()
