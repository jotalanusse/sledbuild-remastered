RND = {
  STATE = {
    initialized = false, -- Whether the round cycle has been started
    totalRounds = 0, -- Total amount of rounds played
    stage = ROUND.STAGES.WAITING, -- Current round stage

    -- Round information (renewed every round)
    round = {
      startTime = 0, -- Time when the round started
      racers = {}, -- List of racers of this round
    }
  }
}

-- Initialize: Called when we want the rounds functionality to start
function RND.Initialize()
  -- Don't initialize if we already have
  if (RND.STATE.initialized) then return end

  -- Only start if we pass the map check
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
    time = nil,
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

  -- Check if the player won
  if (position == 1) then
    ply:SetNWInt("SBR:Wins", ply:GetNWInt("SBR:Wins") + 1)
  else
    ply:SetNWInt("SBR:Losses", ply:GetNWInt("SBR:Losses") + 1)
  end

  -- Was the player on the podium?
  if (position <= 3) then
    ply:SetNWInt("SBR:Podiums", ply:GetNWInt("SBR:Podiums") + 1)
  end

  -- No record time can be 0, so we are safe to check it like this
  if (ply:GetNWFloat("SBR:BestTime") ~= 0) then
    ply:SetNWFloat("SBR:BestTime", math.min(ply:GetNWFloat("SBR:BestTime"), racer.time))
  else
    ply:SetNWFloat("SBR:BestTime", racer.time)
  end
end

-- RemovePlayer: Removes a player from the round
function RND.RemovePlayer(ply, round)
  if (round.racers[ply:SteamID()]) then
    round.racers[ply:SteamID()] = nil
  end
end

-- ResetRacers: Bring racers back to the spawn on round end
function RND.ResetRacers(round)
  for _, v in pairs(round.racers) do
    local ply = v.ply

    -- Players that finish are handled in FinishPlayerRace
    if (RND.IsPlayerRacing(ply)) then
      if (not v.finished) then
        NET.SendGamemodeMessage(ply, "You didn't finish the race, better luck next time.")
        RND.RemovePlayer(ply, round)

        -- Update the player stats
        ply:SetNWInt("SBR:Rounds", ply:GetNWInt("SBR:Rounds") + 1)
        ply:SetNWInt("SBR:Losses", ply:GetNWInt("SBR:Losses") + 1)

        -- Reset the player back to the spawn with their vehicle
        if (ply:InVehicle()) then
          PLYS.SetTeam(ply, TEAMS.BUILDING)

          -- Make their sled non-slippery
          local vehicle = ply:GetVehicle()
          VEHS.SetMaterial(vehicle, VEHS.MATERIALS.BUILDING)

          local spawn = MAP.SelectRandomSpawn()
          VEHS.Teleport(ply:GetVehicle(), spawn:GetPos())

        else
          -- This code should be unreachable, players shouldn't be able to get off
          NET.SendGamemodeMessage(ply, "You can't get off your sled while racing! You shouldn't be alive.",
            COLORS.WARNING)
          ply:Kill()
        end
      end
    end
  end
end

-- IncrementTotal: Add 1 to the total rounds played
function RND.IncrementTotalRounds()
  RND.STATE.totalRounds = RND.STATE.totalRounds + 1
end

-- Starting: Starts a new race
function RND.Starting(round)
  RND.STATE.stage = ROUND.STAGES.STARTING

  PLYS.ResetAllColors() -- Reset all player colors
  RND.IncrementTotalRounds() -- Add one to the total races counter

  NET.BroadcastRaceStartMessage(RND.STATE.totalRounds)

  -- Add all valid players to the race, kill the others
  for _, v in pairs(team.GetPlayers(TEAMS.RACING)) do
    -- If they are in a vehicle they are ready to race
    if (v:InVehicle()) then
      NET.SendGamemodeMessage(v, "Here we go!")

      -- Add player to the round
      RND.AddPlayer(v, round)

      -- Make their sled slide
      local vehicle = v:GetVehicle()
      VEHS.SetMaterial(vehicle, VEHS.MATERIALS.RACING)
    else
      NET.SendGamemodeMessage(v, "You can't be a racer and not be in a vehicle!", COLORS.WARNING)

      v:Kill()
    end
  end

  -- Set round state
  round.startTime = CurTime()

  -- Start tracking stats (speed)
  SPD.StartTracking()

  -- Let the map know we are starting
  MAP.GatesOpen()
  MAP.PushersEnable()

  timer.Create("SBR:RND:Racing", ROUND.TIMES.START, 1, function() RND.Racing(round) end) -- We queue the next action
end

-- Racing: We are now officially racing
function RND.Racing(round)
  RND.STATE.stage = ROUND.STAGES.RACING

  -- Starting time is over, let the map know
  MAP.GatesClose()
  MAP.PushersDisable()

  timer.Create("SBR:RND:End", ROUND.TIMES.RACE, 1, function() RND.End(round) end) -- We queue the next action
end

-- End: End the current race
function RND.End(round)
  RND.STATE.stage = ROUND.STAGES.FINISHED

  NET.BroadcastGamemodeMessage("The race has finished!")

  -- Stop tracking speed
  SPD.StopTracking()
  -- TODO: Add a total races count (player stats) (I think this is handled in other places)
  -- Reset all racers and bring them back
  RND.ResetRacers(round)

  -- Reset the round information (don't change the object reference)
  round.startTime = 0
  round.racers = {}

  timer.Create("SBR:RND:Starting", ROUND.TIMES.WAIT, 1, function() RND.Starting(round) end) -- We queue the next action
end
