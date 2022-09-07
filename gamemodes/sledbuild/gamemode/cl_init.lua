include( 'shared.lua' ) -- ########### DON'T COMMENT THESE OUT
include( 'cl_menusys.lua' )

local slbprevspeed = 0
local isracing = false

local currenttopspeed = 0
local globaltopspeed = 0
local speedstr = 0

local lastsendtime = CurTime()
local SENDPAUSE = 0.66
local racetimertime = 90 -- MATCH WITH TIME IN SERVER INIT
local speedometer_maxspeed = 200
_G['tHM'] = 0
_G['tLastRace'] = 0
_G['HM'] = 0
_G['lastRace'] = 0
_G["FirstPosition"] = "N/A"
_G["SecondPosition"] = "N/A"
_G["ThirdPosition"] = "N/A"

-- Like a password, so no one can "cheat" his speeds to high values using the console command :P
local submitkey = "N/A" -- keep it local so no one can hijack it :P

local function usmg_recspeedkey( um ) -- usermessages ftw
	submitkey = um:ReadString() or "N/A"
end
usermessage.Hook( "recspeedkey", usmg_recspeedkey )

local function PublishTopSpeeds()
	if ( lastsendtime + SENDPAUSE < CurTime() ) then
		lastsendtime = CurTime()
		local sendstring = tostring( math.floor( currenttopspeed * 10 ) ) .." ".. tostring( math.floor( speedstr * 10 ) )
		-- LocalPlayer():ConCommand( "CC_SubmitSpeeds "..submitkey.." ".. sendstring )
		LocalPlayer():ConCommand( "CC_SubmitSpeeds ".. sendstring )
	end
end

function Init_Gamemode()
	GAMEMODE.ShowHelpScreen = false
	GAMEMODE.ShowScoreboard = false
	net.Receive("RaceVariables", function()
		_G['HM'] = net.ReadFloat()
		_G['lastRace'] = net.ReadFloat()
		_G['FirstPostion'] = net.ReadString()
		_G['SecondPostion'] = net.ReadString()
		_G['ThirdPostion'] = net.ReadString()
	end)
	if !_G['HM'] and !_G['lastRace'] then
		_G['HM'] = _G['tHM']
		_G['lastRace'] = _G['tLastRace']
	elseif !_G['lastRace'] then
		_G['lastRace'] = _G['tLastRace']
	elseif !_G['HM'] then
		_G['HM'] = _G['tHM']
	else
		_G['tLastRace'] = _G['lastRace']
		_G['tHM'] = _G['HM']
	end
end
hook.Add( "Initialize", "initializing", Init_Gamemode )

local function drawplayernames()
	local myself = LocalPlayer()
	local myspeed
	if LocalPlayer():InVehicle() then
		myspeed = LocalPlayer():GetVehicle():GetVelocity():Length() 
		myspeed = math.Round( myspeed / 17.6 * 10 ) / 10
	else
		myspeed = LocalPlayer():GetVelocity():Length() 
		myspeed = math.Round( myspeed / 17.6 * 10 ) / 10
	end
	for k, v in pairs(player.GetAll()) do
		if (v == myself) then
		--nil
		elseif (myself:Team() == TEAM_RACING && v:Team() == TEAM_RACING) then
			local pos = v:GetPos() + Vector(0,0,128)
			local mypos = LocalPlayer():GetPos()
			pos = pos:ToScreen()
			local distance = math.floor( ((v:GetPos():Distance(mypos)) / 16) * 10 ) / 10
			local thecolor = Color(255, 255, 255, math.Clamp(255 - distance, 0, 255))
			local thecolor2 = Color(0, 0, 0, math.Clamp(255 - distance, 0, 255))
			local plyspeed
			local plyspeeddelta = 0
			local plyspeedisgreater = ""
			if v:InVehicle() then
				plyspeed = v:GetVehicle():GetVelocity():Length() 
				plyspeed = math.Round( plyspeed / 17.6 * 10 ) / 10
				plyspeeddelta = math.Round((plyspeed - myspeed)*10) / 10
				if plyspeeddelta > 0 then plyspeedisgreater = "+" end
				plyspeeddelta = plyspeeddelta
				--plyspeed = "("..plyspeedisgreater..plyspeeddelta..") "..plyspeed.." MPH"
			else
				plyspeed = "N/A"
				plyspeeddelta = 0
			end
			
			--draw.SimpleTextOutlined( String Text, String Font, Number X, Number Y, Table Colour, Number Xalign, Number Yalign, Number Outline, Table Colour )
			draw.SimpleTextOutlined(v:Name(), "ScoreboardText", pos.x, pos.y, thecolor, 1, 1, 1, thecolor2 )
			draw.SimpleTextOutlined("".. distance .." FT", "ScoreboardText", pos.x, pos.y + 16, thecolor, 1, 1, 1, thecolor2 )
			draw.SimpleTextOutlined(tostring(plyspeed).." MPH", "ScoreboardText", pos.x, pos.y + 16*2, thecolor, 1, 1, 1, thecolor2 )
			if plyspeeddelta < 0 then 
				thecolor = Color(0, 255, 0, math.Clamp(255 - distance, 0, 255))
			elseif plyspeeddelta == 0 then
				thecolor = Color(255, 255, 255, math.Clamp(255 - distance, 0, 255))
				plyspeeddelta = "+-0"
			else
				thecolor = Color(255, 0, 0, math.Clamp(255 - distance, 0, 255))
			end
			draw.SimpleTextOutlined("( ".. tostring(plyspeedisgreater..plyspeeddelta.." )"), "ScoreboardText", pos.x, pos.y + 16*3, thecolor, 1, 1, 1, thecolor2 )
		end
	end
