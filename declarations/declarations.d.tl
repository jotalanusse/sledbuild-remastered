-- Types
global record PlayerType
  IsAdmin: function(play: PlayerType): boolean
end

global record EntityType
  SetPos: function(entity: EntityType, position: VectorType)
  GetPos: function(entity: EntityType): VectorType
end

global record ColorType
  r: integer
  g: integer
  b: integer
  a: integer
end

global record VectorType
  x: number
  y: number
  z: number

  metamethod __add: function(VectorType, VectorType): VectorType
  metamethod __sub: function(VectorType, VectorType): VectorType
end

-- Globals
global include: function(_fileName: string): any
global AddCSLuaFile: function(_fileName: string)

-- Libraries
global record ents
  FindByName: function(_name: string): {EntityType}
  FindByClass: function(_class: string): {EntityType}
end

global record timer
  Create: function(_identifier: string, _delay: number, _repetitions: number, _func: function)
  Simple: function(_delay: number, _func: function)
end

global record hook
  Add: function(_eventName: string, _identifier: string, _func: function)
end

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

global record util
  AddNetworkString: function(_str: string)
end

-- Classes
global Color: function(_r: integer, _g: integer, _b: integer, _a: integer): ColorType

global Vector: function(_x: number, _y: number, _z: number): VectorType
