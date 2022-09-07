-- Help stuff --
-- Scoreboard & Timer & General Networking fixes by Meidor --
local HelpTable = {}

function AddHelp(cmd, info)
	local newentry = {}
	newentry[1] = cmd
	newentry[2] = info
	table.insert(HelpTable, newentry)
end

function SendHelp(ply)
	if (ply and #HelpTable > 0) then
		local rp = RecipientFilter()
		rp:AddPlayer(ply)
		for k, v in pairs(HelpTable) do
			umsg.Start("addhelp", rp)
			umsg.String(v[1])
			umsg.String(v[2])
			umsg.End()
		end
	end
end

-- end Help stuff --

-- Sledbuild server file
include('shared.lua')
include('sv_statssaving.lua')
include('sv_chatcmd.lua')

-- Send resources to client
resource.AddFile("materials/gui/sledbuild/timer_bg.vtf")
resource.AddFile("materials/gui/sledbuild/timer_bg.vmt")
resource.AddFile("materials/gui/sledbuild/timer_ro.vtf")
resource.AddFile("materials/gui/sledbuild/timer_ro.vmt")
resource.AddFile("materials/gui/sledbuild/timer_sh.vtf")
resource.AddFile("materials/gui/sledbuild/timer_sh.vmt")
resource.AddFile("materials/gui/sledbuild/timer_bg2.vtf")
resource.AddFile("materials/gui/sledbuild/timer_bg2.vmt")
resource.AddFile("materials/gui/sledbuild/slblogo.vtf")
resource.AddFile("materials/gui/sledbuild/slblogo.vmt")

resource.AddFile("sound/sledbuild/race/slb_win.mp3")
resource.AddFile("sound/sledbuild/race/slb_lose.mp3")
resource.AddFile("sound/sledbuild/taunts/slb_banana.mp3")
resource.AddFile("sound/sledbuild/taunts/slb_freestyler.mp3")
resource.AddFile("sound/sledbuild/taunts/slb_leeroy.mp3")
resource.AddFile("sound/sledbuild/taunts/slb_speedboy.mp3")

AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("cl_scoreboard.lua")
AddCSLuaFile("cl_helpscreen.lua")
AddCSLuaFile("cl_menusys.lua")
AddCSLuaFile("cl_mbuttons.lua")

_G["FirstPosition"] = "N/A"
_G["SecondPosition"] = "N/A"
_G["ThirdPosition"] = "N/A"
_G["HowMany"] = 0
_G["lastRace"] = 0
util.AddNetworkString("RaceVariables")
local racetimertime = 90

function HewkPlayerInitialSpawn(pl)

	util.PrecacheSound("vo/npc/barney/ba_yell.wav")
	util.PrecacheSound("vo/npc/barney/ba_damnit.wav")
	util.PrecacheSound("ambient/alarms/warningbell1.wav")

	-- Disable Bloom Rape
	pl:ConCommand("pp_bloom 0")

	pl:SetCollisionGroup(COLLISION_GROUP_WEAPON)

	pl:SelectWeapon("weapon_physgun")

	-- Notify of new racer
	for k, v in pairs(player.GetAll()) do
		v:PrintMessage(HUD_PRINTTALK, "[Sledbuild] " .. pl:Nick() .. " finished joining the server.")
	end

	PST_PlayerInitialSpawn(pl)
end

hook.Add("PlayerInitialSpawn", "HewkPlayerInitialSpawn", HewkPlayerInitialSpawn)

-- ---------------------------------------------------------------------------

function HewkPlayerSpawn(pl)

	-- Call item loadout function
	hook.Call("PlayerLoadout", GAMEMODE, pl)

	-- Set player model
	hook.Call("PlayerSetModel", GAMEMODE, pl)

	-- Is Racing
	pl:SetNetworkedBool("IsRacing", false)
	pl:SetNetworkedBool("OnTrack", false)

	pl:SetCollisionGroup(COLLISION_GROUP_WEAPON)

	pl:SelectWeapon("weapon_physgun")

	-- Set team building
	pl:SetTeam(TEAM_BUILDING)

	SendHelp(pl)

	net.Start("RaceVariables")
	net.WriteFloat(_G["HowMany"])
	net.WriteFloat(_G["lastRace"])
	net.Send(pl)

end

hook.Add("PlayerSpawn", "HewkPlayerSpawn", HewkPlayerSpawn)


-- ---------------------------------------------------------------------------

function GM:PlayerLoadout(pl)
	if pl:IsAdmin() then
		pl:GiveAmmo(24, "357", true)
		pl:Give("weapon_crowbar")
		pl:Give("weapon_357")
	end
	pl:Give("gmod_tool")
	pl:Give("gmod_camera")
	pl:Give("weapon_physgun")
	pl:Give("weapon_physcannon")
end

-- ---------------------------------------------------------------------------

function GM:ShowHelp(ply)
end

-- ---------------------------------------------------------------------------

function NewRound()
	local Many = _G["HowMany"]
	Many = Many + 1
	_G["HowMany"] = Many
	_G["lastRace"] = CurTime()
	net.Start("RaceVariables")
	net.WriteFloat(_G["HowMany"])
	net.WriteFloat(_G["lastRace"])
	net.WriteString(_G['FirstPosition'])
	net.WriteString(_G['SecondPosition'])
	net.WriteString(_G['ThirdPosition'])
	net.Broadcast()
	_G['FirstPosition'] = 'N/A'
	_G['SecondPosition'] = 'N/A'
	_G['ThirdPosition'] = 'N/A'

	for k, v in pairs(ents.FindByClass("player")) do
		if (v:Team() == TEAM_RACING and not v:InVehicle()) then
			v:Kill()
		end
		if (v:InVehicle() and v:GetNWBool("OnTrack") == true) then
			local Vehicle = v:GetVehicle()
			local VehiclePosition = Vehicle:GetPos()
			local Entities, Constraints = duplicator.Copy(Vehicle)
			local Destination = ents.FindByName("Destination_Lose1")[1]:GetPos() -- Default spawn.

			if game.GetMap() == "slb_snowsled_v3" then
				Destination = ents.FindByName("Destination_Lose" .. math.random(1, 3))[math.random(1, 2)]:GetPos()
			else
				Destination = ents.FindByName("Destination_Lose" .. math.random(1, 6))[1]:GetPos()
			end

			for i, tab in pairs(Entities) do
				local Ent = tab.Entity
				if Ent and Ent:IsValid() then
					Ent:GetPhysicsObject():SetVelocityInstantaneous(Vector(0, 0, 0))
					Ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER) -- ############## Reaper, remember this.
					Ent:SetPos(Destination + (Ent:GetPos() - VehiclePosition))
					Ent:GetPhysicsObject():SetVelocityInstantaneous(Vector(0, 0, 0))
				end
			end
			v:AddDeaths(1)
			local losername = v:Nick()
			for k, v in pairs(player.GetAll()) do
				v:PrintMessage(HUD_PRINTTALK, "[Lost] [" .. losername .. "]")
			end
		end
	end


	-- Reset the race teleport trigger
	for k, v in pairs(ents.FindByClass("lng_teleport")) do
		v:Reset()
	end

	-- Disable the blocker
	for k, v in pairs(ents.FindByName("Blocker")) do
		v:Fire("Disable", "", "0")
	end

	-- Enable the pusher
	for k, v in pairs(ents.FindByName("Pusher")) do
		v:Fire("Enable", "", "0")
	end

	-- Notify of new race
	for k, v in pairs(player.GetAll()) do
		v:PrintMessage(HUD_PRINTTALK, "Race [#" .. _G["HowMany"] .. "] Started.")
	end

	-- Remove player colours
	for k, v in pairs(player.GetAll()) do
		v:SetColor(Color(255, 255, 255, 255))
	end

	timer.Simple(10, RoundClean) -- (was 15)

