require("server/modules/net/types/net")

-- Configuration
NET.CONFIG = {}

-- Functions
require("server/modules/net/functions/add-network-strings")
require("server/modules/net/functions/broadcast-coin-flip-message")
require("server/modules/net/functions/broadcast-gamemode-message")
require("server/modules/net/functions/broadcast-player-finished-message")
require("server/modules/net/functions/broadcast-race-start-message")
require("server/modules/net/functions/broadcast-server-uptime-warning-message")
require("server/modules/net/functions/send-discord-message")
require("server/modules/net/functions/send-gamemode-message")

-- Hooks
require("server/modules/net/hooks")

-- Initialize: Entry point for the module
function NET.Initialize()
  NET.AddNetworkStrings()
end
