require("server/modules/props/types/props")

-- SetDefaultPropCollisions: Sets the default collisions for every prop
function PROPS.SetDefaultPropCollisions(_ply: PlayerType, _model: string, prop: EntityType)
  prop:SetCollisionGroup(PROPS.CONFIG.COLLISIONS.DEFAULT)
end
