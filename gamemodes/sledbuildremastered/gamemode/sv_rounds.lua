RND = {
  STATE = {
    initialized = false,
    totalRounds = 0,
    stage = ROUND.STAGES.WAITING,
    round = {
      startTime = 0,
      racers = {},
    }
  }
}

-- Initialize: Called when we want the rounds funcitonality to start
function RND.Initialize()
  if (RND.STATE.initialized) then return end -- Don't initialize if we already have
  
  if (MCHK.IsComplete()) then
    timer.Simple(10, function() RND.Starting(RND.STATE.round) end) -- Start the first round to start the cycle
  end

  RND.STATE.initialized = true
end

hook.Add("PlayerInitialSpawn", "SBR:RND:Bootstrap", RND.Initialize)

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
    topSpeed = 0,
    time = nil, -- TODO: Should this value be here?
    finished = false,
    disqualified = false,
  }
end

-- DisqualifyPlayer: Disqualify a player from the round
function RND.DisqualifyPlayer(ply, round)
  -- Check if player is even racing
  if (RND.IsPlayerRacing(ply)) then
    round.racers[ply:SteamID()].disqualified = true

    -- Update the player stats
    ply:SetNWInt("SBR:Losses", ply:GetNWInt("SBR:Losses") + 1)
  end
end

-- TODO: Naming is sus
-- FinishPlayerRace: Updates a player when they finish the race
function RND.FinishPlayerRace(ply, round)
  local racer = round.racers[ply:SteamID()]
  local position = table.maxn(round.racers) + 1

  -- Update the racer stats
  racer.position = position
  racer.time = CurTime() - round.startTime
  racer.finished = true

  -- Update the player stats
  ply:SetNWInt("SBR:Rounds", ply:GetNWInt("SBR:Rounds") + 1)
  if (position == 1) then
    ply:SetNWInt("SBR:Wins", ply:GetNWInt("SBR:Wins") + 1)
  else
    ply:SetNWInt("SBR:Losses", ply:GetNWInt("SBR:Losses") + 1)
  end

  if (position <= 3) then
    ply:SetNWInt("SBR:Podiums", ply:GetNWInt("SBR:Podiums") + 1)
  end

  ply:SetNWFloat("SBR:TopSpeed", math.max(ply:GetNWFloat("SBR:TopSpeed"), racer.topSpeed))

  -- No record can be 0, so we are safe to check for this
  if (ply:GetNWFloat("SBR:BestTime") ~= 0) then
    ply:SetNWFloat("SBR:BestTime", math.min(ply:GetNWFloat("SBR:BestTime"), racer.time))
  else
    ply:SetNWFloat("SBR:BestTime", racer.time)
  end
end

-- RemovePlayer: Removes a player from the round (use carefully)
function RND.RemovePlayer(ply, round)
  if (round.racers[ply:SteamID()]) then
    round.racers[ply:SteamID()] = nil
  end
end

-- ResetRacers: Bring racers back to the spawn on round end
function RND.ResetRacers(round)
  for _, v in pairs(round.racers) do
    local ply = v.ply

    -- Only iterate over non-disqualified racers (avoid deaths, and disconnections)
    if (RND.IsPlayerRacing(ply)) then
      if (not v.finished) then
        NET.SendGamemodeMessage(ply, "You didn't finish the race, better luck next time.")
        RND.RemovePlayer(ply, round)

        -- Update the player stats
        ply:SetNWInt("SBR:Rounds", ply:GetNWInt("SBR:Rounds") + 1)
        ply:SetNWInt("SBR:Losses", ply:GetNWInt("SBR:Losses") + 1)
        if (ply:InVehicle()) then
          -- Teleport back to spawn
          local spawn = MAP.SelectRandomSpawn()
          VEHS.Teleport(ply:GetVehicle(), spawn:GetPos())

          PLYS.SetTeam(ply, TEAMS.BUILDING)
        else
          -- This code should be unreachable, players shouldn't be able to get off
          NET.SendGamemodeMessage(ply, "You can't get off your sled while racing! You shouldn't be alive.",
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

  NET.BroadcastRaceStartMessage(RND.STATE.totalRounds)

  for _, v in pairs(player:GetAll()) do
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

  timer.Create("SBR:RacingTimer", ROUND.TIMES.START, 1, function() RND.Racing(round) end) -- We queue the next action
end

-- Racing: We are now officialy racing
function RND.Racing(round)
  RND.STATE.stage = ROUND.STAGES.RACING

  -- Starting time is over
  MAP.GatesClose()
  MAP.PushersDisable()

  timer.Create("SBR:EndTimer", ROUND.TIMES.RACE, 1, function() RND.End(round) end) -- We queue the next action
end

-- End: End the current race
function RND.End(round)
  RND.STATE.stage = ROUND.STAGES.FINISHED

  NET.BroadcastGamemodeMessage("The race has finished!")

  -- TODO: Add a total races count (player stats)
  RND.ResetRacers(round) -- Reset all racers and bring them back

  -- Reset the round information (don;t change the object reference)
  round.startTime = 0
  round.racers = {}

  timer.Create("SBR:StartTimer", ROUND.TIMES.WAIT, 1, function() RND.Starting(round) end) -- We queue the next action
end
