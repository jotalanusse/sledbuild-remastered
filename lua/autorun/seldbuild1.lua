-- if SERVER then AddCSLuaFile() return end

-- local oldCF = surface.CreateFont

-- function surface.CreateOldFont(font_name, osize, oweight, aa, oadditive, new_font_name, drop_shadow, outlined, oblur,
--                                scanline)

--         oldCF(new_font_name,
--                 { font = font_name, size = osize, weight = oweight, antialias = aa or false, additive = oadditive,
--                         shadow = drop_shadow or false, outline = outlined or false, blursize = oblur or 0,
--                         scanlines = scanline or 0 })

-- end

-- function surface.CreateFont(font_name, osize, oweight, aa, oadditive, new_font_name, drop_shadow, outlined, oblur,
--                             scanline)

--         if type(osize) == "number" then
--                 return surface.CreateOldFont(font_name, osize, oweight, aa, oadditive, new_font_name, drop_shadow,
--                         outlined, oblur, scanline)
--         else
--                 return oldCF(font_name, osize)
--         end

-- end

-- surface.CreateOldFont("Trebuchet MS", 18, 900, true, false, "Trebuchet18")
-- surface.CreateOldFont("Trebuchet MS", 19, 900, true, false, "Trebuchet19")
-- surface.CreateOldFont("Trebuchet MS", 20, 900, true, false, "Trebuchet20")
-- surface.CreateOldFont("Trebuchet MS", 22, 900, true, false, "Trebuchet22")
-- surface.CreateOldFont("Trebuchet MS", 24, 500, true, false, "Trebuchet24")
-- surface.CreateOldFont("Trebuchet MS", 17, 700, true, false, "TabLarge", true)
-- surface.CreateOldFont("Default", 16, 800, true, false, "UiBold")
-- surface.CreateOldFont("coolvetica", 32, 500, true, false, "ScoreboardHeader")
-- surface.CreateOldFont("coolvetica", 22, 500, true, false, "ScoreboardSubtitle")
-- surface.CreateOldFont("coolvetica", 19, 500, true, false, "ScoreboardPlayerName")
-- surface.CreateOldFont("coolvetica", 15, 500, true, false, "ScoreboardPlayerName2")
-- surface.CreateOldFont("coolvetica", 22, 500, true, false, "ScoreboardPlayerNameBig")
-- surface.CreateOldFont("Trebuchet MS", 40, 900, false, false, "HUDNumber")
-- surface.CreateOldFont("coolvetica", 48, 500, true, false, "ScoreboardHead")
-- surface.CreateOldFont("coolvetica", 24, 500, true, false, "ScoreboardSub")
-- surface.CreateOldFont("Tahoma", 16, 1000, true, false, "ScoreboardText")
-- surface.CreateOldFont("Tahoma", 13, 700, false, false, "TabLarge", true)
-- surface.CreateOldFont("Tahoma", 13, 100, false, false, "DefaultOld")
-- surface.CreateOldFont("Tahoma", 13, 1000, false, false, "DefaultBold")
