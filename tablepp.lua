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
    expected_args("foreachi", {list, callback}, {"table", "function"})

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
    expected_args("filter", {list, callback}, {"table", "function"})

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
    expected_args("filteri", {list, callback}, {"table", "function"})

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
    expected_args("getn", {list}, {"table"})

    return #list
end

---@generic T
---@param list T[]
---@param value T
function tablepp.append(list, value)
    expected_args("append", {list}, {"table"})
    list[#list+1] = value
end

--- returns how many times `value` appears in `t`
---@generic T
---@param list T[]
---@param value any
---@return integer
function tablepp.count(list, value)
    expected_args("count", {list}, {"table"})

    local res = 0
    for k, v in pairs(list) do
        if v == value then res = res + 1 end
    end
    return res
end

-- auxiliar function for copy
local function recursive_copy(t)
    local copy = {}
    for k, v in pairs(t) do
        if type(t) == "table" then
            copy[k] = tablepp.copy(v)
        else
            copy[k] = v
        end
    end
    return copy
end

--- returns an identical copy of `t`
---@generic T
---@param t T[]
---@return T[]
function tablepp.copy(t)
    expected_args("copy", {t}, {"table"})
    return recursive_copy(t)
end

--- returns the reverse order of T
---@generic T
---@param t T[]
---@return T[]
function tablepp.reverse(t)
    expected_args("reverse", {t}, {"table"})

    local reverse = {}
    local pos = 1
    for i = #t, 1, -1 do
        reverse[pos] = t[i]
        pos = pos + 1
    end
    return reverse
end

--- returns `t` starting at `start` to `stop` skipping at `step`
---@generic T
---@param t T []
---@param start integer
---@param stop? integer
---@param step? integer
---@return table
function tablepp.slice(t, start, stop, step)
    step = step or 1
    if start and not stop then
        stop, start = start, 1
    end
    expected_args("slice", {t, start, stop, step}, {"table", "integer", "integer", "integer"})

    local result = {}
    local pos = 1
    for i = start, stop, step do
        result[pos] = t[i]
        pos = pos + 1
    end

    return result
end

--- returns at which index `value` appears
---@generic T
---@param t T[]
---@param value any
---@return T | nil
function tablepp.index(t, value)
    expected_args("index", {t}, {"table"})

    for k, v in pairs(t) do
        if v == value then return k end
    end
    return nil
end

---
---Moves elements from table `a1` to table `a2`.
---```lua
---a2[t],··· =
---a1[f],···,a1[e]
---return a2
---```
---@param a1  table
---@param f   integer
---@param e   integer
---@param t   integer
---@param a2? table
---@return table a2
function tablepp.move(a1, f, e, t, a2)
    return table.move(a1, f, e, t, a2)
end

--- returns if `t` is list or dict
---@param t table
---@return "dict" | "list"
function tablepp.type(t)
    expected_args("type", {t}, {"table"})

    local len = 0
    for k, v in pairs(t) do
        len = len + 1
    end
    if len ~= #t then return "dict" else return "list" end
end

--- returns the keys of `t`
---@param t table
---@return table
function tablepp.keys(t)
    expected_args("keys", {t}, {"table"})

    local keys = {}
    local p = 1
    for k in pairs(t) do
        keys[p] = k
        p = p + 1
    end
    return keys
end

--- returns the values of `t`
---@param t table
---@return table
function tablepp.values(t)
    expected_args("values", {t}, {"table"})

    local values = {}
    local p = 1
    for _, v in pairs(t) do
        values[p] = v
        p = p + 1
    end

    return values
end

local function recursive_tolist(dict)
    local res = {}
    local p = 1

    for k, v in pairs(dict) do
        if type(v) == "table" then
            res[p] = {k, recursive_tolist(v)}
        else
            res[p] = {k, v}
        end
        p = p + 1
    end

    return res
end

--- transforms `dict` to `list`
---```
---local dict = {a = 1, b = 2, c = 3}
---tablepp.tolist(dict) --> {{a, 1}, {b, 2}, {c, 3}}
---```
---@param dict table
---@return table
function tablepp.tolist(dict)
    expected_args("tolist", {dict}, {"table"})
    return recursive_tolist(dict)
end

return tablepp