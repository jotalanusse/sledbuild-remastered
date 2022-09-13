SBRD = {
  SIZE = {
    WIDTH = 1000,
    HEIGHT_PERCENTAGE = 60,
    HEADER_HEIGHT = 35,
    ROW_HEIGHT = 25,
  },
  ROW_OPACITY = 150,
}

TEST = {
  PLAYERS = {
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
}


-- CreateScoreboard: Create the scoreboard
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

-- CreatePlayerList: Create the player list (all elements)
function SBRD.CreatePlayerList(parent)
  local columnWidthPercentages = { 40, 6, 6, 6, 6, 10, 10, 10, 6, }

  local height = SBRD.SIZE.HEADER_HEIGHT + SBRD.SIZE.ROW_HEIGHT * #player.GetAll()
  SBRD.CreateColumnShaders(parent, columnWidthPercentages, height)

  local listHeaders = SBRD.CreateListHeaders(parent, columnWidthPercentages, SBRD.SIZE.HEADER_HEIGHT)
  local listRows = SBRD.CreateListRows(parent, columnWidthPercentages, SBRD.SIZE.ROW_HEIGHT)
end

-- CreateListHeaders: Create the list headers
function SBRD.CreateListHeaders(parent, widthPercentages, height)
  local frame = vgui.Create("DFrame", parent)
  HLPS.DisableFrameIntercation(frame)

  frame:SetSize(parent:GetWide(), height)

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(32, 32, 32, 150)) -- TODO: Change color
  end

  local headers = {
    "Name",
    "Rounds",
    "Wins",
    "Podiums",
    "Losses",
    "Speed",
    "Top Speed",
    "Best Time",
    "Ping",
  }


  local offset = 0
  for i = 1, #headers, 1 do
    local header = SBRD.CreateHeader(frame, headers[i], widthPercentages[i], offset)

    offset = offset + widthPercentages[i]
  end

  return frame
end

-- CreateHeader: Create each specific header
function SBRD.CreateHeader(parent, text, widthPercentage, offsetPercentage)
  local frame = vgui.Create("DFrame", parent)
  HLPS.DisableFrameIntercation(frame)

  frame:SetSize((parent:GetWide() / 100) * widthPercentage, parent:GetTall())
  frame:SetPos((parent:GetWide() / 100) * offsetPercentage, 0)

  frame.Paint = function(self, w, h)
    local headerColor = COLORS.MAIN
    headerColor.a = 100

    draw.RoundedBox(0, 0, 0, w, h, headerColor) -- TODO: Change color
  end

  SBRD.CreateLabel(frame, text)

  return frame
end

function SBRD.CreateListRows(parent, widthPercentages, rowHeight)
  local rows = {}

  local index = 1
  local offset = SBRD.SIZE.HEADER_HEIGHT
  for _, v in pairs(player.GetAll()) do
    local opacity = SBRD.ROW_OPACITY

    if (index % 2 == 0) then
      opacity = opacity / 2
    end

    local playerRow = SBRD.CreatePlayerRow(parent, widthPercentages, rowHeight, Color(32, 32, 32, opacity), v)
    playerRow:SetPos(0, offset)

    rows[index] = playerRow

    index = index + 1
    offset = offset + rowHeight
  end

  return rows
end

-- CreatePlayerRow: Create a enw player row
function SBRD.CreatePlayerRow(parent, widthPercentages, height, color, ply)
  local frame = vgui.Create("DFrame", parent)
  HLPS.DisableFrameIntercation(frame)

  frame:SetSize(parent:GetWide(), height)

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, color) -- TODO: Change color
  end

  local values = {
    ply:Nick(),
    ply:GetNWInt("SBR:Rounds"),
    ply:GetNWInt("SBR:Wins"),
    ply:GetNWInt("SBR:Podiums"),
    ply:GetNWInt("SBR:Losses"),
    ply:GetNWFloat("SBR:Speed"),
    ply:GetNWFloat("SBR:TopSpeed"),
    ply:GetNWFloat("SBR:BestTime"),
    ply:Ping(),
  }

  local offset = 0
  for i = 1, #values, 1 do
    local rowColumn = SBRD.CreateRowColumn(frame, values[i], widthPercentages[i], offset)

    offset = offset + widthPercentages[i]
  end

  return frame
end

-- CreateRowColumn: Create each new row column
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

-- CreateColumnShaders: Create the column shaders for easy column identification
function SBRD.CreateColumnShaders(parent, widthPercentages, height)
  local frame = vgui.Create("DFrame", parent)
  HLPS.DisableFrameIntercation(frame)

  frame:SetSize(parent:GetWide(), height)

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(32, 32, 32, 0)) -- TODO: Change color
  end

  local offsetPercentage = 0
  for i = 1, #widthPercentages do
    if (i % 2 == 0) then
      SBRD.CreateColumnShader(frame, widthPercentages[i], offsetPercentage)
    end

    offsetPercentage = offsetPercentage + widthPercentages[i]
  end
end

-- CreateColumnShader: Create a single column shader
function SBRD.CreateColumnShader(parent, widthPercentage, offsetPercentage)
  local frame = vgui.Create("DFrame", parent)
  HLPS.DisableFrameIntercation(frame)

  frame:SetSize((parent:GetWide() / 100) * widthPercentage, parent:GetTall())
  frame:SetPos((parent:GetWide() / 100) * offsetPercentage, 0)

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(32, 32, 32, 100)) -- TODO: Change color
  end
end

-- CreateLabel: Create a new label
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
