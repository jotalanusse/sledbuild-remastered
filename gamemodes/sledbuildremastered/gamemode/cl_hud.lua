HUD = {
  COLORS = {
    TEXT = Color(255, 255, 255, 200), -- Text color
    PLACEHOLDER = Color(0, 0, 0, 64), -- Placeholder color
  },
  DASHBOARD = {
    MATERIAL = Material("gui/sledbuildremastered/sbr_hud.png")
  }
}

function HUD.Paint()
  local hud = HUD.CreateHUD()
end

hook.Add("HUDPaint", "SBR:HUD:Paint", HUD.Paint)


-- CreateHUD: Create the HUD
function HUD.CreateHUD()
  surface.SetDrawColor(255, 255, 255, 255)
  surface.SetMaterial(HUD.DASHBOARD.MATERIAL)
  surface.DrawTexturedRect(ScrW() - 256, 0, 256, 256)

  local mph = math.Round(LocalPlayer():GetNWFloat("SBR:Speed"))
  local formattedMph = FRMT.FormatHUDSpeed(mph)

  -- Never touch the offsets of this text or it will break!
  HUD.CreateSpeedText(formattedMph, HUD.COLORS.TEXT, ScrW() - 103, 20)
  HUD.CreateTimerText(888, HUD.COLORS.TEXT, ScrW() - 50, 86)
end

-- CreateSpeedText: Create the HUD speed text
function HUD.CreateSpeedText(text, color, widthOffset, heightOffset)
  draw.DrawText(888, FONTS.HUD.SPEED, widthOffset, heightOffset, HUD.COLORS.PLACEHOLDER, TEXT_ALIGN_CENTER)
  draw.DrawText(text, FONTS.HUD.SPEED, widthOffset, heightOffset, color, TEXT_ALIGN_CENTER)
end

-- CreateTimerText: Create the HUD timer text
function HUD.CreateTimerText(text, color, widthOffset, heightOffset)
  draw.DrawText(888, FONTS.HUD.TIMER, widthOffset, heightOffset, HUD.COLORS.PLACEHOLDER, TEXT_ALIGN_CENTER)
  draw.DrawText(text, FONTS.HUD.TIMER, widthOffset, heightOffset, color, TEXT_ALIGN_CENTER)
end
