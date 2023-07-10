-- Shared
require("shared")

-- Network
require("server/modules/net/index")

-- General
-- require("server/modules/cvars/index")
require("server/modules/effects/index")
require("server/modules/map/index")
require("server/modules/npcs/index")
require("server/modules/props/index")
require("server/modules/ragdolls/index")
require("server/modules/sweps/index")
require("server/modules/tools/index")
require("server/modules/uptime/index")
-- require("server/modules/vehicles/index")
require("server/modules/weapons/index")

-- -- Map
-- include("server/sv_zones.lua")
-- include("server/sv_map.lua")
-- include("server/sv_map_check.lua")
-- require("server/modules/uptime/index")

-- -- general modules
-- include("server/sv_cvars.lua")
-- include("server/sv_commands.lua")
-- include("server/sv_props.lua")
-- include("server/sv_vehicles.lua")
-- include("server/sv_tools.lua")
-- include("server/sv_effects.lua")
-- include("server/sv_npcs.lua")
-- include("server/sv_ragdolls.lua")
-- include("server/sv_sweps.lua")
-- include("server/sv_weapons.lua")
-- include("server/sv_players.lua")

-- include("server/sv_speed_tracker.lua")

-- -- Round control
-- include("server/sv_rounds.lua")

-- -- Send LUA files to client
-- AddCSLuaFile("shared.lua")
-- AddCSLuaFile("shared/sh_format.lua")

-- AddCSLuaFile("cl_init.lua")
-- AddCSLuaFile("client/cl_net.lua")

-- AddCSLuaFile("client/cl_ui.lua")
-- AddCSLuaFile("client/cl_helpers.lua")
-- AddCSLuaFile("client/cl_fonts.lua")
-- AddCSLuaFile("client/cl_hud.lua")
-- AddCSLuaFile("client/cl_menu.lua")
-- AddCSLuaFile("client/cl_scoreboard.lua")
