FONTS = {
  DEFAULT = "SBR:Default",
  ARIALLARGE = "SBR:ArialLarge", -- used for server text
  HUD = {
    SPEED = "SBR:HUD:Speed",
    TIMER = "SBR:HUD:Timer",
  },
}

function CreateFonts()
  surface.CreateFont("SBR:Default", {
    font = "IBM Plex Mono",
    size = 17,
    weight = 500,
  })
  surface.CreateFont("SBR:ArialLarge", {
    font = "Arial",
    size = 50,
    weight = 500,
  })
  surface.CreateFont("SBR:HUD:Speed", {
    font = "DSEG7 Classic",
    size = 42,
    weight = 500,
  })

  surface.CreateFont("SBR:HUD:Timer", {
    font = "DSEG7 Classic",
    size = 28,
    weight = 500,
  })
end

CreateFonts()
