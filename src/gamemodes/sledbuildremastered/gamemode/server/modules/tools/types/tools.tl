global record TOOLS
  record Config
    RESTRICTED: {ToolNameEnum}
  end

  CONFIG: Config

  Initialize: function()

  -- Functions
  LimitPhysgun: function(ply: PlayerType, ent: EntityType): boolean
  LimitToolgun: function(ply: PlayerType, trace: TraceResultType): boolean
  RestrictTools: function(ply: PlayerType, trace: TraceResultType, toolName: string): boolean
end
