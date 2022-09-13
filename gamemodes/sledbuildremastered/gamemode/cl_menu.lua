MENU = {
  SIZE = {
    WIDTH = 1000,
    HEIGHT_PERCENTAGE = 90,
  },
}

function MENU.Show()

  local basePanel = MENU.CreateBasePanel(MENU.SIZE.WIDTH, MENU.SIZE.HEIGHT_PERCENTAGE)
  local scoreboard = SBRD.CreateScoreboard(basePanel, SBRD.SIZE.WIDTH, SBRD.SIZE.HEIGHT_PERCENTAGE)

  function MENU.Hide()
    basePanel:Remove()
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

-- CreateBasePanel: Create the base panel for almost all UI elements of the menu
function MENU.CreateBasePanel(width, heightPercentage)
  local frame = vgui.Create("DFrame")
  HLPS.DisableFrameIntercation(frame)

  frame:SetSize(width, (ScrH() / 100) * heightPercentage)
  frame:Center()
  frame:MakePopup()

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(255, 32, 32, 10)) -- TODO: Base panel must be invisible
  end

  return frame
end
