require("shared/modules/formatters/types/formatters")

-- FormatRaceTime: Formats a race time in the format "mm:ss.ms"
function FORMATTERS.FormatRaceTime(time: number): string
  local timeTable = string.FormattedTime(time)
  local formattedTime = string.format("%02i:%02i.%03i", timeTable.m, timeTable.s, timeTable.ms * 10)

  return formattedTime
end
