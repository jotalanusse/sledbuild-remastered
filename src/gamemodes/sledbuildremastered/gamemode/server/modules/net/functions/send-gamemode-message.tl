require("types/net")
require("config/config")

-- SendGamemodeMessage: Send a simple gamemode message to the client
function NET.SendGamemodeMessage(ply: Player, message: string, color: any)
  color = color or CONFIG.COLORS.MAIN

  net.Start("GamemodeMessage")
    net.WriteColor(color)
    net.WriteString(message)
  net.Send(ply)
end
