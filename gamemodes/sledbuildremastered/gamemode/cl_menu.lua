MENU = {
  SIZE = {
    WIDTH = 1000,
    HEIGHT_PERCENTAGE = 80,
  },
}

SCOREBOARD = {
  SIZE = {
    WIDTH = 1000,
    HEIGHT_PERCENTAGE = 60,
    HEADER_HEIGHT = 35,
  },
}

local menu = menu or {}

function menu:show()

  local basePanel = CreateBasePanel(MENU.SIZE.WIDTH, MENU.SIZE.HEIGHT_PERCENTAGE)
  local scoreboard = CreateScoreboard(basePanel, SCOREBOARD.SIZE.WIDTH, SCOREBOARD.SIZE.HEIGHT_PERCENTAGE)
  local playerList = CreatePlayerList(scoreboard)

  function menu:hide()
    basePanel:Remove()
  end
end

function GM:ScoreboardShow()
  menu:show()
end

function GM:ScoreboardHide()
  menu:hide()
end

-- CreateBasePanel: Create the base panel for almost all UI elements of the scoreboard
function CreateBasePanel(width, heightPercentage)
  local frame = vgui.Create("DFrame")

  DisableIntercation(frame)

  frame:SetSize(width, (ScrH() / 100) * heightPercentage)

  frame:Center()
  frame:MakePopup()

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(32, 32, 32, 100)) -- TODO: Base panel must be invisible
  end

  return frame
end

function CreateScoreboard(parent, width, heightPercentage)
  local frame = vgui.Create("DFrame", parent)

  DisableIntercation(frame)

  frame:SetSize(width, (parent:GetWide() / 100) * heightPercentage)
  frame:Center()

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(32, 32, 32, 191)) -- TODO: Change color
  end

  return frame
end

function CreatePlayerList(parent)
  local listHeaders = CreateListHeaders(parent, SCOREBOARD.SIZE.HEADER_HEIGHT)

  -- local lisetView = vgui.Create("DListView", parent)
  -- lisetView:Dock(FILL)
  -- lisetView:SetMultiSelect(false)
  -- lisetView:SetSortable(false)

  -- lisetView:AddColumn("Application")
  -- lisetView:AddColumn("Size")

  -- lisetView:AddLine("PesterChum", "2mb")
  -- lisetView:AddLine("Lumitorch", "512kb")
  -- lisetView:AddLine("Troj-on", "661kb")

  -- lisetView.Paint = function(self, w, h)
  --   draw.RoundedBox(0, 0, 0, w, h, Color(32, 32, 32, 191)) -- TODO: Change color
  -- end
end

function CreateListHeaders(parent, height)
  local frame = vgui.Create("DFrame", parent)

  DisableIntercation(frame)

  frame:SetSize(parent:GetWide(), height)

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(255, 32, 32, 191)) -- TODO: Change color
  end

  print(frame:GetWide())

  -- I don't want to touch this ever again
  CreateHeader(frame, "Name", 40, 0)
  CreateHeader(frame, "Rounds", 6, 40)
  CreateHeader(frame, "Wins", 6, 46)
  CreateHeader(frame, "Podiums", 6, 52)
  CreateHeader(frame, "Losses", 6, 58)
  CreateHeader(frame, "Speed", 10, 64)
  CreateHeader(frame, "Top Speed", 10, 74)
  CreateHeader(frame, "Best Time", 10, 84)
  CreateHeader(frame, "Ping", 6, 94)

  return frame
end

function CreateHeader(parent, text, widthPercentage, offsetPercentage)
  local frame = vgui.Create("DFrame", parent)

  DisableIntercation(frame)

  frame:SetSize((parent:GetWide() / 100) * widthPercentage, parent:GetTall())
  frame:SetPos((parent:GetWide() / 100) * offsetPercentage, 0)

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(32, 100, 32, 191)) -- TODO: Change color
  end

  CreateLabel(frame, text)

  return frame
end

function CreateListRow(parent, height, ply)
  local frame = vgui.Create("DFrame", parent)

  DisableIntercation(frame)

  frame:SetSize(parent:GetWide(), height)

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(255, 32, 32, 191)) -- TODO: Change color
  end

  print(frame:GetWide())

  local headers = {
    { "Name", 40 },
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
  for k, v in pairs(headers) do
    local header = CreateHeader(frame, v[1], v[2], offset)
    offset = offset + v[2]
  end

  return frame
end

function CreateRowColumn(parent, text, widthPercentage, offsetPercentage)
  local frame = vgui.Create("DFrame", parent)

  DisableIntercation(frame)

  frame:SetSize((parent:GetWide() / 100) * widthPercentage, parent:GetTall())
  frame:SetPos((parent:GetWide() / 100) * offsetPercentage, 0)

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(32, 32, 100, 191)) -- TODO: Change color
  end

  CreateLabel(frame, text)

  return frame
end

function CreateLabel(parent, text)
  local label = vgui.Create("DLabel", parent)

  label:SetText(text)
  label:SetFont("DermaDefaultBold") -- TODO: Make global variable
  label:SetTextColor(Color(255, 255, 255, 255))
  label:SetContentAlignment(5)

  label:Center()

  return label
end

function DisableIntercation(frame)
  frame:SetTitle("")
  frame:ShowCloseButton(false)
  frame:SetDraggable(false)
end
