MSG = {}

function MSG.FormatTime(time)
  local timeTable = string.FormattedTime(time)
  local formattedTime = string.format("%02i:%02i.%03i", timeTable.m, timeTable.s, timeTable.ms * 10)

  return formattedTime
end