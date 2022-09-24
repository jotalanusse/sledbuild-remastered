HUD = {
  DASHBOARD = {
    MATERIAL = Material("gui/sledbuildremastered/sbr_hud.png")
  }
}

function HUD.Paint()
  -- local baseFrame = HUD.CreateBaseFrame()

  local hud = HUD.CreateHUD()
end

hook.Add("HUDPaint", "SBR:HUD:Paint", HUD.Paint)

-- CreateBaseFrame: Create the base frame for almost all UI elements of the menu
-- function HUD.CreateBaseFrame()
--   local frame = vgui.Create("DFrame")
--   HLPS.DisableFrameInteraction(frame)

--   frame:SetSize(ScrW(), ScrH())
--   frame:Center()

--   frame.Paint = function(self, w, h)
--     draw.RoundedBox(0, 0, 0, w, h, COLORS.INVISIBLE)
--   end

--   return frame
-- end

-- CreateHUD: Create the HUD
function HUD.CreateHUD()
  surface.SetDrawColor(255, 255, 255, 255)
  surface.SetMaterial(HUD.DASHBOARD.MATERIAL)
  surface.DrawTexturedRect(ScrW() - 256, 0, 256, 256)
end
