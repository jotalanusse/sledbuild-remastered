require("server/modules/vehicles/types/vehicles")

-- Configuration
VEHICLES.CONFIG = {
  DEFAULT_SEAT_CLASS = "prop_vehicle_prisoner_pod",
  ALLOWED_VEHICLES = {
    "models/vehicles/prisoner_pod_inner.mdl",
    "models/nova/airboat_seat.mdl",
  },
  COLLISIONS = {
    DEFAULT = COLLISION_GROUP_DEBRIS_TRIGGER,-- Same as debris, but hits triggers. Useful for an item that can be shot, but doesn't collide.
  },
  MATERIALS = {
    BUILDING = "dirt",
    RACING = "gmod_ice",
  }
}

-- Functions
require("server/modules/vehicles/functions/get-vehicle-creator")
require("server/modules/vehicles/functions/is-racing-seat")
require("server/modules/vehicles/functions/is-sled")
require("server/modules/vehicles/functions/restrict-vehicles")
require("server/modules/vehicles/functions/set-collision")
require("server/modules/vehicles/functions/set-creator")
require("server/modules/vehicles/functions/set-vehicle-material")
require("server/modules/vehicles/functions/stop-vehicle")
require("server/modules/vehicles/functions/teleport-vehicle")
require("server/modules/vehicles/functions/vehicle-has-player")

-- Hooks
require("server/modules/vehicles/hooks")

-- Initialize: Entry point for the module
function VEHICLES.Initialize() end
