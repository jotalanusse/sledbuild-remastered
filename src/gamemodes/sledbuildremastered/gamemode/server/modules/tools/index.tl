require("server/modules/tools/types/tools")

-- Configuration
TOOLS.CONFIG = {
  RESTRICTED = {
    "balloon",
    "ballsocket_adv",
    "button",
    "dynamite",
    "elastic",
    "emitter",
    "eyeposer",
    "faceposer",
    "finger",
    "hoverball",
    "hydraulic",
    "ignite",
    "inflator",
    "lamp",
    "light",
    "magnetise",
    "muscle",
    "nail",
    "paint",
    "physprop",
    "pulley",
    "rope",
    "slider",
    "spawner",
    "statue",
    "thruster",
    "turret",
    "winch",
  }
}

-- Functions
require("server/modules/tools/functions/limit-physgun")
require("server/modules/tools/functions/limit-toolgun")
require("server/modules/tools/functions/restrict-tools")

-- Hooks
require("server/modules/tools/hooks")

-- Initialize: Entry point for the module
function TOOLS.Initialize() end
