global record Uptime
  record Config
    record Warnings
      INITIAL: integer
      PERIODIC: integer
    end

    WARNINGS: Warnings
  end

  CONFIG: Config

  Initialize: function()
  FirstUptimeWarning: function()
  BroadcastWarningMessage: function()
end
