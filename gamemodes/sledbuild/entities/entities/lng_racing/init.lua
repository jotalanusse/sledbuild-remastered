-- slb_racing trigger

ENT.Base = "base_entity"
ENT.Type = "brush"

function ENT:Initialize()	
end

function ENT:StartTouch( entity )
	if entity:IsPlayer() then
		entity:SetNetworkedBool( "IsRacing", true )
		entity:SetTeam(TEAM_RACING)
	end

	if not entity:IsPlayer() then
		local phys = entity:GetPhysicsObject()
		if ( phys && phys:IsValid() ) then
			phys:SetMaterial("gmod_ice")
		end
	end
end

function ENT:EndTouch( entity )
	if entity:IsPlayer() then
		entity:SetTeam(TEAM_BUILDING)
		entity:SetNetworkedBool( "IsRacing", false )
	end
	local phys = entity:GetPhysicsObject()
	if ( phys && phys:IsValid() && !entity:IsPlayer() ) then
		phys:SetMaterial("dirt") -- Reset physprops when not racing.
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