-- StartTouch: Called when a player enters the end zone
function ZN.END.PLYS.StartTouch(ply)
  if (RND.STATE.stage == ROUND.STAGES.RACING) then
    if (RND.IsPlayerRacing(ply)) then
      if (ply:InVehicle()) then
        -- The player finished the race!
        local round = RND.STATE.round

        RND.FinishPlayerRace(ply, round)
        local racer = round.racers[ply:SteamID()]

        -- TODO: Winner winner chicken dinner, what tf do I do now?
        if (racer.position == 1) then
          PLYS.SetColor(ply, Color(0, 255, 0)) -- Green
        elseif (racer.position == 2) then
          PLYS.SetColor(ply, Color(255, 255, 0)) -- Yellow
        elseif (racer.position == 3) then
          PLYS.SetColor(ply, Color(255, 165, 0)) -- Orange
        end

        -- Messages and that things...
        local formattedTime = MSG.FormatTime(racer.time)
        NET.SendGamemodeMessage(ply, "Finished #" .. racer.position .. "! Your time is [" .. formattedTime .. "]") -- TODO: Costumize

        PLYS.SetTeam(ply, TEAMS.BUILDING) -- Set the player team back to building

        -- Teleport racer back
        local spawn = MAP.SelectRandomSpawn()
        local vehicle = ply:GetVehicle()
        timer.Simple(3, function()
          if (vehicle:IsValid()) then
            VEHS.Teleport(vehicle, spawn:GetPos())
          end

          -- Here we should check that everything exists as we wait 3 seconds
          if (ply) then
            if (ply:Alive()) then
              -- A player might get off their sled
              if (not ply:InVehicle()) then
                NET.SendGamemodeMessage(ply, "Remember to stay in your sled!")
                PLYS.Teleport(ply, spawn:GetPos())
              end
            else
              -- A player might straight up die
              NET.SendGamemodeMessage(ply, "How are you dead? You just finished the race!")
            end
          else
            -- Bro straight up disconnected
          end
        end)
      else
        -- This code should be unreachable, players shouldn't be able to get off
        NET.SendGamemodeMessage(ply, "How did you finish without a sled? You shouldn't be alive.",
          CONSOLE.COLORS.WARNING)
        RND.DisqualifyPlayer(ply, RND.STATE.round)
        ply:Kill()
      end

      -- TODO: Check if the racer is the last one to finish
    else
      -- The player might cross multiple finish lines depending on the map design
    end
  else
    -- This code should be unreachable

    NET.SendGamemodeMessage(ply, "How are you at the finish line, we are not even racing? You shouldn't be alive.",
      CONSOLE.COLORS.WARNING)
    ply:Kill()
  end
end

-- EndTouch: Called when a player leaves the end zone
function ZN.END.PLYS.EndTouch(ply)

end
