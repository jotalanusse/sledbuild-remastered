ENT.Base = "base_entity"
ENT.Type = "brush"

include("sv_players.lua")

-- Initialize: Called when the entity is created
function ENT:Initialize() end

-- StartTouch: Called when an entity touches the trigger
function ENT:StartTouch(entity)
  -- No need to check if the player is alive, otherwise they can't enter
  if (entity:IsPlayer()) then
    ZN.STRT.PLYS.StartTouch(entity)
  end
end

-- EndTouch: Called when an entity leaves the trigger
function ENT:EndTouch(entity)
  -- We also check if the player is alive to avoid duplicate messages
  if (entity:IsPlayer() and entity:Alive()) then
    ZN.STRT.PLYS.EndTouch(entity)
  end
end
