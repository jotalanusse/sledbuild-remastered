global enum RoundStageEnum
  "waiting"
  "starting"
  "racing"
end

global enum RacerStateEnum
  "racing"
  "finished"
  "disqualified"
end

global record RacerType
  playerId: string
  player: PlayerType
  position: integer
  finishTime: integer
  state: RacerStateEnum
end

global record RoundType
  startTime: integer
  endTime: integer
  round: integer
  stage: RoundStageEnum
  racers: {RacerType}
end