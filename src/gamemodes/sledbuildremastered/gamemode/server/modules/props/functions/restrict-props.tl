require("server/modules/props/types/props")
require("server/modules/net/types/net")
require("shared/modules/helpers/types/helpers")

-- RestrictProps: Restrict certain props from being spawned by players
function PROPS.RestrictProps(ply: PlayerType, model: string): boolean
  if (ply:IsAdmin()) then
    return true
  end

  if (HELPERS.ArrayContainsString(PROPS.CONFIG.RESTRICTED, model)) then
    NET.SendGamemodeMessage(ply, "This prop is restricted.")

    return false
  end
end
