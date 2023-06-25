require("server/modules/tools/types/tools")

hook.Add("PhysgunPickup", "SBR:TOOLS:LimitPhysgun", TOOLS.LimitPhysgun)
hook.Add("CanTool", "SBR:TOOLS:LimitToolgun", TOOLS.LimitToolgun)
hook.Add("CanTool", "SBR:TOOLS:RestrictTools", TOOLS.RestrictTools)
