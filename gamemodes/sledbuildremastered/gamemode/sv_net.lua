NET = {

}

util.AddNetworkString("SendGamemodeMessage")

-- SendGamemodeMessage: Send a simple game mode message to the client
function NET.SendGamemodeMessage(ply, message, color)
  color = color or CONSOLE.COLORS.PREFIX

  net.Start("SendGamemodeMessage")
  net.WriteColor(color)
  net.WriteString(message)
  net.Send(ply)
end

function NET.BroadcastGamemodeMessage(message, color)
  color = color or CONSOLE.COLORS.PREFIX

  net.Start("SendGamemodeMessage")
  net.WriteColor(color)
  net.WriteString(message)
  net.Broadcast()
end
