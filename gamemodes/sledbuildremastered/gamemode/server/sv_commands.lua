CMDS = {}

-- Help: Displays a list of commands
function CMDS.Help(ply)
  
end

-- CoinFlip: Flip a coin and broadcast the result
function CMDS.CoinFlip(ply)
  local result = math.random(2) == 1 and "heads" or "tails"

  NET.BroadcastGamemodeMessage(ply:Nick() .. " flipped a coin and got " .. result .. "!") -- TODO: Maybe chnage color?
end

-- Spawn: Bring back a player to the spawn
function CMDS.Spawn(ply)
  -- Select a random spawn
  local spawn = MAP.SelectRandomSpawn()

  -- If the player is dead we just respawn them
  if (not ply:Alive()) then
    ply:Spawn()
  else
    -- Check if the player is even racing
    if (RND.IsPlayerRacing(ply)) then
      RND.DisqualifyPlayer(ply, RND.round)
      PLYS.SetTeam(ply, TEAMS.BUILDING)

      -- A player might not be in their sled
      if (ply:InVehicle()) then
        local vehicle = ply:GetVehicle()

        VEHS.SetMaterial(vehicle, VEHS.MATERIALS.BUILDING) -- Make their sled non-slippery
        VEHS.Teleport(vehicle, spawn:GetPos())
      else
        NET.SendGamemodeMessage(ply, "Remember to stay in your sled!")

        PLYS.Teleport(ply, spawn:GetPos())
      end
    else
      NET.SendGamemodeMessage(ply, "You are not even racing! How are you not at spawn?", COLORS.WARNING)

      PLYS.Teleport(ply, spawn:GetPos())
    end
  end
end

function CMDS.ManageChat(ply, text, teamChat)
  if (string.StartWith(text, "/")) then
    local arguments = string.Explode(" ", text)
    local command = string.sub(arguments[1], 2)

    if (command == "spawn") then
      CMDS.Spawn(ply)
    elseif (command == "coinflip") then
      CMDS.CoinFlip(ply)
    else
      NET.SendGamemodeMessage(ply, "Unknown command: /" .. command, COLORS.WARNING)
    end

    return ""
  end
end

hook.Add("PlayerSay", "SBR:CMDS:ManageChat", CMDS.ManageChat)
