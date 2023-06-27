require("shared/modules/formatters/types/formatters")

-- FormatMph: Formats MPH speed in the format "XXX MPH"
function FORMATTERS.FormatMph(mph: number): string
  local formattedSpeed = gstring.format("%i MPH", mph)

  return formattedSpeed
end
