require("server/modules/tools/types/tools")
require("server/modules/net/types/net")
require("shared/modules/helpers/types/helpers")

-- RestrictTool: Restrict a tool from being used.
function TOOLS.RestrictTool(ply: PlayerType, _trace: TraceResultType, toolName: string): boolean
  if (ply:IsAdmin()) then
    return true
  end

  if (HELPERS.ArrayContainsString(TOOLS.CONFIG.RESTRICTED, toolName)) then
    NET.SendGamemodeMessage(ply, "This tool is restricted.")

    return false
  end
end
