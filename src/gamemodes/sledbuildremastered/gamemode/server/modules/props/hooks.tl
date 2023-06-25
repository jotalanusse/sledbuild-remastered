require("server/modules/props/types/props")

hook.Add("PlayerSpawnedProp", "SBR:PROPS:RestrictBigProps", PROPS.RestrictBigProps)
hook.Add("PlayerSpawnProp", "SBR:PROPS:RestrictProps", PROPS.RestrictProps)
hook.Add("PlayerSpawnedProp", "SBR:PROPS:SetDefaultPropCollisions", PROPS.SetDefaultPropCollisions)
