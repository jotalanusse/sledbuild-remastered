require("server/modules/tools/types/tools")
require("server/modules/net/types/net")

-- LimitToolgun: Limit what the player can affect with their toolgun
function TOOLS.LimitToolgun(ply: PlayerType, trace: TraceResultType): boolean
  -- TODO: Make admins unable to accidentally affect world entities

  -- TODO: Make this more pretty
  -- Don't let player affect world entities or other players
  local entityClass = trace.Entity:GetClass()
  if (entityClass == "func_brush" or entityClass == "player") then
    NET.SendGamemodeMessage(ply, "This entity cannot be toolgunned.")

    return false
  end
end
