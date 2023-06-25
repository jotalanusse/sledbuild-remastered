require("server/modules/net/types/net")
require("config/config")

-- BroadcastPlayerFinishedMessage: Broadcasts that a player has finished the race
function NET.BroadcastPlayerFinishedMessage(ply: PlayerType, position: integer, time: number)
  net.Start("PlayerFinishedMessage")
    net.WriteEntity(ply)
    net.WriteUInt(position, 16) -- There won't be more than 65535 players racing
    net.WriteFloat(time)
  net.Send(ply)
end
