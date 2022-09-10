-- StartTouch: Called when a player enters the end zone
function ZN.END.PLYS.StartTouch(ply)
  if (RND.IsPlayerRacing(ply)) then
    if (ply:InVehicle()) then
      -- The player finished the race!
      local round = RND.STATE.round
      RND.FinishPlayerRace(ply, round)
      local position = table.maxn(round.racers)

      PLYS.SetTeam(ply, TEAMS.BUILDING) -- Set the player team back to building

      -- TODO: Winner winner chicken dinner, what tf do I do now?
      if (position == 1) then
        PLYS.SetColor(ply, Color(0, 255, 0)) -- Green
      elseif (position == 2) then
        PLYS.SetColor(ply, Color(255, 255, 0)) -- Yellow
      elseif (position == 3) then
        PLYS.SetColor(ply, Color(255, 165, 0)) -- Orange
      end

      -- Calculate the time
      local timeTable = string.FormattedTime(round.racers[position].time)
      local formattedTime = string.format("%02i:%02i.%03i", timeTable.m, timeTable.s, timeTable.ms * 10)

      -- Messages and that things...
      ply:PrintMessage(HUD_PRINTTALK,
        CONSOLE_PREFIX .. "Finished #" .. position .. "! Your time is [" .. formattedTime .. "]")

      -- Teleport racer back
      local spawn = MAP.SelectRandomSpawn()
      VEHS.Teleport(ply:GetVehicle(), spawn:GetPos())
    else
      -- This code should be unreachable, players shouldn't be able to get off
      ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "How did you finish without a sled? You shouldn't even be alive.")
      RND.DisqualifyPlayer(ply, RND.STATE.round)
      ply:Kill()
    end

    -- TODO: Check if the racer is the last one to finish
  else
    -- This code should be unreachable
    ply:PrintMessage(HUD_PRINTTALK,
      CONSOLE_PREFIX .. "How are you at the finish line without being a racer? You shouldn't even be alive.")
    ply:Kill()
  end
end

-- EndTouch: Called when a player leaves the end zone
function ZN.END.PLYS.EndTouch(ply)

end
