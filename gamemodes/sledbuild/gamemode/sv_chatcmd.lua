-- Chat CMD Lib by Boarstee :P --

local ChatCommands = {}
ChatCommands.Commands = {}
ChatCommands.AntiSpamm = {}
ChatCommands.SpammDelay = 2

function ChatCommands.SpammProtection( ply )
	local last = ply:GetNWFloat( "ccmd_last" ) or 0
	if last + ChatCommands.SpammDelay < CurTime() then
		ply:SetNWFloat( "ccmd_last", CurTime() )
		return true
	else
		ply:PrintMessage( HUD_PRINTTALK, "[Sledbuild] You're using this feature too often!" )
		return false
	end
end

function ChatCommands.IsCommand( str )
	if ChatCommands.Commands[str] then
		return true
	else
		return false
	end
end

function ChatCommands.DoCommand( pid, str, param )
	if ( ChatCommands.AntiSpamm[str] ) then
		if ( ChatCommands.SpammProtection( pid ) ) then
			if ( ChatCommands.Commands[str] ) then
				ChatCommands.Commands[str]( pid, param )
			end
		end
	else
		ChatCommands.Commands[str]( pid, param )
	end
end

function ChatCommands.DoChat( ply, str, itc )
	if string.sub(str,1,1) == "/" then
		str = string.sub( str, 2 )
		
		local pos = string.find( str, " " )
		local command
		local arg

		if not pos then
			command = str
			arg = ""
		else
			command = string.sub( str, 0, pos - 1 )
			arg = string.sub( str, pos + 1 )
		end
		
		if ChatCommands.IsCommand( command ) then
			ChatCommands.DoCommand( ply, command, arg )
		else
			ply:ChatPrint( "\""..command.."\" is not a valid command!" )
		end
		
		return ""
	end
end
hook.Add( "PlayerSay", "ChatCommands.DoChat", ChatCommands.DoChat )

function AddChatCommand( str, info, func, antispamm )
	ChatCommands.Commands[str] = func
	if ( info && info ~= "" ) then
		AddHelp( "/"..str, info )
	end
	if ( antispamm ) then
		ChatCommands.AntiSpamm[str] = true
	end
end

-- Some useful functions --

function ChatCommands.PrintChat( ply, text )
	if type( ply ) == "table" then
		for k, v in pairs( ply ) do
			v:ChatPrint( text )
		end
	else
		ply:ChatPrint( text )
	end
end

function ChatCommands.PrintChatAll( text )
	for k, v in pairs( player.GetAll() ) do
		ChatCommands.PrintChat( v, text )
	end
end

function ChatCommands.PrintChatDistance( oplayer, range, text )
	local OPos = oplayer:GetPos()
	for k, v in pairs( player.GetAll() ) do
		local dist = ( OPos - v:GetPos() ):Length()
		if dist <= range then
			ChatCommands.PrintChat( v, text )
		end
	end
end

function ChatCommands.PrintChatTeam( team, text )
	for k, v in pairs( player.GetAll() ) do
		if v:Team() == team then
			ChatCommands.PrintChat( v, text )
		end
	end
end

-- Some "default" chat commands ;) --

function ChatCommands.Whisper( ply, arg )
	local text = ply:Name() .." [Whisper]: " .. arg
	ChatCommands.PrintChatDistance( ply, 64, text )
end
AddChatCommand( "w", "Talk to nearby players only", ChatCommands.Whisper )

function ChatCommands.Yell( ply, arg )
	local text = ply:Name() .." [Yell]: " .. arg
	ChatCommands.PrintChatDistance( ply, 512, text )
end
AddChatCommand( "y", "Yell something!", ChatCommands.Yell, true )

function ChatCommands.Me( ply, arg )
	local text = "* " .. ply:Name() .. " " .. arg
	ChatCommands.PrintChatAll( text )
end
AddChatCommand( "me", "*Developer adds help here", ChatCommands.Me )

function ChatCommands.RemoveFires( ply, arg )
	for k, v in pairs( ents.GetAll() ) do
		v:Extinguish()
	end
end
AddChatCommand( "fire", "Removes all fires", ChatCommands.RemoveFires, true )

-- Sledbuild commands!!! --

local CCMD_taunts = {
	"vo/npc/male01/hacks02.wav",
	"vo/npc/male01/hacks01.wav",
	"vo/k_lab/ba_dontblameyou.wav",
	"vo/npc/barney/ba_downyougo.wav",
	"vo/trainyard/al_noyoudont.wav",
	"combined/k_lab/k_lab_ba_getoutofsight01_cc.wav",
	"vo/streetwar/rubble/ba_tellbreen.wav"
}

for k, v in pairs( CCMD_taunts ) do
	util.PrecacheSound( v )
end

function ChatCommands.Taunt( ply, arg )
	local sound = CCMD_taunts[math.random(#CCMD_taunts)]
	util.PrecacheSound( sound )
	ply:EmitSound( sound, 100, 100 )
end
AddChatCommand( "taunt", "Play a taunt (sound)", ChatCommands.Taunt, true )

local CCMD_lol = {
	{ "vo/citadel/br_laugh", ".wav", 1, 1 },
	{ "vo/eli_lab/al_laugh", ".wav", 1, 2 },
	{ "vo/npc/barney/ba_laugh", ".wav", 1, 4 },
	{ "vo/ravenholm/madlaugh", ".wav", 1, 4 }
}

function ChatCommands.Lol( ply, arg )
	local soundplat = CCMD_lol[math.random(#CCMD_lol)]
	local soundid = math.random( soundplat[3], soundplat[4] )
	local sound = soundplat[1]
	if soundid < 10 then
		sound = sound.."0"..soundid
	else
		sound = sound..soundid
	end
	sound = sound..soundplat[2]
	
	util.PrecacheSound( sound )
	ply:EmitSound( sound, 100, 100 )
end
AddChatCommand( "lol", "LOL!", ChatCommands.Lol, true )

local CCMD_special = {}
CCMD_special["win"] = "sledbuild/race/slb_win.mp3"
CCMD_special["lose"] = "sledbuild/race/slb_lose.mp3"
CCMD_special["banana"] = "sledbuild/taunts/slb_banana.mp3"
CCMD_special["freestyler"] = "sledbuild/taunts/slb_freestyler.mp3"
CCMD_special["leeroy"] = "sledbuild/taunts/slb_leeroy.mp3"
CCMD_special["speedboy"] = "sledbuild/taunts/slb_speedboy.mp3"

function ChatCommands.Taunt( ply, arg )
	if ply:IsAdmin() then
		local sound = ""
		if type( arg ) == "table" then
			sound = arg[1]
		elseif type( arg ) == "string" then			
			sound = arg
		end
		if CCMD_special[sound] then
			util.PrecacheSound( CCMD_special[sound] )
			ply:EmitSound( CCMD_special[sound], 100, 100 )
		end
	end
end
AddChatCommand( "special", "", ChatCommands.Taunt, true )
