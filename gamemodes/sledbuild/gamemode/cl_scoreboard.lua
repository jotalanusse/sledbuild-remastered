-- Sledbuild scoreboard + some stuff --

local function CreatePlayerInfo( pl )
	local pinfo = { pl:Nick(),
		pl:Frags(),
		pl:Deaths(),
		pl:GetNWInt( "_SPEED" ),
		pl:GetNWInt( "_CTS" ),
		pl:GetNWInt( "_GTS" ),
		pl:Ping()
	}
	return pinfo
end

local function GetScoreboardTable()
	local STable = {}	

	for id, pl in pairs( player.GetAll() ) do
		local tid = pl:Team()
		if !STable[tid] then
			STable[tid] = {}
			STable[tid].Color = team.GetColor( team )
			STable[tid].Players = {}
		end
		
		local PlayerInfo = CreatePlayerInfo( pl )		
		local insertPos = #STable[tid].Players + 1
		
		for idx, info in pairs( STable[tid].Players ) do
			if ( PlayerInfo[6] > info[6] ) then
				insertPos = idx
				break
			elseif( PlayerInfo[6] == info[6] ) then
				if ( PlayerInfo[5] > info[5] ) then
					insertPos = idx
					break
				end
			end
		end		
		table.insert( STable[tid].Players, insertPos, PlayerInfo )
	end
	for tid, tinfo in pairs( STable ) do for pid, pinfo in pairs( tinfo.Players ) do
			pinfo[4] = tostring( pinfo[4] / 10 ).." MPH"
			pinfo[5] = tostring( pinfo[5] / 10 ).." MPH"
			pinfo[6] = tostring( pinfo[6] / 10 ).." MPH"
	end end
	return STable
end

function HUDDrawScoreBoard( startX, startY, bWidth )
	local Captions = { {"Name",37}, {"Won",7}, {"Lost",7}, {"Speed",13}, {"Top Speed",13}, {"Record",13}, {"Lag",10} }
	local STable = GetScoreboardTable()
	
	local bHeight = 0
	
	-- Get the font height
	surface.SetFont( "ScoreboardText" )
	local txWidth, txHeight = surface.GetTextSize( "W" )		
	local RowHeight = txHeight + 4
	txWidth, txHeight = nil, nil
			
	-- Column width definitions
	local ColWidths = {}
	for k, v in pairs( Captions ) do
		local tcol = {}
		tcol.width = math.floor( ( v[2]/100 ) * ( bWidth ) )
		tcol.start = 0
		if #ColWidths > 0 then
			for _, i in pairs( ColWidths ) do
				tcol.start = tcol.start + i.width
			end
		end
		ColWidths[k] = tcol
	end
	
	-- Scoreboard table creation	
	local SBT = {}
	
	-- The row with the captions
	local CaptionRow = {}
	CaptionRow.TYPE = "Captions"
	CaptionRow.Color = BGCOLOR
	CaptionRow.TColor = Color( 255, 255, 255, 255 )
	CaptionRow.Cols = {}
	for k, v in pairs( Captions ) do
		table.insert( CaptionRow.Cols, v[1] )
	end
	table.insert( SBT, #SBT+1, CaptionRow )
	CaptionRow = nil
	
	-- The rows with the players
	for tid, tinfo in pairs( STable ) do
		local tcolorn = Color( 250, 250, 250, CELLALPHA )
		local tcolorh = Color( 230, 230, 250, CELLALPHA )
		for pid, pinfo in pairs( tinfo.Players ) do
			local trow = {}
			trow.TYPE = "Player"
			trow.Color = tcolorn
			if ( ( #SBT % 2 ) == 0 ) then
				trow.Color = tcolorh
			end
			if tid == 2 then
				trow.TColor = Color(80,80,255,255)
			else
				trow.TColor = Color(255,80,80,255)
			end
			trow.Cols = pinfo
			table.insert( SBT, #SBT+1, trow )
		end
	end
	
	-- Draw the Scoreboard table
	bHeight = #SBT * RowHeight + 10
	
	//SetDrawColor( BGCOLOR )
	//surface.DrawRect( startX, startY, bWidth, bHeight )
	
	startY = startY + 5
	
	local ry = 0
	for rid, row in pairs( SBT ) do
		ry = startY + (rid - 1) * RowHeight
		SetDrawColor( row.Color )
		surface.DrawRect( startX, ry, bWidth, RowHeight )
		for cid, col in pairs( row.Cols ) do
			local rx = startX + ColWidths[cid].start
			local rw = ColWidths[cid].width
			local txWidth, txHeight = surface.GetTextSize( tostring( col or "ERROR" ) )
			rx = rx + ( rw / 2 ) - ( txWidth / 2 )
			surface.SetFont( "ScoreboardText" )
			
			SetTextColor( row.TColor )
			surface.SetTextPos( math.floor( rx ), math.floor( ry ) + 2 )
			surface.DrawText( col  )
		end 
	end
	SetDrawColor( HIGHLIGHT )
	
	SetDrawColor( BGCOLOR )
	surface.DrawRect( startX, ry + RowHeight, bWidth, 10 )
	
	for _, col in pairs( ColWidths ) do
		if col.start > startX then
			surface.DrawLine( startX + col.start, startY, startX + col.start, startY + bHeight )
		end
	end
	
	SetDrawColor( BGCOLOR )
	surface.DrawOutlinedRect( startX, startY, bWidth, bHeight )
	
	surface.SetDrawColor( 255, 255, 255, 127 )
	surface.DrawOutlinedRect( startX-1, startY-1, bWidth+2, bHeight+2 )
end
