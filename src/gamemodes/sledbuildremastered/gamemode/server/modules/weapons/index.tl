require("server/modules/weapons/types/weapons")

-- Configuration
WEAPONS.CONFIG = {
  LOADOUTS = {
    DEFAULT = {
      "gmod_tool",
      "weapon_physgun",
      "weapon_physcannon",
      "gmod_camera",
    }, 
    ADMIN = {
      "gmod_tool",
      "weapon_physgun",
      "weapon_physcannon",
      "gmod_camera",
      "weapon_crowbar",
      "weapon_357",
      "weapon_bugbait",
    }
  }
}

-- Functions
require("server/modules/weapons/functions/restrict-weapon-pickup")
require("server/modules/weapons/functions/set-player-loadout")
require("server/modules/weapons/functions/strip-player-loadout")

-- Hooks
require("server/modules/weapons/hooks")

-- Initialize: Entry point for the module
function WEAPONS.Initialize() end
