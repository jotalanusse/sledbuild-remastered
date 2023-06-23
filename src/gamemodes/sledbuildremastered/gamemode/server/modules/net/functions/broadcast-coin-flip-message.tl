require("types/net")
require("config/config")

-- BroadcastCoinFlipMessage: Broadcast a coin flip to all clients
function NET.BroadcastCoinFlipMessage(ply: Player, result: string)
  net.Start("CoinFlipMessage")
    net.WriteEntity(ply)
    net.WriteString(result)
  net.Broadcast()
end
