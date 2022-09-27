CVRS = {
  NAMES = {
    RACE_TIME = "sbr_race_time",
    START_TIME = "sbr_start_time",
    WAIT_TIME = "sbr_wait_time",
  }
}

-- UpdateRaceTime: Updates the amount of time each race takes
function CVRS.UpdateRaceTime(time)
  NET.BroadcastGamemodeMessage("Race time is now " .. time .. " seconds")

  RND.TIMES.RACE = time
end

cvars.AddChangeCallback(CVRS.NAMES.RACE_TIME, function(convar_name, value_old, value_new)
  CVRS.UpdateRaceTime(value_new)
end)

-- UpdateStartTime: Updates the amount of time the starting phase takes
function CVRS.UpdateStartTime(time)
  NET.BroadcastGamemodeMessage("Start time is now " .. time .. " seconds")

  RND.TIMES.START = time
end

cvars.AddChangeCallback(CVRS.NAMES.START_TIME, function(convar_name, value_old, value_new)
  CVRS.UpdateStartTime(value_new)
end)

-- UpdateWaitTime: Updates the amount of time between each race
function CVRS.UpdateWaitTime(time)
  NET.BroadcastGamemodeMessage("Wait time is now " .. time .. " seconds")

  RND.TIMES.WAIT = time
end

cvars.AddChangeCallback(CVRS.NAMES.WAIT_TIME, function(convar_name, value_old, value_new)
  CVRS.UpdateWaitTime(value_new)
end)
