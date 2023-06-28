local function getFileParentDirectory(fileName: string): string
  local parentDirectory = fileName:match(".-([^\\]+)\\[^\\]+$")

  return parentDirectory
end

return getFileParentDirectory
