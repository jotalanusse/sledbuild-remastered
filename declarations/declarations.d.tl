global include: function(_fileName: string): any

global AddCSLuaFile: function(_fileName: string)

global record timer
  Create: function(_identifier: string, _delay: number, _repetitions: number, _func: function)
end

global record hook
  Add: function(_eventName: string, _identifier: string, _func: function)
end