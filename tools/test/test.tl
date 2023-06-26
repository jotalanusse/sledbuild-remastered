-- local function scanDirectory(directory: string, extensions: {string}): {string}
--   local files = {}
--   local handle = io.popen('dir "'..directory..'" /b /a-d')

--   if handle then
--       for file in handle:lines() do
--           local fileExtension = file:match("^.+(%..+)$")
--           if fileExtension and extensions then
--               for _, extension in ipairs(extensions) do
--                   if fileExtension == extension then
--                       table.insert(files, directory..'\\'..file)
--                       break
--                   end
--               end
--           else
--               table.insert(files, directory..'\\'..file)
--           end
--       end
--       handle:close()
--   else
--       return nil
--   end

--   handle = io.popen('dir "'..directory..'" /b /ad')
--   if handle then
--       for subdir in handle:lines() do
--           local path = directory..'\\'..subdir
--           local attributes = io.popen('attrib "'..path..'"'):read("*a")
--           if attributes:match("D") then
--               local subfiles = scanDirectory(path, extensions)
--               if subfiles then
--                   for _, subfile in ipairs(subfiles) do
--                       table.insert(files, subfile)
--                   end
--               end
--           end
--       end
--       handle:close()
--   end

--   return files
-- end

-- local function hasLastEmptyLine(fileName: string): boolean
--   local file = io.open(fileName, "r")

--   if file then
--       local lastLine: string

--       for line in file:lines() do
--           lastLine = line
--       end

--       file:close()



--       if lastLine then
--         print("'" .. lastLine .. "'")
--         return true
--       end
--   end

--   return false
-- end

-- local function checkLastEmptyLine(fileName: string)
--   local isLastLineEmpty = hasLastEmptyLine(fileName)

--   if not isLastLineEmpty then
--       print("Missing empty line at the end of file: "..fileName)
--   end
-- end


-- local function checkFile(fileName: string)
--   checkLastEmptyLine(fileName)
-- end

-- local function checkFiles(files: {string})
--   for _, file in ipairs(files) do
--     checkFile(file)
--   end
-- end

-- local function Main()
--   local extensions = { ".tl" }
--   local files = scanDirectory("src", extensions)

--   checkFiles(files)
-- end

-- Main()
