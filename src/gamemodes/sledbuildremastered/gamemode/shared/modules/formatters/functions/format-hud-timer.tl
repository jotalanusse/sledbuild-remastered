require("shared/modules/formatters/types/formatters")

-- FormatHudTimer: Formats the time into "XXX"
function FORMATTERS.FormatHudTimer(time: number): string
  local formattedTime = gstring.format("%03i", time)

  return formattedTime
end