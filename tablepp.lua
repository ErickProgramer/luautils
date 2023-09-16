local unpack = table.unpack or unpack
local format = string.format

local tablepp = {}

-- expansion of `type`
local function type_pp(x)
    if math.type(x) ~= "nil" then return math.type(x) else return type(x) end
end

local function expected_arg(func_name, x, tp, arg)
    if tp == "float" or tp == "integer" then
        assert(math.type(x) == tp, format("bad argument #%d to '%s' (%s expected, got %s)", arg, func_name, tp, type_pp(x)))
    else
        assert(type(x) == tp, format("bad argument #%d to '%s' (%s expected, got %s)", arg, func_name, tp, type(x)))
    end
end

-- to errors
---@param func_name string
---@param values table
---@param expected table
local function expected_args(func_name, values, expected)
    for i = 1, #values do
        expected_arg(func_name, values[i], expected[i], i)
    end
end

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

---@param t table
---@param reverse? boolean
function tablepp.sort(t, reverse)
    expected_args("sort", {t, reverse}, {"table", "boolean"})

    if reverse then
        return table.sort(t, function (a, b)
            return a > b
        end)
    else
        return table.sort(t, function (a, b)
            return a < b
        end)
    end
end

---@generic T
---@param t table
---@return ...<T>
function tablepp.unpack(t)
    expected_args("unpack", {t}, {"table"})
    return unpack(t)
end

return tablepp