end

function Leeroy()	
	net.Receive("RaceVariables", function()
		_G['HM'] = net.ReadFloat()
		_G['lastRace'] = net.ReadFloat()
		_G['FirstPosition'] = net.ReadString()
		_G['SecondPostion'] = net.ReadString()
		_G['ThirdPostion'] = net.ReadString()
	end)
	
	if !_G['HM'] and !_G['lastRace'] then
		_G['HM'] = _G['tHM']
		_G['lastRace'] = _G['tLastRace']
	elseif !_G['lastRace'] then
		_G['lastRace'] = _G['tLastRace']
	elseif !_G['HM'] then
		_G['HM'] = _G['tHM']
	elseif !_G['FirstPosition'] or !_G['SecondPosition'] or !_G['ThirdPosition'] then
		_G['FirstPosition'] = 'N/Ai'
		_G['SecondPosition'] = 'N/Ai'
		_G['ThirdPosition'] = 'N/Ai'
	else
		_G['tLastRace'] = _G['lastRace']
		_G['tHM'] = _G['HM']
	end
	
	local HowManyBuilding = team.NumPlayers (TEAM_BUILDING)
	local HowManyRacing = team.NumPlayers (TEAM_RACING)
	local Name = LocalPlayer():Nick()
	local Won = LocalPlayer():Frags()
	local Lost = LocalPlayer():Deaths()
	local Lag = LocalPlayer():Ping()
	local FirstPosition = _G["FirstPosition"]
	local SecondPosition = _G["SecondPosition"]
	local ThirdPosition = _G["ThirdPosition"]
	
	local TotalPlayers = #player.GetAll()
	local startsoundplayed = false

	local NextRace = math.Round( 0 - ( CurTime() - racetimertime - lastRace ) )
	
	if NextRace < 0 then
		NextRace = "0"
	end

	if NextRace == 0 && !startsoundplayed then
		startsoundplayed = true
		surface.PlaySound( "ambient/alarms/warningbell1.wav" )
	else
	  	startsoundplayed = false
	end

	--draw.RoundedBox( 4, 2, 2, 225, 215, Color(0, 0, 0, 140) )
	
	surface.SetTexture(surface.GetTextureID("gui/sledbuild/timer_bg2"))
	surface.SetDrawColor(0,0,0,150)
	surface.DrawTexturedRect(ScrW()-256+32,0,256-32,256+64)
	
	-- Next Race clock BEGIN - ReaperSWE
	local slbclockx = ScrW()*1-24
	local slbclocky = 136
	local slbclockz = 0.6
	surface.SetTexture(surface.GetTextureID("gui/sledbuild/timer_bg"))
	surface.SetDrawColor(255,255,255,255)
	surface.DrawTexturedRect(slbclockx-64,slbclocky,128*slbclockz,128*slbclockz) 
	
	local slbnextracecolor = Color(150, 150, 150, 255)
	if math.Round(NextRace) < 10 then  slbnextracecolor = Color(22, 150, 242, 255) end
	draw.DrawText(math.Round(NextRace),"ScoreboardText",slbclockx-26,slbclocky+64*slbclockz + 8,slbnextracecolor,1)
	
	-- 22, 150, 242, 255
	local slbtimer = math.Round(NextRace)*359/racetimertime
	
	surface.SetTexture(surface.GetTextureID("gui/sledbuild/timer_ro"))
	surface.SetDrawColor(22, 150, 242, 255)
	surface.DrawTexturedRectRotated(slbclockx-26,slbclocky+64*slbclockz,128*slbclockz,128*slbclockz,slbtimer)

	surface.SetTexture(surface.GetTextureID("gui/sledbuild/timer_sh"))
	surface.SetDrawColor(255,255,255,150)
	surface.DrawTexturedRect(slbclockx-64,slbclocky,128*slbclockz,128*slbclockz) 
	-- Next Race clock END

	
	surface.SetTexture(surface.GetTextureID("GUI/gradient"))
	surface.SetDrawColor(0,0,0,255)
	surface.DrawTexturedRect(0,00,225,160)
	-- Player Name
	draw.DrawText("Name: " .. Name,"ScoreboardText",13,10,Color(255, 255, 255, 255),0,0)

	-- Stats
	draw.DrawText("Top Three in " .. Won .. " out of " .. Won + Lost .. " races","ScoreboardText",13,30,Color(255, 255, 255, 255),0,0)

	-- Building Racing
	draw.DrawText("Racing: " .. HowManyRacing .. " of " .. TotalPlayers .." players","ScoreboardText",13,50,Color(255, 255, 255, 255),0,0)

	-- Last Race Title
	draw.DrawText("Race #" ..HM.. " Results:","ScoreboardText",13,70,Color(255, 255, 255, 255),0,0)

	-- Last Race Stats
	draw.DrawText("1st: " .. FirstPosition,"ScoreboardText",13, 90,Color(0, 255, 0, 255),0,0)
	draw.DrawText("2nd: " .. SecondPosition,"ScoreboardText",13, 110,Color(255, 255, 0, 255),0,0)
	draw.DrawText("3rd: " .. ThirdPosition,"ScoreboardText",13, 130,Color(255, 0, 0, 255),0,0)
	
	if ( IsValid( LocalPlayer()) and LocalPlayer():InVehicle() ) then
		local conv = 17.6 -- mph convertion value
		local speed = LocalPlayer():GetVehicle():GetVelocity():Length() 	
		speedstr = math.Round( speed / conv * 10 ) / 10
		hackerspeed =  speedstr
		local delta = speedstr - slbprevspeed
		if delta > 120 then speedstr = 0 end
		slbprevspeed = speedstr
		
		if ( LocalPlayer():GetNWBool("IsRacing") ) then
			if ( !isracing ) then
				isracing = true
				currenttopspeed = 0
			end
			
			if ( speedstr > currenttopspeed ) then
				currenttopspeed = speedstr
			end
			if ( speedstr > globaltopspeed ) then
				globaltopspeed = speedstr
			end
		else
			isracing = false
		end
	else
		if speedstr > 0 then speedstr = math.Round((speedstr - speedometer_maxspeed*0.01)*10)/10 end
		if speedstr < 0 then speedstr = 0 end
	end
	
	-- Topspeed clock BEGIN - ReaperSWE
	local slbspeedx = ScrW()*1.0-64-8
	local slbspeedy = 8
	local slbspeedz = 1
	surface.SetTexture(surface.GetTextureID("gui/sledbuild/timer_bg"))
	surface.SetDrawColor(255,255,255,255)
	surface.DrawTexturedRect(slbspeedx-64,slbspeedy,128*slbspeedz,128*slbspeedz) 
	
	local slbtimer = 0
	slbtimer = speedstr*-270/speedometer_maxspeed + 135
	slbtimer2 = currenttopspeed*-270/speedometer_maxspeed + 135
	slbtimer3 = globaltopspeed*-270/speedometer_maxspeed + 135 -- globaltopspeed
	
	draw.DrawText("(" .. currenttopspeed .. " MPH)","ScoreboardText",slbspeedx,slbspeedy + 64 + 16,Color(150, 150, 150, 255),1)
	draw.DrawText("" .. speedstr .. " MPH","ScoreboardText",slbspeedx,slbspeedy + 64 + 16+12,Color(150, 150, 150, 255),1)
	
	surface.SetTexture(surface.GetTextureID("gui/sledbuild/timer_ro"))
	surface.SetDrawColor(255,255,255,155)
	surface.DrawTexturedRectRotated(slbspeedx,slbspeedy+(64*slbspeedz),128*slbspeedz,128*slbspeedz,slbtimer3)
	surface.SetDrawColor(255,255,255,255)
	surface.DrawTexturedRectRotated(slbspeedx,slbspeedy+(64*slbspeedz),128*slbspeedz,128*slbspeedz,slbtimer2)
	surface.SetDrawColor(22, 150, 242, 255)
	surface.DrawTexturedRectRotated(slbspeedx,slbspeedy+(64*slbspeedz),128*slbspeedz,128*slbspeedz,slbtimer)

	surface.SetTexture(surface.GetTextureID("gui/sledbuild/timer_sh"))
	surface.SetDrawColor(255,255,255,150)
	surface.DrawTexturedRect(slbspeedx-64,slbspeedy,128*slbspeedz,128*slbspeedz) 
	-- Topspeed clock END
	
	drawplayernames()
	PublishTopSpeeds()
end
hook.Add ("HUDPaint", "HookHUD", Leeroy)

local function hidehud(name)
	for k, v in pairs{"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"} do
		if name == v then return false
	end
	
	return true
	end
end
hook.Add("HUDShouldDraw", "hidehud", hidehud) 
