require("server/modules/uptime/types/uptime")
require("server/modules/net/types/net")

-- BroadcastWarningMessage: Boradcasts a server uptime warning message to all players
function UPTIME.BroadcastWarningMessage()
  NET.BroadcastServerUptimeWarningMessage(UPTIME.CONFIG.WARNINGS.INITIAL, UPTIME.CONFIG.WARNINGS.PERIODIC)
end
