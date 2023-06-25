global record TOOLS
  record Config
    RESTRICTED: {string}
  end

  CONFIG: Config

  Initialize: function()

  -- Functions
  RestrictTool: function(ply: PlayerType, trace: any, toolName: string): boolean -- TODO: Add types
end
