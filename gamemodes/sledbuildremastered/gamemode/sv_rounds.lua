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

-- RoundStart: Starts a new round/race
function RoundStart(round)
  STATE.state = ROUND_STATES.STARTING

  RoundsIncrementTotal()
  GatesOpen()
end