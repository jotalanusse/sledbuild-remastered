CLRS = {}

function CLRS.CreatePulsatingColor(color, settings)
  local alpha = settings.MIN_ALPHA + math.abs(math.sin(CurTime() * settings.FREQUENCY) * (255 - settings.MIN_ALPHA));

  return Color(color.r, color.g, color.b, alpha)
end
