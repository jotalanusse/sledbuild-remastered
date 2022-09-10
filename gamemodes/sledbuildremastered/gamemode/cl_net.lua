NET = {

}

net.Receive("SendGamemodeMessage", function()
  local message = net.ReadString()
  chat.AddText(CONSOLE.PREFIX_COLOR, CONSOLE.PREFIX, CONSOLE.TEXT_COLOR, message)
end)
