RND = {
  STATE = {
    totalRounds = 0,
    -- RECORD_TIME,
    -- START_TIME = 0,
    stage = ROUND_STAGES.WAITING,
    -- RESULT = {}
  }
}

-- IncrementTotal: Add 1 to the total rounds
function RND.IncrementTotal()
  RND.STATE.totalRounds = RND.STATE.totalRounds + 1
end

-- Starting: Starts a new race
function RND.Starting(round)
  RND.STATE.stage = ROUND_STAGES.STARTING

  RND.IncrementTotal()

  for k, v in pairs(player:GetAll()) do
    v:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "Race #" .. RND.STATE.totalRounds .. " just begun!")

    if (v:Team() == TEAMS.RACING) then
      if (v:InVehicle()) then
        -- TODO: Set the player as racing state?
        v:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "Here we go!")
      else
        -- TODO: Technically the player is assured to be in the starting area, so the message could be different
        v:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "You can't be a racer and not have a vehicle!")
        v:Kill()
      end
    elseif (v:Team() == TEAMS.BUILDING) then
      -- TODO: Actually do nothing?
    elseif (v:Team() == TEAMS.SPECTATING) then
      v:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "Make your bets!")
    end
  end

  -- TODO: Track players and times
  -- TODO: Notify of the new race

  -- Let the map know we are starting
  MAP.GatesOpen()
  MAP.PushersEnable()

  timer.Create("SBR.RacingTimer", ROUNDS.START_TIME, 1, function() RND.Racing(round) end) -- We queue the next action
end

-- Racing: We are now officialy racing
function RND.Racing(round)
  RND.STATE.stage = ROUND_STAGES.RACING

  print("Round started!") --TODO: Remove, debug

  -- Starting time is over
  MAP.GatesClose()
  MAP.PushersDisable()

  timer.Create("SBR.EndTimer", ROUNDS.RACE_TIME, 1, function() RND.End(round) end) -- We queue the next action
end

-- End: End the current race
function RND.End(round)
  RND.STATE.stage = ROUND_STAGES.FINISHED
  print("Round ended!") --TODO: Remove, debug

  -- TODO: Return players to the building area

  timer.Create("SBR.StartTimer", ROUNDS.WAIT_TIME, 1, function() RND.Starting(round) end) -- We queue the next action
end

local round = {}
timer.Create("SBR.TestTimer", 5, 1, function() RND.Starting(round) end)
