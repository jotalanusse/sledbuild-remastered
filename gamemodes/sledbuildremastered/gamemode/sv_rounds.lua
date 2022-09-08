STATE = {
  totalRounds = 0,
  -- RECORD_TIME,
  -- START_TIME = 0,
  state = ROUND_STATES.WAITING,
  -- RESULT = {}
}

-- RoundsIncrementTotal: Add 1 to the total rounds
function RoundsIncrementTotal()
  STATE.totalRounds = STATE.totalRounds + 1
end

-- RoundStarting: Starts a new race
function RoundStarting(round)
  STATE.state = ROUND_STATES.STARTING

  RoundsIncrementTotal()

  for k, v in pairs(player:GetAll()) do
    v:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "Race #" .. STATE.totalRounds .. " just begun!")

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
  GatesOpen()
  PusherEnable()

  timer.Create("RoundRacingTimer", ROUNDS.START_TIME, 1, function() RoundRacing(round) end) -- We queue the next action
end

-- RoundRacing: We are now officialy racing
function RoundRacing(round)
  STATE.state = ROUND_STATES.RACING

  print("Round started!") --TODO: Remove, debug

  -- Starting time is over
  GatesClose()
  PusherDisable()

  timer.Create("RoundEndTimer", ROUNDS.RACE_TIME, 1, function() RoundEnd(round) end) -- We queue the next action
end

-- RoundEnd: End the current race
function RoundEnd(round)
  print("Round ended!") --TODO: Remove, debug

  -- TODO: Return players to the building area

  timer.Create("RoundStartTimer", ROUNDS.WAIT_TIME, 1, function() RoundStarting(round) end) -- We queue the next action
end

local round = {}
timer.Create("TestTimer", 5, 1, function() RoundStarting(round) end)
