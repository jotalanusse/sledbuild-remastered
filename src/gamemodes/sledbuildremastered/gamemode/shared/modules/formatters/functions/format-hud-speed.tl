require("shared/modules/formatters/types/formatters")

-- FormatHudSpeed: Formats speed in the format "XXX"
function FORMATTERS.FormatHudSpeed(speed: number): string
  local formattedSpeed = gstring.format("%03i", speed)

  return formattedSpeed
end