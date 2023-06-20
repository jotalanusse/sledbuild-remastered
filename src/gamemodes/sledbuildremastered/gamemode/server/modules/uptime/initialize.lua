-- Initialize: Called when we want the uptime functionality to start
function UPTIME.Initialize()
  timer.Create("SBR:FirstUptimeWarning", UPTIME.WARNINGS.FIRST, 1, UPTIME.FirstUptimeWarning)
end
