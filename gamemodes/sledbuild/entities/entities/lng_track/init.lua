-- slb_track trigger

ENT.Base = "base_entity"
ENT.Type = "brush"

function ENT:Initialize()	
end

function ENT:StartTouch( entity )
	if entity:IsPlayer() then
		entity:SetNetworkedBool( "OnTrack", true )
	end
end

function ENT:EndTouch( entity )
	if entity:IsPlayer() then
		entity:SetNetworkedBool( "OnTrack", false )
	end
end

function ENT:Touch( entity ) -- we don't want to use this function... server lag.
end

/*---------------------------------------------------------
   Name: PassesTriggerFilters
   Desc: Return true if this object should trigger us
---------------------------------------------------------*/
function ENT:PassesTriggerFilters( entity )
	return true
end

/*---------------------------------------------------------
   Name: KeyValue
   Desc: Called when a keyvalue is added to us
---------------------------------------------------------*/
function ENT:KeyValue( key, value )
end

/*---------------------------------------------------------
   Name: Think
   Desc: Entity's think function. 
---------------------------------------------------------*/
function ENT:Think()
end

/*---------------------------------------------------------
   Name: OnRemove
   Desc: Called just before entity is deleted
---------------------------------------------------------*/
function ENT:OnRemove()
end