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
function SBRD.CreateScoreboard(parent, width, heightPercentage, heightOffsetPercentage)
  local frame = vgui.Create("DFrame", parent)
  HLPS.DisableFrameInteraction(frame)

  frame:SetSize(width, (parent:GetWide() / 100) * heightPercentage)
  frame:SetPos(0, (parent:GetTall() / 100) * heightOffsetPercentage)

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, UI.COLORS.BACKGROUND) -- TODO: Change color
  end

  local playerList = SBRD.CreatePlayerList(frame)

  return frame
end

-- CreatePlayerList: Create the player list (all elements)
function SBRD.CreatePlayerList(parent)
  local columnWidthPercentages = { 40, 6, 6, 6, 6, 10, 10, 10, 6, }

  local headerBackground = SBRD.CreateHeaderBackground(parent, SBRD.SIZE.HEADER_HEIGHT, COLORS.MAIN)

  -- We create the shaders first to avoid the text from being affected
  local height = SBRD.SIZE.HEADER_HEIGHT + SBRD.SIZE.ROW_HEIGHT * #player.GetAll()
  SBRD.CreateColumnShaders(parent, columnWidthPercentages, height)

  local listHeader = SBRD.CreateListHeader(parent, columnWidthPercentages, SBRD.SIZE.HEADER_HEIGHT)
  local listRows = SBRD.CreateListRows(parent, columnWidthPercentages, SBRD.SIZE.ROW_HEIGHT)
end

-- CreateHeaderBackground: Create the header background
function SBRD.CreateHeaderBackground(parent, height, color)
  local frame = vgui.Create("DFrame", parent)
  HLPS.DisableFrameInteraction(frame)

  frame:SetSize(parent:GetWide(), height)

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, color) -- TODO: Change color
  end

  return frame
end

-- CreateListHeader: Create the list header
function SBRD.CreateListHeader(parent, widthPercentages, height)
  local frame = vgui.Create("DFrame", parent)
  HLPS.DisableFrameInteraction(frame)

  frame:SetSize(parent:GetWide(), height)

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, UI.COLORS.INVISIBLE) -- TODO: Change color
  end

  local headers = {
    "Name",
    "Wins",
    "Podiums",
    "Losses",
    "Total",
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
  HLPS.DisableFrameInteraction(frame)

  frame:SetSize((parent:GetWide() / 100) * widthPercentage, parent:GetTall())
  frame:SetPos((parent:GetWide() / 100) * offsetPercentage, 0)

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, UI.COLORS.INVISIBLE)
  end

  UI.CreateLabel(frame, text)

  return frame
end

function SBRD.CreateListRows(parent, widthPercentages, rowHeight)
  local rows = {}

  local offset = SBRD.SIZE.HEADER_HEIGHT
  for i, v in ipairs(player.GetAll()) do
    local opacity = SBRD.ROW_OPACITY

    if (i % 2 == 0) then
      opacity = opacity / 2
    end

    local playerRow = SBRD.CreatePlayerRow(parent, widthPercentages, rowHeight, Color(32, 32, 32, opacity), v) -- TODO: Change color
    playerRow:SetPos(0, offset)

    rows[i] = playerRow
    offset = offset + rowHeight
  end

  return rows
end

-- CreatePlayerRow: Create a enw player row
function SBRD.CreatePlayerRow(parent, widthPercentages, height, color, ply)
  local frame = vgui.Create("DFrame", parent)
  HLPS.DisableFrameInteraction(frame)

  frame:SetSize(parent:GetWide(), height)

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, color) -- TODO: Change color
  end

  local values = {
    ply:Nick(),
    ply:GetNWInt("SBR:Wins"),
    ply:GetNWInt("SBR:Podiums"),
    ply:GetNWInt("SBR:Losses"),
    ply:GetNWInt("SBR:Rounds"),
    FRMT.FormatSpeed(ply:GetNWFloat("SBR:Speed")),
    FRMT.FormatSpeed(ply:GetNWFloat("SBR:TopSpeed")),
    FRMT.FormatTime(ply:GetNWFloat("SBR:BestTime")),
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
  HLPS.DisableFrameInteraction(frame)

  frame:SetSize((parent:GetWide() / 100) * widthPercentage, parent:GetTall())
  frame:SetPos((parent:GetWide() / 100) * offsetPercentage, 0)

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, UI.COLORS.INVISIBLE) -- TODO: Change color
  end

  UI.CreateLabel(frame, text)

  return frame
end

-- CreateColumnShaders: Create the column shaders for easy column identification
function SBRD.CreateColumnShaders(parent, widthPercentages, height)
  local frame = vgui.Create("DFrame", parent)
  HLPS.DisableFrameInteraction(frame)

  frame:SetSize(parent:GetWide(), height)

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, UI.COLORS.INVISIBLE) -- TODO: Change color
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
  HLPS.DisableFrameInteraction(frame)

  frame:SetSize((parent:GetWide() / 100) * widthPercentage, parent:GetTall())
  frame:SetPos((parent:GetWide() / 100) * offsetPercentage, 0)

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, UI.COLORS.SHADER) -- TODO: Change color
  end
end
