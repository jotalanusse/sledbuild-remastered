include("sv_globals.lua")

-- Shared functionality
include("shared.lua")

-- Network
include("sv_net.lua")

-- Messages
include("sv_messages.lua")

-- Map check
include("sv_map_check.lua")
include("sv_zones.lua")

-- Rules and restrictions
include("sv_players.lua")
include("sv_props.lua")
include("sv_vehicles.lua")
include("sv_tools.lua")
include("sv_disabled.lua")

-- Map control
include("sv_map.lua")
include("sv_rounds.lua")
-- include("sv_start_zone.lua")

-- Send LUA files
AddCSLuaFile("shared.lua")
-- AddCSLuaFile("cl_init.lua")

-- ###################### Initialize ###################### --
timer.Simple(10, function() RND.Starting(RND.STATE.round) end) -- Start the first round to start the cycle
