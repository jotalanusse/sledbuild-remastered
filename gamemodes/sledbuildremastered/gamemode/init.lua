-- Shared functionality
include("shared.lua")

-- Network
include("sv_net.lua")

-- Formatting
include("sh_format.lua")

-- Map
include("sv_zones.lua")
include("sv_map.lua")
include("sv_map_check.lua")

-- general modules
include("sv_players.lua")
include("sv_props.lua")
include("sv_vehicles.lua")
include("sv_tools.lua")
include("sv_speed_tracker.lua")
include("sv_disabled.lua")

-- Round control
include("sv_rounds.lua")

-- Send LUA files to client
AddCSLuaFile("shared.lua")
AddCSLuaFile("sh_format.lua")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("cl_net.lua")

AddCSLuaFile("cl_ui.lua")
AddCSLuaFile("cl_helpers.lua")
AddCSLuaFile("cl_fonts.lua")
AddCSLuaFile("cl_hud.lua")
AddCSLuaFile("cl_menu.lua")
AddCSLuaFile("cl_scoreboard.lua")
