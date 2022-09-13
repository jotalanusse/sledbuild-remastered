NET = {

}

util.AddNetworkString("SendGamemodeMessage")
util.AddNetworkString("SendRaceStartMessage")

-- SendGamemodeMessage: Send a simple game mode message to the client
function NET.SendGamemodeMessage(ply, message, color)
  color = color or CONSOLE.COLORS.PREFIX

  net.Start("SendGamemodeMessage")
    net.WriteColor(color)
    net.WriteString(message)
  net.Send(ply)
end

-- BroadcastGamemodeMessage: Broadcast a simple game mode message to all clients
function NET.BroadcastGamemodeMessage(message, color)
  color = color or CONSOLE.COLORS.PREFIX

  net.Start("SendGamemodeMessage")
    net.WriteColor(color)
    net.WriteString(message)
  net.Broadcast()
end

-- BroadcastRaceStartMessage: Broadcast a race start to all clients
function NET.BroadcastRaceStartMessage(round, color)
  color = color or CONSOLE.COLORS.PREFIX

  net.Start("SendRaceStartMessage")
    net.WriteColor(color)
    net.WriteUInt(round, 16)
  net.Broadcast()
end
