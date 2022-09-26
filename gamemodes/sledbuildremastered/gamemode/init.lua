-- Shared functionality
include("shared.lua")

-- Network
include("server/sv_net.lua")

-- Formatting
include("shared/sh_format.lua")

-- Map
include("server/sv_zones.lua")
include("server/sv_map.lua")
include("server/sv_map_check.lua")

-- general modules
include("server/sv_cvars.lua")
include("server/sv_players.lua")
include("server/sv_props.lua")
include("server/sv_vehicles.lua")
include("server/sv_tools.lua")
include("server/sv_effects.lua")
include("server/sv_npcs.lua")
include("server/sv_ragdolls.lua")
include("server/sv_sweps.lua")

include("server/sv_speed_tracker.lua")

-- Round control
include("server/sv_rounds.lua")

-- Send LUA files to client
AddCSLuaFile("shared.lua")
AddCSLuaFile("shared/sh_format.lua")

AddCSLuaFile("client/cl_init.lua")
AddCSLuaFile("client/cl_net.lua")

AddCSLuaFile("client/cl_ui.lua")
AddCSLuaFile("client/cl_helpers.lua")
AddCSLuaFile("client/cl_fonts.lua")
AddCSLuaFile("client/cl_hud.lua")
AddCSLuaFile("client/cl_menu.lua")
AddCSLuaFile("client/cl_scoreboard.lua")
