require("types/net")

-- AddNetworkStrings: Adds network strings
function NET.AddNetworkStrings()
  -- Game mode
  util.AddNetworkString("SBR:GamemodeMessage")
  util.AddNetworkString("SBR:RaceStartMessage")
  util.AddNetworkString("SBR:PlayerFinishedMessage")
  util.AddNetworkString("SBR:ServerUptimeWarningMessage")

  -- Commands
  util.AddNetworkString("SBR:CoinFlipMessage")
  util.AddNetworkString("SBR:DiscordMessage")
end
