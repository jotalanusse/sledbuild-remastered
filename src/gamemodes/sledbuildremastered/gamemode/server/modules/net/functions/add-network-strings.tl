require("server/modules/net/types/net")

-- AddNetworkStrings: Adds network strings
function NET.AddNetworkStrings()
  -- Game mode
  util.AddNetworkString("SBR:GamemodeMessage")
  util.AddNetworkString("SBR:RaceStartMessage")
  util.AddNetworkString("SBR:PlayerFinishedRaceMessage")
  util.AddNetworkString("SBR:ServerUptimeWarningMessage")

  -- Commands
  util.AddNetworkString("SBR:CoinFlipResultMessage")
  util.AddNetworkString("SBR:DiscordMessage")
end
