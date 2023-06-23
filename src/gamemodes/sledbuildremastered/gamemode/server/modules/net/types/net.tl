global record NET
  record Config end

  CONFIG: Config

  Initialize: function()

  AddNetworkStrings: function()
  BroadcastCoinFlipMessage: function(ply: Player, result: string)
  BroadcastGamemodeMessage: function(message: string, color: any) -- TODO: Add types
  BroadcastPlayerFinishedMessage: function(ply: Player, position: integer, time: number)
  BroadcastRaceStartMessage: function(round: integer)
  BroadcastServerUptimeWarningMessage: function(initial: integer, periodic: integer)
  SendDiscordMessage: function(ply: Player)
  SendGamemodeMessage: function(ply: Player, message: string, color: any) -- TODO: Add types
end
