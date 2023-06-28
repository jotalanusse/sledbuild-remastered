local function replaceRequireWithInclude(filename: string)
  local file = io.open(filename, "r") -- Open the file in read mode
  if not file then
    error("Could not open file: " .. filename)
  end

  local content = file:read("*all") -- Read the entire content of the file
  file:close() -- Close the file

  local modifiedContent = string.gsub(content, 'require%(%s*"([^"]+)"%s*%)', 'include("sledbuildremastered/gamemode/%1.lua")') -- Replace "require" with "include" for require("string") and add ".lua"

  file = io.open(filename, "w") -- Open the file in write mode
  if not file then
    error("Could not open file: " .. filename)
  end

  file:write(modifiedContent) -- Write the modified content to the file
  file:close() -- Close the file
end

return replaceRequireWithInclude