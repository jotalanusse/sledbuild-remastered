SBRD = {
  SIZE = {
    WIDTH = 1000,
    HEIGHT_PERCENTAGE = 60,
    HEADER_HEIGHT = 35,
    ROW_HEIGHT = 25,
  },
  ROW_OPACITY = 150,
}

function SBRD.CreateScoreboard(parent, width, heightPercentage)
  local frame = vgui.Create("DFrame", parent)

  HLPS.DisableFrameIntercation(frame)

  frame:SetSize(width, (parent:GetWide() / 100) * heightPercentage)
  frame:Center()

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(32, 32, 32, 190)) -- TODO: Change color
  end

  return frame
end

function SBRD.CreatePlayerList(parent)
  local listHeaders = SBRD.CreateListHeaders(parent, SBRD.SIZE.HEADER_HEIGHT)

  local index = 1
  local offset = SBRD.SIZE.HEADER_HEIGHT

  -- TODO: Remove
  local testPlayers = {
    LocalPlayer(),
    LocalPlayer(),
    LocalPlayer(),
    LocalPlayer(),
    LocalPlayer(),
    LocalPlayer(),
    LocalPlayer(),
    LocalPlayer(),
    LocalPlayer(),
    LocalPlayer(),
    LocalPlayer(),
    LocalPlayer(),
    LocalPlayer(),
    LocalPlayer(),
    LocalPlayer(),
    LocalPlayer(),
  }

  for _, v in pairs(testPlayers) do
    local opacity = SBRD.ROW_OPACITY

    if (index % 2 == 0) then
      opacity = opacity / 2
    end

    local playerRow = SBRD.CreatePlayerRow(parent, SBRD.SIZE.ROW_HEIGHT, Color(32, 32,32, opacity), v)
    playerRow:SetPos(0, offset)

    index = index + 1
    offset = offset + playerRow:GetTall()
  end
end

function SBRD.CreateListHeaders(parent, height)
  local frame = vgui.Create("DFrame", parent)

  HLPS.DisableFrameIntercation(frame)

  frame:SetSize(parent:GetWide(), height)

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(32, 32, 32, 150)) -- TODO: Change color
  end

  local headers = {
    { "Name", 40, }, -- TODO: Find a way to align left
    { "Rounds", 6 },
    { "Wins", 6 },
    { "Podiums", 6 },
    { "Losses", 6 },
    { "Speed", 10 },
    { "Top Speed", 10 },
    { "Best Time", 10 },
    { "Ping", 6 },
  }

  local offset = 0
  for _, v in pairs(headers) do
    local header = SBRD.CreateHeader(frame, v[1], v[2], offset)
    offset = offset + v[2]
  end

  return frame
end

function SBRD.CreateHeader(parent, text, widthPercentage, offsetPercentage)
  local frame = vgui.Create("DFrame", parent)

  HLPS.DisableFrameIntercation(frame)

  frame:SetSize((parent:GetWide() / 100) * widthPercentage, parent:GetTall())
  frame:SetPos((parent:GetWide() / 100) * offsetPercentage, 0)

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(32, 32, 32, 0)) -- TODO: Change color
  end

  SBRD.CreateLabel(frame, text)

  return frame
end

function SBRD.CreatePlayerRow(parent, height, color, ply)
  local frame = vgui.Create("DFrame", parent)

  HLPS.DisableFrameIntercation(frame)

  frame:SetSize(parent:GetWide(), height)

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, color) -- TODO: Change color
  end

  local values = {
    { ply:Nick(), 40},
    { ply:GetNWInt("SBR:Rounds"), 6 },
    { ply:GetNWInt("SBR:Wins"), 6 },
    { ply:GetNWInt("SBR:Podiums"), 6 },
    { ply:GetNWInt("SBR:Losses"), 6 },
    { ply:GetNWFloat("SBR:Speed"), 10 },
    { ply:GetNWFloat("SBR:TopSpeed"), 10 },
    { ply:GetNWFloat("SBR:BestTime"), 10 },
    { ply:Ping(), 6 },
  }

  local index = 1
  local offset = 0
  for _, v in pairs(values) do
    local rowColumn = SBRD.CreateRowColumn(frame, v[1], v[2], offset)

    index = index + 1
    offset = offset + v[2]
  end

  return frame
end

function SBRD.CreateRowColumn(parent, text, widthPercentage, offsetPercentage)
  local frame = vgui.Create("DFrame", parent)

  HLPS.DisableFrameIntercation(frame)

  frame:SetSize((parent:GetWide() / 100) * widthPercentage, parent:GetTall())
  frame:SetPos((parent:GetWide() / 100) * offsetPercentage, 0)

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(32, 32, 32, 0)) -- TODO: Change color
  end

  SBRD.CreateLabel(frame, text)

  return frame
end

function SBRD.CreateLabel(parent, text)
  local label = vgui.Create("DLabel", parent)

  label:SetText(text)
  label:SetSize(parent:GetWide(), parent:GetTall())
  label:SetFont("DermaDefaultBold") -- TODO: Make global variable
  label:SetTextColor(Color(255, 255, 255, 255)) -- TODO: Change color
  label:SetContentAlignment(5)

  label:Center()

  return label
end
