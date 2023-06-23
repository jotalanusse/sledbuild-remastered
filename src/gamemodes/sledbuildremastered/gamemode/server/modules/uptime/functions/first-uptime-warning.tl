require("types/uptime")

-- FirstUptimeWarning: Called when the first uptime warning is reached
function UPTIME.FirstUptimeWarning()
  -- NET.BroadcastServerUptimeWarningMessage(UPTIME.CONFIG.WARNINGS.INITIAL, UPTIME.CONFIG.WARNINGS.PERIODIC)

  timer.Create("SBR:PeriodicUptimeWarning", UPTIME.CONFIG.WARNINGS.PERIODIC, 0, UPTIME.BroadcastWarningMessage)
end
