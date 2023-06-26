require("server/modules/uptime/types/uptime")

hook.Add("PlayerInitialSpawn", "SBR:UPTIME:Initialize", UPTIME.Initialize)
