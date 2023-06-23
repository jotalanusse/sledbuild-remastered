require("uptime")

-- Initialize: Called when we want the module functionality to start
function UPTIME.Initialize()
  timer.Create("SBR:FirstUptimeWarning", UPTIME.CONFIG.WARNINGS.INITIAL, 1, UPTIME.FirstUptimeWarning)
end
