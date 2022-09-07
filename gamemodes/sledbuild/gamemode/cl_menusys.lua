HIGHLIGHT = Color( 255, 255, 255, 255 )
BGCOLOR = Color( 22, 150, 242, 255 )
SLBLOGOMAT = surface.GetTextureID( "gui/sledbuild/slblogo" )
CELLALPHA = 220

function SetDrawColor( colort, alphaoverwrite )
	alphaoverwrite = alphaoverwrite or colort.a
	surface.SetDrawColor( colort.r, colort.g, colort.b, alphaoverwrite )
end

function SetTextColor( colort, alphaoverwrite )
	alphaoverwrite = alphaoverwrite or colort.a
	surface.SetTextColor( colort.r, colort.g, colort.b, alphaoverwrite )
end

function DrawLogoBox( x, y, w, h )
	local xCenter = math.floor( x + ( w / 2 ) )
	local yCenter = math.floor( y + ( h / 2 ) )
	
	surface.SetTexture( SLBLOGOMAT )
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( xCenter-64, yCenter-63, 128, 128 )
	
	surface.SetFont( "ScoreboardHead" )
	surface.SetTextColor( 0, 0, 0, 255 )
	surface.SetTextPos( xCenter - 251, yCenter - 31 )
	surface.DrawText( "Sledbuild" )
	surface.SetTextColor( 255, 255, 255, 255 )
	surface.SetTextPos( xCenter - 250, yCenter - 30 )
	surface.DrawText( "Sledbuild" )
	
	surface.SetTextColor( 0, 0, 0, 255 )
	surface.SetTextPos( xCenter + 80, yCenter - 31 )
	surface.DrawText( "By G3X" )
	surface.SetTextColor( 255, 255, 255, 255 )
	surface.SetTextPos( xCenter + 81, yCenter - 30 )
	surface.DrawText( "By G3X" )
	
	surface.SetFont( "ScoreboardText" )
	surface.SetTextColor( 0, 0, 0, 255 )
	surface.SetTextPos( xCenter + 90, yCenter + 21 )
	surface.DrawText( "Thanks to ReaperSWE, Borsty, Metroid48 and robinkooli" )
	surface.SetTextColor( 255, 255, 255, 255 )
	surface.SetTextPos( xCenter + 91, yCenter + 20 )
	surface.DrawText( "Thanks to ReaperSWE, Borsty, Metroid48 and robinkooli" )
end

TAB_SCORES = 1
TAB_HELP = 2
TAB_ADMIN = 3

include( 'cl_scoreboard.lua' )
include( 'cl_helpscreen.lua' )
include( 'cl_mbuttons.lua' )

CurrentTab = TAB_SCORES

function GM:ScoreboardShow()
	GAMEMODE.ShowMenu = true
	gui.EnableScreenClicker( true )
end

function GM:ScoreboardHide()
	GAMEMODE.ShowMenu = false
	gui.EnableScreenClicker( false )
end

function GM:HUDDrawScoreBoard()
	if ( GAMEMODE.ShowMenu ) then
		local bWidth = math.floor( math.Clamp( ScrW() - ( ScrW()/5 ), 600, 900 ) )
		local startX = math.floor( ( ScrW() - bWidth ) / 2 )
		local startY = 32
		DrawLogoBox( startX, startY, bWidth, 130 )
		startY = startY + 130
		
		Buttons_Render( startX, startY, bWidth, 32 )
		startY = startY +32
		
		if CurrentTab == TAB_SCORES then
			HUDDrawScoreBoard( startX, startY, bWidth )
		elseif CurrentTab == TAB_HELP then
			HUDDrawHelpScreen( startX, startY, bWidth )
		elseif CurrentTab == TAB_ADMIN then
			HUDDrawAdminScreen( startX, startY, bWidth )
		end
	end
end
