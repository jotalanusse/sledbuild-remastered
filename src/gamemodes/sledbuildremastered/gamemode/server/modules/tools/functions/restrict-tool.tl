require("server/modules/tools/types/tools")
require("server/modules/net/types/net")

-- RestrictTool: Restrict a tool from being used.
function TOOLS.RestrictTool(ply: PlayerType, _trace: any, toolName: string): boolean
  if (ply:IsAdmin()) then
    return true
  end

  -- TODO: Implement
  if (false) then
    NET.SendGamemodeMessage(ply, "This tool is restricted.")

    return false
  end
end
