MENU = {
  UPDATE_FREQUENCY = 0.2, -- How often the menu is updated
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
  },
  LOGO = {
    MATERIAL = Material("gui/sledbuildremastered/sbr_logo.png")
  }
}

function MENU.Show()
  local baseFrame = MENU.CreateBaseFrame(MENU.SIZE.WIDTH, MENU.SIZE.HEIGHT_PERCENTAGE)

  local header = MENU.CreateHeader(baseFrame, MENU.HEADER.HEIGHT_PERCENTAGE)
  local scoreboard = SBRD.CreateScoreboard(baseFrame, SBRD.SIZE.WIDTH, SBRD.SIZE.HEIGHT_PERCENTAGE,
    MENU.HEADER.HEIGHT_PERCENTAGE)

  -- TODO: This feels way too primitive
  timer.Create("SBR:RefreshScoreboard", MENU.UPDATE_FREQUENCY, 0, function()
    if (IsValid(scoreboard)) then
      scoreboard:Remove()
      scoreboard = SBRD.CreateScoreboard(baseFrame, SBRD.SIZE.WIDTH, SBRD.SIZE.HEIGHT_PERCENTAGE,
        MENU.HEADER.HEIGHT_PERCENTAGE)
    end
  end)

  function MENU.Hide()
    timer.Remove("SBR:RefreshScoreboard")

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

-- Draw: Draws the whole menu
-- function MENU.Draw()
-- end

-- CreateBaseFrame: Create the base frame for almost all UI elements of the menu
function MENU.CreateBaseFrame(width, heightPercentage)
  local frame = vgui.Create("DFrame")
  HLPS.DisableFrameInteraction(frame)

  frame:SetSize(width, (ScrH() / 100) * heightPercentage)
  frame:Center()
  frame:MakePopup()

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, COLORS.INVISIBLE) -- TODO: Base frame must be invisible
  end

  return frame
end

-- CreateHeader: Create the header for the menu for things like logo and buttons
function MENU.CreateHeader(parent, heightPercentage)
  local borderFrame = vgui.Create("DFrame", parent)
  HLPS.DisableFrameInteraction(borderFrame)

  borderFrame:SetSize(parent:GetWide(), (parent:GetTall() / 100) * heightPercentage)

  borderFrame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, COLORS.INVISIBLE)

    surface.SetDrawColor(COLORS.MAIN)

    -- A quite primitive way of drawing a border without a side
    surface.DrawOutlinedRect(0, 0, w, 0, MENU.HEADER.BORDER_SIZE)
    surface.DrawOutlinedRect(0, 0, 0, h + MENU.HEADER.BORDER_SIZE, MENU.HEADER.BORDER_SIZE)
    surface.DrawOutlinedRect(w, 0, 0, h + MENU.HEADER.BORDER_SIZE, MENU.HEADER.BORDER_SIZE)
  end

  local headerFrame = vgui.Create("DFrame", borderFrame)
  HLPS.DisableFrameInteraction(headerFrame)

  headerFrame:SetSize(
    borderFrame:GetWide() - MENU.HEADER.BORDER_SIZE * 2,
    borderFrame:GetTall() - MENU.HEADER.BORDER_SIZE
  )
  headerFrame:SetPos(MENU.HEADER.BORDER_SIZE, MENU.HEADER.BORDER_SIZE)

  headerFrame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(32, 32, 32, 200))
  end

  local graphics = MENU.CreateHeaderGraphics(headerFrame, MENU.HEADER.GRAPHICS.WIDTH_PERCENTAGE)

  return borderFrame
end

-- CreateHeaderGraphics: Create the graphical elements for the header
function MENU.CreateHeaderGraphics(parent, widthPercentage)
  local frame = vgui.Create("DFrame", parent)
  HLPS.DisableFrameInteraction(frame)

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
  HLPS.DisableFrameInteraction(frame)

  frame:SetSize(width, height)
  frame:Center()

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, COLORS.INVISIBLE) -- TODO: Change color

    surface.SetDrawColor(255, 255, 255, 255)
    surface.SetMaterial(MENU.LOGO.MATERIAL)
    surface.DrawTexturedRect(0, 0, width, height)
  end

  return frame
end

-- CreateLogo: Create the credit
function MENU.CreateCredit(parent, height, offsetHeight)
  local frame = vgui.Create("DFrame", parent)
  HLPS.DisableFrameInteraction(frame)

  frame:SetSize(parent:GetWide(), height)
  frame:SetPos(0, offsetHeight)
  frame:CenterHorizontal()

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, COLORS.INVISIBLE) -- TODO: Change color
  end

  UI.CreateLabel(frame, "remake by jotalanusse")

  return frame
end
