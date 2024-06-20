-- O.S library expansion

local os = require("os")
local io = require("io")

---@type table | oslib
local ospp = {}



---@return "win"|"unix"
function ospp.get()
    return package.config:sub(1,1) == "\\" and "win" or "unix"
end

---@type "nul"|"/dev/null"
ospp.devnull = "nul" and ospp.get() == "win" or "/dev/null"

local join_paths

if ospp.get() == "win" then
    function join_paths(...)
        return table.concat({...}, "\\"):gsub("/", "\\"):gsub("\\+", "\\")
    end
else
    function join_paths(...)
        return table.concat({...}, "/"):gsub("\\", "/"):gsub("/+", "/")
    end
end

do
    local get_path_cmd = ospp.get() == "win" and "cd" or "pwd"

    ---@return string | nil
    function ospp.curdir()
        local cmd = io.popen(get_path_cmd)
        if not cmd then
            return nil
        end

        local path = cmd:read()
        cmd:close()

        return path
    end
end

do
    local disk = ospp.get() == "win" and "C:\\" or "/"
    function ospp.move(path, to)
        local new_path
        if path:sub(1, #disk) == disk then
            new_path = to
        else
            new_path = join_paths(to, path)
        end

        print(new_path)
        os.rename(path, new_path)

        return new_path
    end
end

function ospp.mkdir(dirname)
    io.popen('mkdir "' .. dirname .. '"')
end

if ospp.get() == "win" then
    function ospp.setenv(name, value)
        io.popen('setx ' .. name .. ' "' .. value .. '"'):close()
    end
else
    function ospp.setenv(name, value)
        io.popen('export ' .. name .. '="' .. value .. '"'):close()
    end
end

if ospp.get() == "win" then
    function ospp.listdir(dirname)
        if dirname == nil then dirname = "." end
        local files = {}
        for file in io.popen('dir "' .. dirname .. '" /b /a'):lines() do table.insert(files, file) end
        return files
    end
else
    function ospp.listdir(dirpath)
        if dirpath == nil then dirpath = "." end
        local p = io.popen('ls -A1 "'..dirpath..'"')
        local files = {}

        -- Read the output line by line
        for file in p:lines() do
            table.insert(files, file)
        end

        p:close()
        return files
    end
end

function ospp.isfile(path)
    local f = io.open(path, "r")
    if not f then
        return false
    end

    return io.type(f) == "file" or io.type(f) == "closed file"
end

for k, v in pairs(os) do
    if not ospp[k] then ospp[k] = v end
end

return ospp