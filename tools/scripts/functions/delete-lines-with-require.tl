local function deleteLinesWithRequire(fileName: string)
  local file = io.open(fileName, "r") -- Open the file in read mode
  if not file then
    error("Could not open file: " .. fileName)
  end

  local lines = {} -- Table to store the lines without require statements
  for line in file:lines() do
    if not string.match(line, 'require%(%s*".-"%s*%)') then
      table.insert(lines, line) -- Add the line to the table if it doesn't contain a require statement
    end
  end
  file:close() -- Close the file

  file = io.open(fileName, "w") -- Open the file in write mode
  if not file then
    error("Could not open file: " .. fileName)
  end

  file:write(table.concat(lines, "\n")) -- Write the modified lines to the file, joining them with newline character
  file:close() -- Close the file
end

return deleteLinesWithRequire
