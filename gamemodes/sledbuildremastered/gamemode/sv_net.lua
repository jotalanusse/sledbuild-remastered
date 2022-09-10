NET = {

}

-- StripLoadout: Remove the player's loadout completely
function NET.SendGamemodeMessage()
  net.Start("SendGamemodeMessage")
  net.WriteString("You have been stripped of your loadout.")
  net.Send(ply)
end

function NET.BroadcastGamemodeMessage()
  net.Start("SendGamemodeMessage")
  net.WriteString("You have been stripped of your loadout.")
  net.Send(ply)
end
