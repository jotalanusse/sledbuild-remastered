local PLSpeedTable = {}

local PLAYERSTATS = "slb_players_v3" 		-- new table, again!
local IDX_PLAYERSTATS = "IDX_SLBSTATS3"

if ( !sql.TableExists( PLAYERSTATS ) ) then
	sql.Query( "CREATE TABLE IF NOT EXISTS "..PLAYERSTATS.." ( id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, steamid INTEGER, won, lost INTEGER, topspeed FLOAT, mapname TEXT );" )
	sql.Query( "CREATE INDEX "..IDX_PLAYERSTATS.." ON "..PLAYERSTATS.." ( target DESC )" )
end

local function ClearSteamID( sid )
	sid = string.lower( sid )
	if ( string.find( sid, "steam" ) ) then
		sid = string.gsub( sid, "steam", "" )
		sid = string.gsub( sid, ":", "" )
		sid = string.gsub( sid, "_", "" )
		sid = tonumber( sid )
	else	
		sid = 0
	end
	return sid
end

function stats_load( ply )
	local sid = ClearSteamID( ply:SteamID() )
	local mapname = game.GetMap()	
	local result = sql.Query( "SELECT topspeed, mapname, won, lost FROM "..PLAYERSTATS.." WHERE steamid = "..sid..";" )
	if ( result == nil ) then
		sql.Query( "INSERT INTO "..PLAYERSTATS.." ( steamid, topspeed, mapname, won, lost ) VALUES ( "..sid..", 0, '"..mapname.."', 0, 0 );" )
		ply:PrintMessage( HUD_PRINTTALK, "[Sledbuild] Welcome to Sledbuild!,all your stats are getting saved!" )
	else
		for k, v in pairs( result ) do
			if ( v['mapname'] && v['topspeed'] && v['mapname'] == game.GetMap() ) then
				PLSpeedTable[sid].gts = tonumber( v['topspeed'] )
				ply:SetNWString( "_GTS", tostring( PLSpeedTable[sid].gts / 10 ) )
				if ( v['won'] && v['lost'] ) then
					ply:PrintMessage( HUD_PRINTTALK, "[Sledbuild] Total Races Won: "..v['won']..", Lost: "..v['lost'] )
				end
				break
			end
		end
	end
end

function stats_save( ply )
	local sid = ClearSteamID( ply:SteamID() )
	local mapname = game.GetMap()	
	local topspeed = PLSpeedTable[ClearSteamID(ply:SteamID())].gts
	local won, lost = ply:Frags(), ply:Deaths()
	
	local result = sql.Query( "SELECT won, lost FROM "..PLAYERSTATS.." WHERE steamid = "..sid..";" )
	for k, v in pairs( result ) do
		if ( v['won'] && v['lost'] ) then
			won = won + tonumber( v['won'] )
			lost = lost + tonumber( v['lost'] )
			break
		end
	end
	sql.Query( "UPDATE "..PLAYERSTATS.." SET topspeed = "..topspeed..", won = "..won..", lost = "..lost.." WHERE steamid = "..sid..";" )
end

-- // -- Player Stats Shit here -- // --

local lastspeedpublish = CurTime()
local PUBLISHPAUSE = 0.66

PLSpeedTable = PLSpeedTable or {}

function PST_UpdateNW()	
	if lastspeedpublish + PUBLISHPAUSE < CurTime() then
		lastspeedpublish = CurTime()		
		for _, pl in pairs( player.GetAll() ) do
			local sid = ClearSteamID(pl:SteamID())
			pl:SetNWInt( "_SPEED", PLSpeedTable[sid].speed or 0 )
			pl:SetNWInt( "_CTS", PLSpeedTable[sid].cts or 0 )
			pl:SetNWInt( "_GTS", PLSpeedTable[sid].gts or 0 )
		end
	end
end
hook.Add( "Think", "PST_UpdateNW", PST_UpdateNW )

function GenerateSubmitKey( ply ) -- some fancy stuff here :P
	//local key = tostring( math.floor( math.sin( CurTime() * ply:UniqueID() ) * ( math.random( 50000 ) + 1337 ) ) ) -- no floating point pl0x
	//key = string.sub( ply:Name(), -math.random(3) )..key..string.reverse( string.sub( ply:SteamID(), -math.random(5) ) )
	return tostring( math.floor( CurTime() ) + 50 ).."_LOLHAX" //key  -- NOW BEAT THAT MOFO xD
end

function PST_DelayedKeySend( ply )
	local sid = ClearSteamID(ply:SteamID())
	PLSpeedTable[sid].key = GenerateSubmitKey( ply )
	
	local rp = RecipientFilter()
	rp:AddPlayer( ply )
	umsg.Start( "recspeedkey", rp )
		umsg.String( PLSpeedTable[sid].key )
	umsg.End()
end

function PST_PlayerInitialSpawn( ply )	
	local sid = ClearSteamID(ply:SteamID())
	PLSpeedTable[sid] = { cts = 0, speed = 0, gts = 0, key = "" }
	stats_load( ply )
	//timer.Simple(1, PST_DelayedKeySend, ply )  
end
//hook.Add( "PlayerInitialSpawn", "PST_PlayerInitialSpawn", PST_PlayerInitialSpawn )
//added it to the initialspawn hook @ init.lua

function PST_PlayerDisconnected( ply )	
	if ( PLSpeedTable[ClearSteamID(ply:SteamID())] ) then
		stats_save( ply )
		PLSpeedTable[ClearSteamID(ply:SteamID())] = nil
	end
end
hook.Add( "PlayerDisconnected", "PST_PlayerDisconnected", PST_PlayerDisconnected )

local consolespam = false

function PST_CCSubmitSpeeds( ply, cmd, args )
	if ply && ply:IsPlayer() && ply:Alive() then
		if ( #args == 2 ) then
			local sid = ClearSteamID( ply:SteamID() )
			//if ( args[1] == PLSpeedTable[sid].key ) then 
				PLSpeedTable[sid].cts = tonumber( args[1] ) or 0
				PLSpeedTable[sid].speed = tonumber( args[2] ) or 0
				if PLSpeedTable[sid].cts > PLSpeedTable[sid].gts then
					PLSpeedTable[sid].gts = PLSpeedTable[sid].cts
				end
				return
			//end
		end
	end
	if ply && ply:IsPlayer() && consolespam then
		Msg( "Player "..ply:Name().." couldn't get updated ("..string.Implode("|",args)..")\n" )
	end
end
concommand.Add( "CC_SubmitSpeeds" , PST_CCSubmitSpeeds )

function enabledebug( ply, cmd, arg )
	consolespam = !consolespam
end
concommand.Add( "con_debug", enabledebug )
