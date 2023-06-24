require("types/net")
require("config/config")

-- SendGamemodeMessage: Send a simple gamemode message to the client
function NET.SendGamemodeMessage(ply: PlayerType, message: string, color: ColorType)
  color = color or CONFIG.COLORS.MAIN

  net.Start("GamemodeMessage")
    net.WriteColor(color)
    net.WriteString(message)
  net.Send(ply)
end
