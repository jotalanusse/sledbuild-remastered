-- BroadcastWarningMessage: Boradcasts a server uptime warning message to all players
function UPTIME.BroadcastWarningMessage()
  NET.BroadcastServerUptimeWarningMessage(UPTIME.WARNINGS.FIRST, UPTIME.WARNINGS.PERIODIC)
end
