local buildDir = "build"

local scanWinDirectory = require("functions/scan-win-directory")
local deleteLinesWithRequire = require("functions/delete-lines-with-require")
local replaceRequireWithInclude = require("functions/replace-require-with-include")
local getFileParentDirectory = require("functions/get-file-parent-directory")

local function processFile(file: string)
  print("Processing: " .. file)
  
  local parentDir = getFileParentDirectory(file)
  if parentDir == "functions" then -- TODO: FFIXME: This is a hack to prevent the functions directory from being processed :/
    deleteLinesWithRequire(file)
  end
  
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
