local unpack = table.unpack or unpack

local tablepp = {}

function tablepp.max(t)
    if math.max then
        return math.max(unpack(t))
    end

    local max_value = t[1]

    for _, v in ipairs(t) do
        if v > max_value then max_value = v end
    end

    return max_value
end

function tablepp.min(t)
    if math.min then
        return math.min(unpack(t))
    end
    if math.max then
        return math.max(unpack(t))
    end
    local min_value = t[1]

    for _, v in ipairs(t) do
        if v < min_value then min_value = v end
    end

    return min_value
end

function tablepp.argmax(t)
    local max_v, max_i = t[1], 1

    for i, v in ipairs(t) do
        if v > max_v then
            max_i = i
            max_v = v
        end
    end

    return max_i
end

function tablepp.argmin(t)
    local min_v, min_i = t[1], 1

    for i, v in ipairs(t) do
        if v < min_v then
            min_i = i
            min_v = v
        end
    end

    return min_i
end

function tablepp.list_tostring(t)
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

function tablepp.list_print(t, end_line)
    end_line = end_line or "\n"
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

function tablepp.sort(t, reverse)
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

function tablepp.unpack(t)
    return unpack(t)
end

return tablepp