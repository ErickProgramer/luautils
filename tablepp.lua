local unpack = table.unpack or unpack
local format = string.format

local aux = require("auxiliar")
local expected_args = aux.expected_args

local tablepp = {}

--- returns the largest value of `t`
---@param t table
---@return any
function tablepp.max(t)
    expected_args("max", {t}, {"table"})

    if math.max then
        return math.max(unpack(t))
    end

    local max_value = t[1]

    for _, v in ipairs(t) do
        if v > max_value then max_value = v end
    end

    return max_value
end

--- returns the smallest value of `t`
---@param t table
---@return any
function tablepp.min(t)
    expected_args("min", {t}, {"table"})

    if math.min then
        return math.min(unpack(t))
    end

    local min_value = t[1]

    for _, v in ipairs(t) do
        if v < min_value then min_value = v end
    end

    return min_value
end

--- returns the index where the largest value of `t` is
---@param t table
---@return integer
function tablepp.argmax(t)
    expected_args("argmax", {t}, {"table"})

    local max_v, max_i = t[1], 1

    for i, v in ipairs(t) do
        if v > max_v then
            max_i = i
            max_v = v
        end
    end

    return max_i
end

--- returns the index where the smallest value of `t` is
---@param t table
---@return integer
function tablepp.argmin(t)
    expected_args("argmin", {t}, {"table"})

    local min_v, min_i = t[1], 1

    for i, v in ipairs(t) do
        if v < min_v then
            min_i = i
            min_v = v
        end
    end

    return min_i
end

--- transform `t` in string
---```lua
---tablepp.list_tostring({{1,"a"}, 1, {"\n", true, false}}) --> {{1, "a"}, 1, {"\n", true, false}}
---```
---@param t table
---@return string
function tablepp.list_tostring(t)
    expected_args("list_tostring", {t}, {"table"})

    local str = "{"
    for i, v in ipairs(t) do
        if type(v) == "string" then
            str = str .. "'" .. v:gsub("\n", "\\n") .. "'"
        elseif type(v) ~= "table" then
            str = str .. tostring(v)
        else
            str = str .. tablepp.list_tostring(v)
        end

        str = str .. ", "
    end
    return str .."}"
end

--- print the table `t`
---```
---tablepp.list_print({1,2})
---```
--- {1, 2}
---@param t table
---@param end_line? string
function tablepp.list_print(t, end_line)
    end_line = end_line or "\n"

    expected_args("list_print", {t, end_line}, {"table", "string"})

    local function s()
        io.write("{")
        for i, v in ipairs(t) do
            if type(v) == "string" then
                io.write("'"..v:gsub("\n", "\\n").."'")
            elseif type(v) ~= "table" then
                io.write(tostring(v))
            else
                tablepp.list_print(v)
            end

            io.write(", ")
        end
        io.write("}")
    end
    s()
    io.write(end_line)
end

--- similar to Lua's standard print, but with table support
---@param ... any
function tablepp.print(...)
    local args = {...}
    for i, v in ipairs(args) do
        if type(v) == "table" then
            tablepp.list_print(v, "\t")
        else
            io.write(v)
            io.write("\t")
        end
    end
    io.write("\n")
end

--- orders from smallest to largest by default, but if `reverse` is true, it orders from largest to smallest
---@param t table
---@param reverse? boolean
function tablepp.sort(t, reverse)
    expected_args("sort", {t, reverse}, {"table", "boolean"})

    if reverse then
        table.sort(t, function (a, b)
            return a > b
        end)
    else
        table.sort(t, function (a, b)
            return a < b
        end)
    end
end

--- works exactly the same as the Lua unpack, but with support for all versions of Lua
---@generic T
---@param t T[]
---@return T ...
function tablepp.unpack(t)
    expected_args("unpack", {t}, {"table"})
    return unpack(t)
end

---Executes the given f over all elements of table. For each element, f is called with the index and respective value as arguments. If f returns a non-nil value, then the loop is broken, and this value is returned as the final value of foreach.
---@generic T
---@param list T[]
---@param callback fun(key: T, value: T): T | nil
---@return T | nil
function tablepp.foreach(list, callback)
    expected_args("foreach", {list, callback}, {"table", "function"})

    if table.foreach then
        return table.foreach(list, callback)
    end

    for k, v in pairs(list) do
        local res = callback(k, v)
        if res ~= nil then return res end
    end

    return nil
end

--- Executes the given f over the numerical indices of table. For each index, f is called with the index and respective value as arguments. Indices are visited in sequential order, from 1 to n, where n is the size of the table. If f returns a non-nil value, then the loop is broken and this value is returned as the result of foreachi.
---@generic T
---@param list T[]
---@param callback fun(key: T, value: T): T | nil
---@return T | nil
function tablepp.foreachi(list, callback)
    if table.foreachi then
        return table.foreachi(list, callback)
    end

    for k, v in ipairs(list) do
        local res = callback(k, v)
        if res ~= nil then return res end
    end

    return nil
end

--- returns all the original table but only where the function returned true
---@generic T
---@param list T[]
---@param callback fun(key: T, value: T):boolean
---@return table
function tablepp.filter(list, callback)
    local result = {}
    for k, v in pairs(list) do
        if callback(k, v) then
            result[k] = v
        end
    end
    return result
end

--- similar to filter but iterates like an array, thus maintaining the sequence correctly, unlike filter
---@generic T
---@param list T[]
---@param callback fun(key: T, value: T):boolean
---@return table
function tablepp.filteri(list, callback)
    local result = {}
    for k, v in ipairs(list) do
        if callback(k, v) then
            table.insert(result, v)
        end
    end
    return result
end

--- returns `#list`
---@generic T
---@param list T[]
---@return integer
function tablepp.getn(list)
    return #list
end

return tablepp