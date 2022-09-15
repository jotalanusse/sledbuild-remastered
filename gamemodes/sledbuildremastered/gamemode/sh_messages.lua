MSG = {}

-- FormatTime: Formats the time into a nice string
function MSG.FormatTime(time)
  local timeTable = string.FormattedTime(time)
  local formattedTime = string.format("%02i:%02i.%03i", timeTable.m, timeTable.s, timeTable.ms * 10)

  return formattedTime
end

-- FormatSpeed: Formats the speed into a nice string
function MSG.FormatSpeed(mph)
  local formattedSpeed = string.format("%i MPH", mph)

  return formattedSpeed
end