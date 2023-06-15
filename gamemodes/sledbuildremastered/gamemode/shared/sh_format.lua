FRMT = {}

-- FormatTime: Formats the time into a nice string
function FRMT.FormatTime(time)
  local timeTable = string.FormattedTime(time)
  local formattedTime = string.format("%02i:%02i.%03i", timeTable.m, timeTable.s, timeTable.ms * 10)

  return formattedTime
end

-- FormatTimeBig: Formats the time into a nice string
function FRMT.FormatTimeBig(time)
  local formattedTime = string.FormattedTime(time, "%02i:%02i:%02i")

  return formattedTime
end

-- FormatSpeed: Formats the speed into a nice string
function FRMT.FormatSpeed(mph)
  local formattedSpeed = string.format("%i MPH", mph)

  return formattedSpeed
end

-- FormatHUDSpeed: Formats the speed into a nice 3 digits
function FRMT.FormatHUDSpeed(mph)
  local formattedSpeed = string.format("%03i", mph)

  return formattedSpeed
end

-- FormatHUDTimer: Formats the timer into a nice 3 digits
function FRMT.FormatHUDTimer(time)
  local formattedTime = string.format("%03i", time)

  return formattedTime
end
