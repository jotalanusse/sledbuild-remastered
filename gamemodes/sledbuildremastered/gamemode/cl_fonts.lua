FONTS = {
  DEFAULT = "SBR:Default",
}

function CreateFonts()
  surface.CreateFont("SBR:Default", {
    font = "IBM Plex Mono",
    size = 17,
    weight = 500,
  })
end

CreateFonts()