end

timer.Create("NewRoundTimer", racetimertime, 0, NewRound) -- <--
-- ---------------------------------------------------------------------------

function RoundClean()
	-- Disable the pusher
	for k, v in pairs(ents.FindByName("Pusher")) do
		v:Fire("Disable", "", "0")
	end

	-- Enable the blocker
	for k, v in pairs(ents.FindByName("Blocker")) do
		v:Fire("Enable", "", "0")
	end
end

-- ---------------------------------------------------------------------------

function LimitVehicles(pl, mdl)
	if mdl ~= "models/vehicles/prisoner_pod_inner.mdl" and mdl ~= "models/nova/airboat_seat.mdl" then
		pl:PrintMessage(HUD_PRINTTALK, "[Sledbuild] Only a Pod or Airboat Seat can be used.")
		return false -- Has to be last line
	end
end

hook.Add("PlayerSpawnVehicle", "LimitVehicles", LimitVehicles)

-- ---------------------------------------------------------------------------

function LimitTools(ply, trace, mode)
	if not ply:IsAdmin() and (trace.Entity:GetClass() == "func_brush" or trace.Entity:GetClass() == "player") then
		ply:PrintMessage(HUD_PRINTTALK, "[Sledbuild] This entity cannot be toolgunned.")
		return false
	end
