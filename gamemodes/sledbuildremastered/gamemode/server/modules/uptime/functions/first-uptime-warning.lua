-- FirstUptimeWarning: Called when the first uptime warning is reached
function UPTIME.FirstUptimeWarning()
  NET.BroadcastServerUptimeWarningMessage(UPTIME.WARNINGS.FIRST, UPTIME.WARNINGS.PERIODIC)

  timer.Create("SBR:PeriodicUptimeWarning", UPTIME.WARNINGS.PERIODIC, 0, UPTIME.BroadcastWarningMessage)
end
