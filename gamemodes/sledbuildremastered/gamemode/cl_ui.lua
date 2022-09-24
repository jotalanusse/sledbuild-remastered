UI = {
  COLORS = {
    INVISIBLE = Color(0, 0, 0, 0), -- Invisible color
    TEXT = Color(255, 255, 255, 255), -- Text color
    BACKGROUND = Color(32, 32, 32, 128), -- Background color
    SHADER = Color(32, 32, 32, 64) -- Shader color
  }
}

-- CreateLabel: Create a new label
function UI.CreateLabel(parent, text)
  local label = vgui.Create("DLabel", parent)
  label:SetText(text)
  label:SetSize(parent:GetWide(), parent:GetTall())
  label:SetFont(FONTS.DEFAULT)
  label:SetTextColor(Color(255, 255, 255, 255)) -- TODO: Change color
  label:SetContentAlignment(5)

  label:Center()

  return label
end
