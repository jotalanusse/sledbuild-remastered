ENT.Base = "base_entity"
ENT.Type = "brush"

include("sv_players.lua")

-- Initialize: Called when the entity is created
function ENT:Initialize()
end

-- StartTouch: Called when an entity touches the trigger
function ENT:StartTouch(entity)
  if (entity:IsPlayer()) then
    PlayerStartZoneStartTouch(entity)
  end
end

-- EndTouch: Called when an entity leaves the trigger
function ENT:EndTouch(entity)
  if (entity:IsPlayer()) then
    PlayerStartZoneEndTouch(entity)
  end
end
