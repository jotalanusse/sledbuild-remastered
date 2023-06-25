require("server/modules/net/types/net")
require("config/config")

-- BroadcastServerUptimeWarningMessage: Broadcast a server uptime warning to all clients
function NET.BroadcastServerUptimeWarningMessage(initial: integer, periodic: integer)
  net.Start("ServerUptimeWarningMessage")
    net.WriteUInt(initial, 18)
    net.WriteUInt(periodic, 18)
  net.Broadcast()
end
