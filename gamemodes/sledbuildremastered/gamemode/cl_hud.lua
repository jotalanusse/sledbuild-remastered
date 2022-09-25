HUD = {
  COLORS = {
    TEXT = Color(255, 255, 255, 180), -- Text color
    PLACEHOLDER = Color(0, 0, 0, 64), -- Placeholder color
  },
  DASHBOARD = {
    MATERIAL = Material("gui/sledbuildremastered/sbr_hud.png")
  }
}

function HUD.Paint()
  local hud = HUD.CreateHUD(-16, 16)
end

hook.Add("HUDPaint", "SBR:HUD:Paint", HUD.Paint)


-- CreateHUD: Create the HUD
function HUD.CreateHUD(widthOffset, heightOffset)
  surface.SetDrawColor(255, 255, 255, 255)
  surface.SetMaterial(HUD.DASHBOARD.MATERIAL)
  surface.DrawTexturedRect(ScrW() - 256 + widthOffset, heightOffset, 256, 256)

  -- NEVER touch the offsets of this text or it will break!
  local mph = math.Round(LocalPlayer():GetNWFloat("SBR:Speed"))
  local formattedMph = FRMT.FormatHUDSpeed(mph)
  HUD.CreateSpeedText(formattedMph, HUD.COLORS.TEXT, ScrW() - 73, 40)

  local time = GetGlobalInt("SBR:RND:Timer", 0)
  local formattedTime = FRMT.FormatHUDTimer(time)
  HUD.CreateTimerText(formattedTime, HUD.COLORS.TEXT, ScrW() - 54, 114)
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
