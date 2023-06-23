global record UPTIME
  record Config
    record Warnings
      INITIAL: integer
      PERIODIC: integer
    end

    WARNINGS: Warnings
  end

  CONFIG: Config

  Initialize: function()

  -- Functions
  FirstUptimeWarning: function()
  BroadcastWarningMessage: function()
end
