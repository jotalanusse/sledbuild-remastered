global record TOOLS
  record Config
    RESTRICTED: {string}
  end

  CONFIG: Config

  Initialize: function()

  -- Functions
  LimitPhysgun: function(ply: PlayerType, ent: EntityType): boolean
  LimitToolgun: function(ply: PlayerType, trace: TraceResultType): boolean
  RestrictTool: function(ply: PlayerType, trace: TraceResultType, toolName: string): boolean
end
