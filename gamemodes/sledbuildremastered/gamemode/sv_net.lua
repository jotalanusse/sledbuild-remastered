NET = {}

-- Add the messages we are going to use
util.AddNetworkString("GamemodeMessage")
util.AddNetworkString("RaceStartMessage")
util.AddNetworkString("PlayerFinishedMessage")

-- SendGamemodeMessage: Send a simple gamemode message to the client
function NET.SendGamemodeMessage(ply, message, color)
  color = color or COLORS.MAIN

  net.Start("GamemodeMessage")
    net.WriteColor(color)
    net.WriteString(message)
  net.Send(ply)
end

-- BroadcastGamemodeMessage: Broadcast a simple gamemode message to all clients
function NET.BroadcastGamemodeMessage(message, color)
  color = color or COLORS.MAIN

  net.Start("GamemodeMessage")
    net.WriteColor(color)
    net.WriteString(message)
  net.Broadcast()
end

-- BroadcastRaceStartMessage: Broadcast a race start to all clients
function NET.BroadcastRaceStartMessage(round)
  net.Start("RaceStartMessage")
    net.WriteUInt(round, 16)
  net.Broadcast()
end

-- BroadcastPlayerFinishedMessage: Broadcasts that a player has finished the race
function NET.BroadcastPlayerFinishedMessage(ply, position, time)
  net.Start("PlayerFinishedMessage")
    net.WriteEntity(ply)
    net.WriteUInt(position, 12) -- There won't be more than 4095 players racing
    net.WriteFloat(time)
  net.Send(ply)
end
