ENTITY_NAMES = {
  GATE_NAME = "sbr_gate",
  PUSHER_NAME = "sbr_pusher",
  START_ZONE_NAME = "sbr_start_zone",
}
ROUNDS = {
  START_TIME = 10,
  RACE_TIME = 10,
  WAIT_TIME = 10,
}
PROPS = {
  MAX_RADIUS = 128,
  BLACKLIST = {
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
VEHICLES = {
  WHITELIST = {
    "models/vehicles/prisoner_pod_inner.mdl",
    "models/nova/airboat_seat.mdl"
  },
  DEFAULT_COLLISION_GROUP = COLLISION_GROUP_DEBRIS_TRIGGER -- Same as debris, but hits triggers. Useful for an item that can be shot, but doesn't collide.
}
PLAYERS = {
  DEFAULT_COLLISION_GROUP = COLLISION_GROUP_WEAPON -- Doesn't collide with players and vehicles
}