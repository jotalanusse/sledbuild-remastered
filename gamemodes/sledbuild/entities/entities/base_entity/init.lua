--base_entity

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')
include('outputs.lua')


/*---------------------------------------------------------
   Name: Initialize
   Desc: First function called. Use to set up your entity
---------------------------------------------------------*/
function ENT:Initialize()
		--- THIS DOESNT WORK! (stacked/duped props still collides!)
	if self:GetClass == "prop_physics" then
		self:SetCollisionGroup( COLLISION_GROUP_DEBRIS_TRIGGER )
		print("ReaperSWE Debugs: Attempted to set collision groups in base_entity")
	end
end


/*---------------------------------------------------------
   Name: KeyValue
   Desc: Called when a keyvalue is added to us
---------------------------------------------------------*/
function ENT:KeyValue( key, value )
end


/*---------------------------------------------------------
   Name: OnRestore
   Desc: The game has just been reloaded. This is usually the right place
		to call the GetNetworked* functions to restore the script's values.
---------------------------------------------------------*/
function ENT:OnRestore()
end


/*---------------------------------------------------------
   Name: AcceptInput
   Desc: Accepts input, return true to override/accept input
---------------------------------------------------------*/
function ENT:AcceptInput( name, activator, caller, data )
	return false
end


/*---------------------------------------------------------
   Name: UpdateTransmitState
   Desc: Set the transmit state
---------------------------------------------------------*/
function ENT:UpdateTransmitState()
	return TRANSMIT_PVS
end


/*---------------------------------------------------------
   Name: Think
   Desc: Entity's think function. 
---------------------------------------------------------*/
function ENT:Think()
end
