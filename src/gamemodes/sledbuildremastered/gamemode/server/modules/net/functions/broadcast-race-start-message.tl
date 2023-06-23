require("types/net")
require("config/config")

-- BroadcastRaceStartMessage: Broadcast a race start to all clients
function NET.BroadcastRaceStartMessage(round: integer)
  net.Start("RaceStartMessage")
    net.WriteUInt(round, 20) -- No one is going to play ONE MILLION rounds, right? 
  net.Broadcast()
end
