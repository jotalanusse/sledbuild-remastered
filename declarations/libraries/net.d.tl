global record net
  Start: function(messageName: string, unreliable: boolean)
  Send: function(ply: PlayerType)
  Broadcast: function()

  WriteFloat: function(float: number)
  WriteUInt: function(unsignedInteger: integer, numberOfBits: integer)
  WriteString: function(string: string)
  WriteColor: function(color: ColorType, writeAlpha: boolean)
  WriteBool: function(bool: boolean)
  WriteEntity: function(ent: any) -- TYPE: Wait for EnityType to be extensible
end
