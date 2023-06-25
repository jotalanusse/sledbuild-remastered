global record net
  Start: function(_messageName: string, _unreliable: boolean)
  Send: function(_ply: PlayerType)
  Broadcast: function()

  WriteFloat: function(_float: number)
  WriteUInt: function(_unsignedInteger: integer, _numberOfBits: integer)
  WriteString: function(_string: string)
  WriteColor: function(_color: ColorType, _writeAlpha: boolean)
  WriteBool: function(_bool: boolean)
  WriteEntity: function(_ent: any) -- TODO: Check how to accept any entity
end
