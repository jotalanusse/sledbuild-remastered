global record MAP_CHECK
  record Config end
  record State
    IS_MAP_COMPLETE: boolean
    WAS_MAP_CHECKED: boolean
  end

  CONFIG: Config
  STATE: State

  Initialize: function()

  -- Functions
  CheckMap: function()
end
