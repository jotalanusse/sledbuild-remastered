local buildDir = "build"

local scanWinDirectory = require("functions/scan-win-directory")
local replaceRequireWithInclude = require("functions/replace-require-with-include")

local function processFile(file: string)
  print("Processing: " .. file)
  
  replaceRequireWithInclude(file)
end


local function Initialize()
  print("Scanning directory: " .. buildDir)

  local extensions = { ".lua" }
  local files = scanWinDirectory(buildDir, extensions)

  print("Directory scan found " .. #files .. " files")

  for _, file in ipairs(files) do
    processFile(file)
  end
end

Initialize()
