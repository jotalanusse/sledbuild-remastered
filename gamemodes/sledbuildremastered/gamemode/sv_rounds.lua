RND = {
  STATE = {
    totalRounds = 0,
    stage = ROUND_STAGES.WAITING,
    round = {}
  }
}
--[[
local RACER_EXAMPLE = {
  ply = nil, -- TODO: Check if the player entity changes, or if this is just a reference
  time = 0,
  maxSpeed = 0,
  finished = false,
  disqualified = false, -- Might be death, disconnection, etc.
}
local ROUND_EXAMPLE = {
  racers = {
    "STEAM_ID" = RACER_EXAMPLE
  }
}
--]]

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

    round.startTime = CurTime()

    if (v:Team() == TEAMS.RACING) then
      if (v:InVehicle()) then
        v:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "Here we go!")

        -- Add the race to the round
        round.racers[v:SteamID()] = {
          ply = v,
          time = 0,
          maxSpeed = 0,
          finished = false,
          disqualified = false,
        }
      else
        v:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "You can't be a racer and not have a vehicle!")
        v:Kill()
      end
    elseif (v:Team() == TEAMS.BUILDING) then
      -- Look at them go!
    elseif (v:Team() == TEAMS.SPECTATING) then
      v:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "Make your bets!")
    end
  end

  -- TODO: Track players and times (network)
  -- TODO: Notify of the new race (network)

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

  for k, v in pairs(round.racers) do
    local ply = v.ply -- Shorthand

    -- TODO: Add a total races count

    if (v.finished == false) then
      ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "It seems like you didn't finish the race, better luck next time.")

      local spawn = MAP.SelectRandomSpawn()
      TLPT.Vehicle(ply:GetVehicle(), spawn:GetPos()) -- Teleport losers back

      ply:SetTeam(TEAMS.BUILDING)
    end
  end




  -- TODO: Return players to the building area

  -- Reset the round information
  round = {
    startTime = 0,
    racers = {}
  }
  timer.Create("SBR.StartTimer", ROUNDS.WAIT_TIME, 1, function() RND.Starting(round) end) -- We queue the next action
end

-- TODO: Passing the round object works by reference or by instance?
-- TODO: If this works by instance we will need nother way of hanlding the variables
RND.STATE.round = {
  startTime = 0, -- Use this to calculate the fastest player
  racers = {}
}

timer.Create("SBR.TestTimer", 10, 1, function() RND.Starting(RND.STATE.round) end) -- TODO: Testing, move?
