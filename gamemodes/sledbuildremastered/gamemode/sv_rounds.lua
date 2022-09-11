RND = {
  STATE = {
    totalRounds = 0,
    stage = ROUND.STAGES.WAITING,
    round = {
      startTime = 0,
      racers = {},
    }
  }
}

-- IsPlayerRacing: Returns true if the player is racing
function RND.IsPlayerRacing(ply)
  local racer = RND.STATE.round.racers[ply:SteamID()]
  if (racer and not racer.finished and not racer.disqualified) then
    return true
  else
    return false
  end
end

-- AddPlayer: Adds a new player to the round
function RND.AddPlayer(ply, round)
  round.racers[ply:SteamID()] = {
    ply = ply,
    position = nil,
    maxSpeed = 0,
    time = nil, -- TODO: Should this value be here?
    finished = false,
    disqualified = false,
  }
end

-- DisqualifyPlayer: Disquialifies a player from the round
function RND.DisqualifyPlayer(ply, round)
  -- Check if player is even racing (on disconnection and death this will probably be called)
  if (RND.IsPlayerRacing(ply)) then
    round.racers[ply:SteamID()].disqualified = true
  end
end

-- TODO: Naming is sus
-- FinishPlayerRace: Updates a player when they finish the race
function RND.FinishPlayerRace(ply, round)
  local racer = RND.STATE.round.racers[ply:SteamID()]
  local position = table.maxn(round.racers) + 1

  -- Update the racer stats
  racer.position = position
  racer.time = CurTime() - round.startTime
  racer.finished = true

  -- Update the player stats
  local pl = PLYS.players[ply:SteamID()]
  pl.rounds = pl.rounds + 1
  pl.topSpeed = math.max(pl.topSpeed, racer.maxSpeed)
  
  if (pl.bestTime) then
    pl.bestTime = math.min(pl.bestTime, racer.time)
  else
    pl.bestTime = racer.time
  end

  if (position == 1) then
    pl.wins = pl.wins + 1
  else
    pl.losses = pl.losses + 1
  end

  if (position <= 3) then
    pl.podiums = pl.podiums + 1
  end
end

-- TODO: Add RemovePlayer player

-- ResetRacers: Bring racers back to the spawn on round end
function RND.ResetRacers(round)
  for k, v in pairs(round.racers) do
    local ply = v.ply

    -- Only iterate over non-disqualified racers (avoid deaths, and disconnections)
    if (RND.IsPlayerRacing(ply)) then
      if (not v.finished) then
        NET.SendGamemodeMessage(ply, "You didn't finish the race, better luck next time.")
        if (ply:InVehicle()) then
          -- Teleport back to spawn
          local spawn = MAP.SelectRandomSpawn()
          VEHS.Teleport(ply:GetVehicle(), spawn:GetPos())

          PLYS.SetTeam(ply, TEAMS.BUILDING)
        else
          -- This code should be unreachable, players shouldn't be able to get off
          NET.SendGamemodeMessage(ply, "How did you get off your sled? You shouldn't even be alive.",
            CONSOLE.COLORS.WARNING)
          ply:Kill()
        end
      end
    end
  end
end

-- IncrementTotal: Add 1 to the total rounds
function RND.IncrementTotal()
  RND.STATE.totalRounds = RND.STATE.totalRounds + 1
end

-- Starting: Starts a new race
function RND.Starting(round)
  RND.STATE.stage = ROUND.STAGES.STARTING

  PLYS.ResetAllColors() -- Reset all player colors
  RND.IncrementTotal() -- Add one to the total races counter

  NET.BroadcastGamemodeMessage("Race #" .. RND.STATE.totalRounds .. " just begun!") -- TODO: Costumize

  for k, v in pairs(player:GetAll()) do
    if (v:Team() == TEAMS.RACING) then
      if (v:InVehicle()) then
        NET.SendGamemodeMessage(v, "Here we go!")
        RND.AddPlayer(v, round)
      else
        NET.SendGamemodeMessage(v, "You can't be a racer and not be in a vehicle!", CONSOLE.COLORS.WARNING)
        v:Kill()
      end
    elseif (v:Team() == TEAMS.BUILDING) then
      -- Look at them go!
    elseif (v:Team() == TEAMS.SPECTATING) then
      NET.SendGamemodeMessage(v, "Make your bets!")
    end
  end

  -- Set round state
  round.startTime = CurTime()

  -- TODO: Track players and times (network)
  -- TODO: Notify of the new race (network)

  -- Let the map know we are starting
  MAP.GatesOpen()
  MAP.PushersEnable()

  timer.Create("SBR.RacingTimer", ROUND.TIMES.START, 1, function() RND.Racing(round) end) -- We queue the next action
end

-- Racing: We are now officialy racing
function RND.Racing(round)
  RND.STATE.stage = ROUND.STAGES.RACING

  print("Round started!") --TODO: Remove, debug

  -- Starting time is over
  MAP.GatesClose()
  MAP.PushersDisable()

  timer.Create("SBR.EndTimer", ROUND.TIMES.RACE, 1, function() RND.End(round) end) -- We queue the next action
end

-- End: End the current race
function RND.End(round)
  RND.STATE.stage = ROUND.STAGES.FINISHED
  print("Round ended!") --TODO: Remove, debug

  -- TODO: Add a total races count (player stats)
  RND.ResetRacers(round) -- Reset all racers and bring them back

  -- Reset the round information (don;t change the object reference)
  round.startTime = 0
  round.racers = {}

  timer.Create("SBR.StartTimer", ROUND.TIMES.WAIT, 1, function() RND.Starting(round) end) -- We queue the next action
end
