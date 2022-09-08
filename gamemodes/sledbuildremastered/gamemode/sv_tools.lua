-- Non-tooleable entities
local NO_TOOL_ENTITIES = {
  "player",
  "func_brush"
}

-- ToolsLimit: Limit what the player can affect with their tools
function ToolsLimit(ply, trace)
  -- TODO: Enable after testing
  -- if ply:IsAdmin() then
  --   return true
  -- end

  for k, v in pairs(NO_TOOL_ENTITIES) do
    if trace.Entity:GetClass() == v then
      ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "This entity cannot be toolgunned.")
      return false
    end
  end
end

hook.Add("CanTool", "SBRToolsLimit", ToolsLimit)
