require("shared/modules/formatters/types/formatters")

-- FormatTime: Formats a race time in the format "hh:mm:ss"
function FORMATTERS.FormatTime(time: number): string
  local formattedTime = gstring.FormattedTime(time, "%02i:%02i:%02i") as string

  return formattedTime
end
