require("server/modules/cvars/types/cvars")
require("server/modules/net/types/net")

-- UpdateRaceTime: Updates the amount of time each race takes
function CVARS.UpdateRaceTime(time: number)
  NET.BroadcastGamemodeMessage("Race time is now " .. time .. " seconds")

  RND.TIMES.RACE = time -- TODO: Damn
end
