NET = {}

-- Add the messages we are going to use
-- Game mode
util.AddNetworkString("GamemodeMessage")
util.AddNetworkString("RaceStartMessage")
util.AddNetworkString("PlayerFinishedMessage")
util.AddNetworkString("ServerUptimeWarningMessage")

-- Commands
util.AddNetworkString("CoinFlipMessage")
util.AddNetworkString("DiscordMessage")


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
    net.WriteUInt(round, 20) -- No one is going to play ONE MILLION rounds, right? 
  net.Broadcast()
end

-- BroadcastPlayerFinishedMessage: Broadcasts that a player has finished the race
function NET.BroadcastPlayerFinishedMessage(ply, position, time)
  net.Start("PlayerFinishedMessage")
    net.WriteEntity(ply)
    net.WriteUInt(position, 16) -- There won't be more than 65535 players racing
    net.WriteFloat(time)
  net.Send(ply)
end

-- BroadcastServerUptimeWarningMessage: Broadcast a server uptime warning to all clients
function NET.BroadcastServerUptimeWarningMessage(first, periodic)
  net.Start("ServerUptimeWarningMessage")
    net.WriteUInt(first, 18)
    net.WriteUInt(periodic, 18)
  net.Broadcast()
end

-- BroadcastCoinFlipMessage: Broadcast a coin flip to all clients
function NET.BroadcastCoinFlipMessage(ply, result)
  net.Start("CoinFlipMessage")
    net.WriteEntity(ply)
    net.WriteString(result)
  net.Broadcast()
end

-- SendDiscordMessage: Send a discord server message to the client
function NET.SendDiscordMessage(ply)
  net.Start("DiscordMessage")
  net.Send(ply)
end
