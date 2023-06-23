local COLORS <const> = {
  RACE = {
    START = Color(0, 200, 0)
  },
  MAIN = Color(150, 0, 255), -- Main gamemode color
  WARNING = Color(220, 220, 0), -- Warning color
  ERROR = Color(220, 0, 0), -- Error color

  TEXT = Color(220, 220, 220), -- TODO: Find the best color for the console text

  GOLDEN = Color(255, 215, 0), -- Golden color

  PULSATING = {
    FREQUENCY = 1,
    MIN_ALPHA = 100,
  }
}

return COLORS
