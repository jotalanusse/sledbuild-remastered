require("server/modules/props/types/props")

-- Configuration
PROPS.CONFIG = {
  MAX_RADIUS = 128, -- Maximum radius for prop before it's considered too big
  COLLISIONS = {
    DEFAULT = COLLISION_GROUP_DEBRIS_TRIGGER, -- Same as debris, but hits triggers. Useful for an item that can be shot, but doesn't collide
  },
  RESTRICTED = {
    "models/props_phx/oildrum001_explosive.mdl",
    "models/props_junk/gascan001a.mdl",
    "models/props_junk/propane_tank001a.mdl",
    "models/props_c17/oildrum001_explosive.mdl",
    "models/props_phx/misc/flakshell_big.mdl",
    "models/props_phx/ww2bomb.mdl",
    "models/props_phx/amraam.mdl",
    "models/props_phx/mk-82.mdl",
    "models/props_phx/ball.mdl",
    "models/props_phx/cannonball.mdl",
    "models/props_phx/torpedo.mdl"
  }
}

-- Functions
-- require("server/modules/sweps/functions/disable-swep-spawning")

-- Hooks
require("server/modules/props/hooks")

-- Initialize: Entry point for the module
function PROPS.Initialize() end

PROPS.Initialize()
