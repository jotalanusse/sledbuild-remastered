UI = {

}

-- CreateLabel: Create a new label
function UI.CreateLabel(parent, text)
  local label = vgui.Create("DLabel", parent)

  label:SetText(text)
  label:SetSize(parent:GetWide(), parent:GetTall())
  label:SetFont("DermaDefaultBold") -- TODO: Make global variable
  label:SetTextColor(Color(255, 255, 255, 255)) -- TODO: Change color
  label:SetContentAlignment(5)

  label:Center()

  return label
end
