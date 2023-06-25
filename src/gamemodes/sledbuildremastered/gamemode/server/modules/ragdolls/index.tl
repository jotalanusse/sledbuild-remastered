require("server/modules/ragdolls/types/ragdolls")

-- Configuration
RAGDOLLS.CONFIG = {}

-- Functions
require("server/modules/ragdolls/functions/disable-ragdoll-spawning")

-- Hooks
require("server/modules/ragdolls/hooks")

-- Initialize: Entry point for the module
function RAGDOLLS.Initialize() end

RAGDOLLS.Initialize()
