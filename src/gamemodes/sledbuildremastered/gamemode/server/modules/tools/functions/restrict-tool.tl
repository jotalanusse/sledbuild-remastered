require("server/modules/tools/types/tools")
require("server/modules/net/types/net")
require("shared/modules/helpers/types/helpers")

-- RestrictTools: Restrict what tools can be used by players
function TOOLS.RestrictTools(ply: PlayerType, _trace: TraceResultType, toolName: string): boolean
  if (ply:IsAdmin()) then
    return true
  end

  if (HELPERS.ArrayContainsString(TOOLS.CONFIG.RESTRICTED, toolName)) then
    NET.SendGamemodeMessage(ply, "This tool is restricted.")

    return false
  end
end
