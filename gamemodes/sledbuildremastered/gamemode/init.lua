-- Run LUA files
include('shared.lua')

-- Rules and restrictions
include('sv_players.lua')
include('sv_props.lua')
include('sv_vehicles.lua')
include('sv_tools.lua')
include('sv_disabled.lua')

-- Map control
include("sv_round.lua")
include('sv_map.lua')
-- include('sv_start_zone.lua')

-- Send LUA files
AddCSLuaFile("shared.lua")
-- AddCSLuaFile("cl_init.lua")

-- Global server variables
ENTITY_NAMES = {
  GATE_NAME = "sbr_gate",
  PUSHER_NAME = "sbr_pusher",
  START_ZONE_NAME = "sbr_start_zone",
}
MAX_PROP_RADIUS = 128
