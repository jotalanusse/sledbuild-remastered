UPTIME = {
  WARNINGS = {
    FIRST = 6 * 60 * 60, -- Can't be more than 18 bits
    PERIODIC = 10 * 60, -- Can't be more than 18 bits
  }
}

-- Initialize: Called when we want the uptime functionality to start
function UPTIME.Initialize()
  timer.Create("SBR:FirstUptimeWarning", UPTIME.WARNINGS.FIRST, 1, UPTIME.FirstUptimeWarning)
end

hook.Add("PlayerInitialSpawn", "SBR:UPTIME:Bootstrap", UPTIME.Initialize)

-- FirstUptimeWarning: Called when the first uptime warning is reached
function UPTIME.FirstUptimeWarning()
  NET.BroadcastServerUptimeWarningMessage(UPTIME.WARNINGS.FIRST, UPTIME.WARNINGS.PERIODIC)

  timer.Create("SBR:PeriodicUptimeWarning", UPTIME.WARNINGS.PERIODIC, 0, UPTIME.BroadcastWarningMessage)
end

-- BroadcastWarningMessage: Boradcasts a server uptime warning message to all players
function UPTIME.BroadcastWarningMessage()
  NET.BroadcastServerUptimeWarningMessage(UPTIME.WARNINGS.FIRST, UPTIME.WARNINGS.PERIODIC)
end

