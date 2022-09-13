MENU = {
  SIZE = {
    WIDTH = 1000,
    HEIGHT_PERCENTAGE = 80,
  },
}

local menu = menu or {}

function menu:show()

  local basePanel = MENU.CreateBasePanel(MENU.SIZE.WIDTH, MENU.SIZE.HEIGHT_PERCENTAGE)
  local scoreboard = SBRD.CreateScoreboard(basePanel, SBRD.SIZE.WIDTH, SBRD.SIZE.HEIGHT_PERCENTAGE)
  local playerList = SBRD.CreatePlayerList(scoreboard)

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

-- CreateBasePanel: Create the base panel for almost all UI elements of the menu
function MENU.CreateBasePanel(width, heightPercentage)
  local frame = vgui.Create("DFrame")

  HLPS.DisableFrameIntercation(frame)

  frame:SetSize(width, (ScrH() / 100) * heightPercentage)
  frame:Center()
  frame:MakePopup()

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(32, 32, 32, 0)) -- TODO: Base panel must be invisible
  end

  return frame
end
