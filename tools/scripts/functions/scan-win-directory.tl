local function scanWinDirectory(directory: string, extensions: {string}): {string}
  local files = {}
  local handle = io.popen('dir "'..directory..'" /b /a-d')

  if handle then
    for file in handle:lines() do
      local fileExtension = file:match("^.+(%..+)$")

      if fileExtension and extensions then
        for _, extension in ipairs(extensions) do
          if fileExtension == extension then
            table.insert(files, directory..'\\'..file)
            break
          end
        end
      else
        table.insert(files, directory..'\\'..file)
      end
    end
    handle:close()
  else
    return nil
  end

  handle = io.popen('dir "'..directory..'" /b /ad')
  if handle then
    for subdir in handle:lines() do
      local path = directory..'\\'..subdir
      local attributes = io.popen('attrib "'..path..'"'):read("*a")

      if attributes:match("D") then
        local subfiles = scanWinDirectory(path, extensions)

        if subfiles then
          for _, subfile in ipairs(subfiles) do
            table.insert(files, subfile)
          end
        end
      end
    end
    handle:close()
  end

  return files
end


return scanWinDirectory