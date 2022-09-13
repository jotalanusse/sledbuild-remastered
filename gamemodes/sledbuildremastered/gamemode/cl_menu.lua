MENU = {
  SIZE = {
    WIDTH = 1000,
    HEIGHT_PERCENTAGE = 90,
  },
  HEADER = {
    HEIGHT_PERCENTAGE = 15,
  }
}

function MENU.Show()

  local baseFrame = MENU.CreateBaseFrame(MENU.SIZE.WIDTH, MENU.SIZE.HEIGHT_PERCENTAGE)

  local header = MENU.CreateHeader(baseFrame, MENU.HEADER.HEIGHT_PERCENTAGE)
  local scoreboard = SBRD.CreateScoreboard(baseFrame, SBRD.SIZE.WIDTH, SBRD.SIZE.HEIGHT_PERCENTAGE, MENU.HEADER.HEIGHT_PERCENTAGE)

  function MENU.Hide()
    baseFrame:Remove()

  end
end

-- ScoreboardShow: Override the default scoreboard
function GM:ScoreboardShow()
  MENU.Show()
end

-- ScoreboardHide: Override the default scoreboard
function GM:ScoreboardHide()
  MENU.Hide()
end

-- CreateBaseFrame: Create the base frame for almost all UI elements of the menu
function MENU.CreateBaseFrame(width, heightPercentage)
  local frame = vgui.Create("DFrame")
  HLPS.DisableFrameIntercation(frame)

  frame:SetSize(width, (ScrH() / 100) * heightPercentage)
  frame:Center()
  frame:MakePopup()

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(255, 32, 32, 0)) -- TODO: Base frame must be invisible
  end

  return frame
end

-- CreateHeader: Create the header for the menu for things like logo and buttons
function MENU.CreateHeader(parent, heightPercentage)
  local frame = vgui.Create("DFrame", parent)
  HLPS.DisableFrameIntercation(frame)

  frame:SetSize(parent:GetWide(), (parent:GetTall() / 100) * heightPercentage)

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(32, 255, 32, 0)) -- TODO: Header must be invisible
  end

  local logo = MENU.CreateLogo(frame, 256, 128)
  local credit = MENU.CreateCredit(frame, 256, 20)

  return frame
end

-- CreateLogo: Create the logo
function MENU.CreateLogo(parent, width, height)
  local frame = vgui.Create("DFrame", parent)
  HLPS.DisableFrameIntercation(frame)

  frame:SetSize(width, height)
  frame:Center()

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 255, 0)) -- TODO: Change color

    surface.SetDrawColor(255, 255, 255, 255)
    surface.SetMaterial(Material("gui/sledbuildremastered/sbr_logo.png"))
    surface.DrawTexturedRect(0, 0, width, height)
  end

  return frame
end

-- CreateLogo: Create the credit
function MENU.CreateCredit(parent, width, height)
  local frame = vgui.Create("DFrame", parent)
  HLPS.DisableFrameIntercation(frame)

  frame:SetSize(width, height)
  frame:CenterHorizontal()

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 255, 50)) -- TODO: Change color
  end

  UI.CreateLabel(frame, "a remake by jotalanusse")

  return frame
end
