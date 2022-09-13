NET = {

}

-- SendGamemodeMessage: Receives a simple game mode message
net.Receive("SendGamemodeMessage", function()
  local prefixColor = net.ReadColor()
  local message = net.ReadString()

  chat.AddText(prefixColor, CONSOLE.PREFIX, CONSOLE.COLORS.TEXT, message)
end)

-- SendRaceStartMessage: Receives a simple race start message
net.Receive("SendRaceStartMessage", function()
  local prefixColor = net.ReadColor()
  local round = net.ReadUInt(16)

  chat.AddText(
    prefixColor,
    CONSOLE.PREFIX,
    CONSOLE.COLORS.TEXT,
    "Race ",
    CONSOLE.COLORS.RACE_ROUND,
    "#" .. round,
    CONSOLE.COLORS.TEXT,
    " just begun!"
  )
end)
