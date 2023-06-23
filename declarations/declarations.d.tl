global include: function(_fileName: string): any

global AddCSLuaFile: function(_fileName: string)

global record timer
  Create: function(_identifier: string, _delay: number, _repetitions: number, _func: function)
end

global record hook
  Add: function(_eventName: string, _identifier: string, _func: function)
end

global record net
  Start: function(_messageName: string, _unreliable: boolean)
  Send: function(_ply: Player)
  Broadcast: function()

  WriteFloat: function(_float: number)
  WriteUInt: function(_unsignedInteger: integer, _numberOfBits: integer)
  WriteString: function(_string: string)
  WriteColor: function(_color: any, _writeAlpha: boolean) -- TODO: Add types
  WriteBool: function(_bool: boolean)
  WriteEntity: function(_ent: any) -- TODO: Add types
end

global Color: function(_r: integer, _g: integer, _b: integer, _a: integer): any -- TODO: Add types

global record util
  AddNetworkString: function(_str: string)
end

global record Player
  IsAdmin: function(play: Player): boolean
end