end

hook.Add("CanTool", "LimitTools", LimitTools)

-- ---------------------------------------------------------------------------

function LimitPhysgun(ply, ent)
	if ent:GetClass() == "func_brush" then
		return false
	elseif (ent:IsPlayer()) then
		if (ply:IsAdmin()) then
			return true
		else
			return false
		end
	end
end

hook.Add("PhysgunPickup", "LimitPhysgun", LimitPhysgun)

-- ---------------------------------------------------------------------------

function GM:DoPlayerDeath(ply, attacker, dmginfo)
	ply:CreateRagdoll()
end

-- ---------------------------------------------------------------------------

function AdminNoclip(player, bool)
	if player:IsAdmin() then
		return true
	end
	player:PrintMessage(HUD_PRINTTALK, "[Sledbuild] Only admins may use noclip.")
	return false
end

hook.Add("PlayerNoClip", "AdminNoclip", AdminNoclip)

-- ---------------------------------------------------------------------------

function LimitToolGuns(ply, trace, mode)
	local slbrestools = { "balloon", "ballsocket_adv", "button", "dynamite", "elastic", "emitter", "eyeposer", "faceposer",
		"finger", "hoverball", "hydraulic", "ignite", "inflator", "lamp", "light", "magnetise", "muscle", "nail", "paint",
		"physprop", "pulley", "rope", "slider", "spawner", "statue", "thruster", "turret", "winch" }
	for k, v in pairs(slbrestools) do
		if not ply:IsAdmin() and mode == v then
			ply:PrintMessage(HUD_PRINTTALK, "[Sledbuild] This tool is restricted.")
			return false
		end
	end
end

hook.Add("CanTool", "LimitToolGuns", LimitToolGuns)

-- ---------------------------------------------------------------------------

function PlayarSpawnObject(ply)
	if ply:Team() == TEAM_RACING then
		ply:PrintMessage(HUD_PRINTTALK, "[Sledbuild] Props cannot be spawned while being in the racing zone.")
		return false
	end
	return true
end

hook.Add("PlayerSpawnObject", "PlayarSpawnObject", PlayarSpawnObject)

-- ---------------------------------------------------------------------------

function SpawnedProp(userid, model, prop)
	if prop:BoundingRadius() > 128 then -- Note: Radius is half the size of the diameter (half the size of the prop)
		prop:Remove()
		userid:PrintMessage(HUD_PRINTTALK, "[Sledbuild] That prop is way too large for a sled.")
	end

	prop:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)

end

hook.Add("PlayerSpawnedProp", "SpawnedProp", SpawnedProp)

-- ---------------------------------------------------------------------------

function SpawnedVehicle(userid, prop)
	prop:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
end

hook.Add("PlayerSpawnedVehicle", "SpawnedVehicle", SpawnedVehicle)

function NoDeathSound()
	return true
end

hook.Add("PlayerDeathSound", "NoDeathSound", NoDeathSound)


local models = {
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
function blockProps(ply, mdl)
	for _, v in pairs(models) do
		if string.find(mdl, v) then
			ply:PrintMessage(HUD_PRINTTALK, "[Sledbuild] This prop is restricted.")
			return false
		end
	end
end

hook.Add("PlayerSpawnProp", "blockProps", blockProps)

function LeaveVehicle(pl, vehicle)
	pl:SetCollisionGroup(COLLISION_GROUP_WEAPON)
end

hook.Add("PlayerLeaveVehicle", "LeaveVehicle", LeaveVehicle)
