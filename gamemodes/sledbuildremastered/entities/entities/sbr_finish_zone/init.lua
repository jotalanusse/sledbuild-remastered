ENT.Base = "base_entity"
ENT.Type = "brush"

include("sv_players.lua")

-- Initialize: Called when the entity is created
function ENT:Initialize() end

-- StartTouch: Called when an entity touches the trigger
function ENT:StartTouch(entity)
  -- Check if the player is alive, no dead winners :)
  if (entity:IsPlayer() and entity:Alive()) then
    ZN.END.PLYS.StartTouch(entity)
  end
end

-- EndTouch: Called when an entity leaves the trigger
function ENT:EndTouch(entity)
  -- We also check if the player is alive to avoid useless messages (maybe?)
  if (entity:IsPlayer() and entity:Alive()) then
    ZN.END.PLYS.EndTouch(entity)
  end
end
