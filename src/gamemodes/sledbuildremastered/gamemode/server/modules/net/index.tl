require("types/net")

-- Configuration
NET.CONFIG = {}

-- Functions
require("functions/add-network-strings")
require("functions/broadcast-coin-flip-message")
require("functions/broadcast-gamemode-message")
require("functions/broadcast-player-finished-message")
require("functions/broadcast-race-start-message")
require("functions/broadcast-server-uptime-warning-message")
require("functions/send-discord-message")
require("functions/send-gamemode-message")

-- Hooks
require("hooks")

-- Initialize: Entry point for the module
function NET.Initialize()
  NET.AddNetworkStrings()
end

NET.Initialize()
