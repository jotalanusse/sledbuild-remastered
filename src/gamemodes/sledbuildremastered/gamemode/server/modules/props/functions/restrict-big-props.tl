require("server/modules/props/types/props")
require("server/modules/net/types/net")

-- RestrictBigProps: Restrict players from spawning props that are too large
function PROPS.RestrictBigProps(ply: PlayerType, _model: string, prop: EntityType)
  -- TODO: Should admins be able to spawn large props?

  if (prop:BoundingRadius() > PROPS.CONFIG.MAX_RADIUS) then
    NET.SendGamemodeMessage(ply, "That prop is too large for a sled.")

    prop:Remove()
  end
end
