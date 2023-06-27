global record FORMATTERS
  record Config end

  CONFIG: Config

  Initialize: function()

  -- Functions
  FormatHudSpeed: function(speed: number): string
  FormatHudTimer: function(time: number): string
  FormatMph: function(mph: number): string
  FormatRaceTime: function(time: number): string
  FormatTime: function(time: number): string
end
