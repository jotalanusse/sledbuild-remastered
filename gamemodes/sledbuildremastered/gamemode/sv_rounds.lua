include('sv_globals.lua')
include('sv_map.lua')

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

  -- TODO: Kill racing players not in vehicles
  -- TODO: Track players and times
  -- TODO: Notify of the new race

  print("Round is starting!") --TODO: Remove, debug

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