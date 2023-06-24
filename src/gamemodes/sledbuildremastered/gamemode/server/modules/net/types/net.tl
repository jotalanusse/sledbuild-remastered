global record NET
  record Config end

  CONFIG: Config

  Initialize: function()

  -- Functions
  AddNetworkStrings: function()
  BroadcastCoinFlipMessage: function(ply: PlayerType, result: string)
  BroadcastGamemodeMessage: function(message: string, color: ColorType)
  BroadcastPlayerFinishedMessage: function(ply: PlayerType, position: integer, time: number)
  BroadcastRaceStartMessage: function(round: integer)
  BroadcastServerUptimeWarningMessage: function(initial: integer, periodic: integer)
  SendDiscordMessage: function(ply: PlayerType)
  SendGamemodeMessage: function(ply: PlayerType, message: string, color: ColorType)
end
