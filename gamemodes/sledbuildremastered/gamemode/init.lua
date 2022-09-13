-- include("sv_globals.lua") -- Diasble for now, each module has their own globals

-- Shared functionality
include("shared.lua")

-- Network
include("sv_net.lua")

-- Messages
include("sv_messages.lua")

-- Rules and restrictions
include("sv_players.lua")
include("sv_props.lua")
include("sv_vehicles.lua")
include("sv_tools.lua")
include("sv_disabled.lua")

-- Map control
include("sv_zones.lua")
include("sv_map.lua")
include("sv_rounds.lua")

-- Map check
include("sv_map_check.lua")

-- Send LUA files to client
AddCSLuaFile("shared.lua")

-- TODO: Organize files
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("cl_net.lua.lua")
AddCSLuaFile("cl_ui.lua.lua")
AddCSLuaFile("cl_menu.lua.lua")

-- ###################### Initialize ###################### --
timer.Simple(10, function() RND.Starting(RND.STATE.round) end) -- Start the first round to start the cycle
