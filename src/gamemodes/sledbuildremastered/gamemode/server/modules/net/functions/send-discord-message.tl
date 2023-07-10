require("server/modules/net/types/net")
require("config/config")

-- SendDiscordMessage: Send a discord server message to the client
function NET.SendDiscordMessage(ply: PlayerType)
  net.Start("SBR:DiscordMessage")
  net.Send(ply)
end
