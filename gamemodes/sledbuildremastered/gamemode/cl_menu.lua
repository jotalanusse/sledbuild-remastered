MENU = {
  SIZE = {
    WIDTH = 50,
    HEIGHT = 80,
  },
}

scoreboard = scoreboard or {}

function scoreboard:show()

  local basePanel = CreateBasePanel()

  function scoreboard:hide()
    basePanel:Remove()
  end
end

function GM:ScoreboardShow()
  scoreboard:show()
end

function GM:ScoreboardHide()
  scoreboard:hide()
end

-- CreateBasePanel: Create the base panel for almost all UI elements of the scoreboard
function CreateBasePanel()
  local frame = vgui.Create("DFrame")

  frame:SetTitle("")
  frame:SetSize((ScrW() / 100) * 50, (ScrH() / 100) * 80)

  frame:Center()
  frame:MakePopup()

  frame:ShowCloseButton(false)
  frame:SetDraggable(false)

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(32, 32, 32, 191))
  end

  return frame
end

function CreateScoreboard()
  local frame = vgui.Create("DFrame")
  
  frame:SetTitle("Scoreboard")
  frame:SetSize(960, 300)
  frame:Center()
  frame:MakePopup()

  frame:ShowCloseButton(false)
  frame:SetDraggable(false)

  frame.Paint = function(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(32, 32, 32, 191))
  end

  return frame
end