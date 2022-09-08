-- -- Button defs --
-- STATE_NONE = 0
-- STATE_HOVER = 1
-- STATE_DOWN = 2

-- BUTTONSOUND = "buttons/button16.wav"
-- util.PrecacheSound(BUTTONSOUND)

-- local MButtons = {}
-- MButtons[TAB_SCORES] = {
-- 	Caption = "Scoreboard",
-- 	Function = function() CurrentTab = TAB_SCORES; Msg("TAB_SCORES\n") end,
-- 	Exec = false,
-- 	State = STATE_NONE
-- }

-- MButtons[TAB_HELP] = {
-- 	Caption = "Help",
-- 	Function = function() CurrentTab = TAB_HELP; Msg("TAB_HELP\n") end,
-- 	Exec = false,
-- 	State = STATE_NONE
-- }

-- -- Mouse button --
-- local mousedown = false
-- local function hook_mousepressed(mcode)
-- 	if mcode == MOUSE_LEFT then
-- 		mousedown = true
-- 	end
-- end

-- hook.Add("GUIMousePressed", "hook_mousepressed", hook_mousepressed)

-- local function hook_mousereleased(mcode)
-- 	if mcode == MOUSE_LEFT then
-- 		mousedown = false
-- 	end
-- end

-- hook.Add("GUIMouseReleased", "hook_mousereleased", hook_mousereleased)

-- -- Functions --
-- local function Buttons_Interact(buttonid, layout)
-- 	local mx, my = gui.MousePos()
-- 	local x, y = layout.x, layout.y
-- 	local w, h = layout.w, layout.h
-- 	local mb = MButtons[buttonid]
-- 	if (mx >= x and mx <= x + w) and (my >= y and my <= y + h) then
-- 		if mousedown then
-- 			mb.State = STATE_DOWN
-- 			if not mb.Exec then
-- 				surface.PlaySound(BUTTONSOUND)
-- 				mb.Function()
-- 				mb.Exec = true
-- 			end
-- 		else
-- 			mb.State = STATE_HOVER
-- 			mb.Exec = false
-- 		end
-- 	else
-- 		mb.State = STATE_NONE
-- 		mb.Exec = false
-- 	end
-- end

-- function Buttons_Render(startX, startY, bWidth, bHeight)
-- 	local buttonlayout = {}
-- 	local cwidth = 0

-- 	-- First loop: text size
-- 	for id, button in pairs(MButtons) do
-- 		surface.SetFont("ScoreboardText")
-- 		local Width, Height = surface.GetTextSize(button.Caption)
-- 		Width = Width + 8 -- Add borders
-- 		Height = Height + 8
-- 		buttonlayout[id] = { w = Width, h = Height }
-- 		cwidth = cwidth + Width
-- 	end
-- 	cwidth = cwidth + (#buttonlayout - 1) * 10 -- Spacing
-- 	cheight = buttonlayout[TAB_SCORES].h

-- 	-- Second loop: text pos
-- 	local xoffset = bWidth / 2 - cwidth / 2 + startX
-- 	local yoffset = bHeight / 2 - cheight / 2 + startY
-- 	for id, button in pairs(MButtons) do
-- 		local w, h = buttonlayout[id].w, buttonlayout[id].h
-- 		buttonlayout[id].x = xoffset
-- 		buttonlayout[id].y = yoffset
-- 		xoffset = xoffset + w + 10
-- 	end

-- 	-- Third loop: interaction and rendering
-- 	for id, button in pairs(MButtons) do
-- 		Buttons_Interact(id, buttonlayout[id])
-- 		local color, fcolor = BGCOLOR, HIGHLIGHT
-- 		if button.State == STATE_HOVER then
-- 			fcolor = Color(240, 240, 240, 255)
-- 		elseif button.State == STATE_DOWN then
-- 			color = Color(20, 140, 230, 255)
-- 			fcolor = Color(240, 240, 240, 255)
-- 		end
-- 		draw.RoundedBox(4, buttonlayout[id].x - 1, buttonlayout[id].y - 1, buttonlayout[id].w + 2, buttonlayout[id].h + 2,
-- 			HIGHLIGHT)
-- 		draw.WordBox(4, buttonlayout[id].x, buttonlayout[id].y, button.Caption, "ScoreboardText", color, fcolor)
-- 	end
-- end
