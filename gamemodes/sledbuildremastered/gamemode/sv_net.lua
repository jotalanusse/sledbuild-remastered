NET = {

}

util.AddNetworkString("SendGamemodeMessage")

-- SendGamemodeMessage: Send a simple game mode message to the client
function NET.SendGamemodeMessage(ply, message)
  net.Start("SendGamemodeMessage")
  net.WriteString(message)
  net.Send(ply)
end

-- function NET.BroadcastGamemodeMessage()
--   net.Start("SendGamemodeMessage")
--   net.WriteString("You have been stripped of your loadout.")
--   net.Send(ply)
-- end
