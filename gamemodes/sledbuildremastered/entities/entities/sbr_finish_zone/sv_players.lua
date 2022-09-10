-- StartTouch: Called when a player enters the end zone
function ZN.END.PLYS.StartTouch(ply)
  if (RND.STATE.stage == ROUND_STAGES.RACING) then
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
        NET.SendGamemodeMessage(ply, "Finished #" .. position .. "! Your time is [" .. formattedTime .. "]") -- TODO: Costumize

        -- Teleport racer back
        local spawn = MAP.SelectRandomSpawn()
        local vehicle = ply:GetVehicle()

        timer.Simple(3, function()
          VEHS.Teleport(vehicle, spawn:GetPos())

          -- A player might get off after finishing the race
          if (not ply:InVehicle()) then
            NET.SendGamemodeMessage(ply, "Remember to stay in your sled!")
            PLYS.Teleport(ply, spawn:GetPos())
          end
        end)
      else
        -- This code should be unreachable, players shouldn't be able to get off
        NET.SendGamemodeMessage(ply, "How did you finish without a sled? You shouldn't even be alive.",
          CONSOLE.WARNING_COLOR)
        RND.DisqualifyPlayer(ply, RND.STATE.round)
        ply:Kill()
      end

      -- TODO: Check if the racer is the last one to finish
    else
      -- This code should be unreachable

      NET.SendGamemodeMessage(ply, "How are you at the finish line without being a racer? You shouldn't even be alive.",
        CONSOLE.WARNING_COLOR)
      ply:Kill()
    end
  else
    -- This code should be unreachable

    NET.SendGamemodeMessage(ply, "How are you at the finish line, we are not even racing? You shouldn't even be alive.",
      CONSOLE.WARNING_COLOR)
    ply:Kill()
  end
end

-- EndTouch: Called when a player leaves the end zone
function ZN.END.PLYS.EndTouch(ply)

end
