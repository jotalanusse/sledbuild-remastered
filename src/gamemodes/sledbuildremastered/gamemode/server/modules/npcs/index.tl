require("server/modules/npcs/types/npcs")

-- Configuration
NPCS.CONFIG = {}

-- Functions
require("server/modules/npcs/functions/disable-npc-spawning")

-- Hooks
require("server/modules/npcs/hooks")

-- Initialize: Entry point for the module
function NPCS.Initialize() end

NPCS.Initialize()
