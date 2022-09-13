MENU = {
  SIZE = {
    WIDTH = 1000,
    HEIGHT_PERCENTAGE = 90,
  },
  HEADER = {
    HEIGHT_PERCENTAGE = 12,
    BORDER_SIZE = 4,
    GRAPHICS = {
      WIDTH_PERCENTAGE = 20,
    },
  }
}

function MENU.Show()

  local baseFrame = MENU.CreateBaseFrame(MENU.SIZE.WIDTH, MENU.SIZE.HEIGHT_PERCENTAGE)

  local header = MENU.CreateHeader(baseFrame, MENU.HEADER.HEIGHT_PERCENTAGE)
  local scoreboard = SBRD.CreateScoreboard(baseFrame, SBRD.SIZE.WIDTH, SBRD.SIZE.HEIGHT_PERCENTAGE,
    MENU.HEADER.HEIGHT_PERCENTAGE)

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
    draw.RoundedBox(0, 0, 0, w, h, Color(32, 32, 32, 0)) -- TODO: Base frame must be invisible
  end

  return frame
end

-- CreateHeader: Create the header for the menu for things like logo and buttons
function MENU.CreateHeader(parent, heightPercentage)
  local borderFrame = vgui.Create("DFrame", parent)
  HLPS.DisableFrameIntercation(borderFrame)

  borderFrame:SetSize(parent:GetWide(), (parent:GetTall() / 100) * heightPercentage)

  borderFrame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(32, 32, 32, 0))

    surface.SetDrawColor(COLORS.MAIN)
    surface.DrawOutlinedRect(0, 0, w, h, MENU.HEADER.BORDER_SIZE)
  end

  local headerFrame = vgui.Create("DFrame", borderFrame)
  HLPS.DisableFrameIntercation(headerFrame)

  headerFrame:SetSize(
    borderFrame:GetWide() - MENU.HEADER.BORDER_SIZE * 2,
    borderFrame:GetTall() - MENU.HEADER.BORDER_SIZE * 2
  )

  headerFrame:Center()

  headerFrame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(32, 32, 32, 100))
  end

  local graphics = MENU.CreateHeaderGraphics(headerFrame, MENU.HEADER.GRAPHICS.WIDTH_PERCENTAGE)

  return borderFrame
end

-- CreateHeaderGraphics: Create the graphical elements for the header
function MENU.CreateHeaderGraphics(parent, widthPercentage)
  local frame = vgui.Create("DFrame", parent)
  HLPS.DisableFrameIntercation(frame)

  frame:SetSize((parent:GetWide() / 100) * widthPercentage, parent:GetTall())
  frame:CenterVertical()

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(32, 32, 32, 150)) -- TODO: Change color
  end

  local logo = MENU.CreateLogo(frame, 128, 64)
  local logoX, logoY, logoW, logoH = logo:GetBounds()

  local credit = MENU.CreateCredit(frame, 20, logoY + logoH)
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
function MENU.CreateCredit(parent, height, offsetHeight)
  local frame = vgui.Create("DFrame", parent)
  HLPS.DisableFrameIntercation(frame)

  frame:SetSize(parent:GetWide(), height)
  frame:SetPos(0, offsetHeight)
  frame:CenterHorizontal()

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 255, 0)) -- TODO: Change color
  end

  UI.CreateLabel(frame, "a remake by jotalanusse")

  return frame
end
