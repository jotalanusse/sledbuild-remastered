NET = {}

-- Receives "GamemodeMessage" message
net.Receive("GamemodeMessage", function()
  local color = net.ReadColor()
  local message = net.ReadString()

  chat.AddText(color, CONSOLE.PREFIX, COLORS.TEXT, message)
end)

-- Receives "RaceStartMessage" message
net.Receive("RaceStartMessage", function()
  local round = net.ReadUInt(20)

  chat.AddText(
    COLORS.MAIN,
    CONSOLE.PREFIX,
    COLORS.TEXT,
    "Race ",
    COLORS.RACE.START,
    "#" .. round,
    COLORS.TEXT,
    " just begun!"
  )
end)

-- Receives "PlayerFinishedMessage"
net.Receive("PlayerFinishedMessage", function()
  local ply = net.ReadEntity()
  local position = net.ReadUInt(16)
  local time = net.ReadFloat()

  if (ply:SteamID() == LocalPlayer():SteamID()) then
    chat.AddText(
      COLORS.MAIN,
      CONSOLE.PREFIX,
      COLORS.TEXT,
      "Finished ",
      COLORS.RACE.START,
      "#" .. position,
      COLORS.TEXT,
      "! Your time is [",
      COLORS.RACE.START,
      FRMT.FormatTime(time),
      COLORS.TEXT,
      "]"
    )
  else
    chat.AddText(
      COLORS.MAIN,
      CONSOLE.PREFIX,
      COLORS.TEXT,
      ply:Nick() .. " Finished ",
      COLORS.RACE.START,
      "#" .. position,
      COLORS.TEXT,
      "! With a time of [",
      COLORS.RACE.START,
      FRMT.FormatTime(time),
      COLORS.TEXT,
      "]"
    )
  end
end)

-- Receives "CoinFlipMessage"
net.Receive("CoinFlipMessage", function ()
  local ply = net.ReadEntity()
  local result = net.ReadString()

  chat.AddText(
    COLORS.MAIN,
    CONSOLE.PREFIX,
    COLORS.TEXT,
    ply:Nick() .. " flipped a coin and got ",
    COLORS.GOLDEN,
    result,
    COLORS.TEXT,
    "!"
  )
end)

-- Receives "DiscordMessage"
net.Receive("DiscordMessage", function ()
  chat.AddText(
    COLORS.MAIN,
    CONSOLE.PREFIX,
    COLORS.TEXT,
    "Join the official SBR discord server at ",
    COLORS.GOLDEN,
    DISCORD.URL,
    COLORS.TEXT,
    "!"
  )

  gui.OpenURL(DISCORD.URL)
end)
