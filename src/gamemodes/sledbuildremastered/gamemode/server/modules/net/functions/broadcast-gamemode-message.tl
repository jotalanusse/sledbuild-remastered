require("server/modules/net/types/net")
require("config/config")

-- BroadcastGamemodeMessage: Broadcast a simple gamemode message to all clients
function NET.BroadcastGamemodeMessage(message: string, color: ColorType)
  color = color or CONFIG.COLORS.MAIN

  net.Start("GamemodeMessage")
    net.WriteColor(color)
    net.WriteString(message)
  net.Broadcast()
end
