--      stringpp (string plus plus)
--  expansion of string lib

local format = string.format

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


local stringpp = {}

---@param s string
---@return string
function stringpp.title(s)
    expected_args("title", {s}, {"string"})

    local spl = stringpp.split(s, " ")
    for i = 1, #spl do
        spl[i] = stringpp.captalize(spl[i])
    end
    return table.concat(spl, " ")
end

---@param s string
---@return string
function stringpp.capitalize(s)
    expected_args("capitalize", {s}, {"string"})
    return string.upper(string.sub(s, 1)) .. string.lower(string.sub(s, 2))
end

---@param s string
---@return string
function stringpp.casefold(s)
    expected_args("casefold", {s}, {"string"})
    return string.lower(s)
end

-- adjust `s` to center
---@param s string
---@param width integer
---@param fillchar string
---@return string
function stringpp.center(s, width, fillchar)
    expected_args("center", {s, width, fillchar}, {"string", "integer", "string"})
    fillchar = fillchar or " "

    local s_len = #s
    local fillchar_repeat = math.floor((width - s_len) / 2)
    local fillchar_rep_res = string.rep(fillchar, fillchar_repeat)
    local res = fillchar_rep_res .. s .. fillchar_rep_res

    if(#res ~= width) then res = res .. fillchar end

    return res
end

-- adjust `s` to left
---@param s string
---@param width integer
---@param fillchar string
---@return unknown
function stringpp.left(s, width, fillchar)
    expected_args("left", {s, width, fillchar}, {"string", "integer", "string"})

    local s_len = #s
    local fillchar_repeat = width - s_len
    local fillchar_rep_res = string.rep(fillchar, fillchar_repeat)

    return s .. fillchar_rep_res
end

-- adjust `s` to right
---@param s string
---@param width integer
---@param fillchar string
---@return unknown
function stringpp.right(s, width, fillchar)
    expected_args("right", {s, width, fillchar}, {"string", "integer", "string"})

    local s_len = #s
    local fillchar_repeat = width - s_len
    local fillchar_rep_res = string.rep(fillchar, fillchar_repeat)

    return fillchar_rep_res .. s
end

---@param s string
---@param x string
---@param start? integer
---@param stop? integer
---@return integer
function stringpp.count(s, x, start, stop)
    start = start or 1
    stop = stop or #s

    expected_args("count", {s, x, start, stop}, {"string", "string", "integer", "integer"})

    local x_len = #x
    local res = 0

    for i = start, stop do
        local next_chars = string.sub(s, i, i+x_len-1)
        if(next_chars == x) then
            res = res + 1
        end
    end

    return res
end

---@param s string
---@return boolean
function stringpp.isalpha(s)
    expected_args("isalpha", {s}, {"string"})

    return string.match(s, " ") == nil and
           string.match(s, "%d") == nil
end

---@param s string
---@return boolean
function stringpp.isdecimal(s)
    expected_args("isdecimal", {s}, {"string"})
    return tonumber(s) ~= nil
end

---@param s string
---@return boolean
function stringpp.islower(s)
    expected_args("islower", {s}, {"string"})
    return s == string.lower(s)
end

---@param s string
---@return boolean
function stringpp.isupper(s)
    expected_args("isupper", {s}, {"string"})
    return s == string.upper(s)
end

---@param s string
---@return boolean
function stringpp.isspace(s)
    expected_args("isspace", {s}, {"string"})
    if s == "" then return false end
    return string.gsub(s, " ", "") == ""
end

---@param s string
---@return boolean
function stringpp.istitle(s)
    expected_args("istitle", {s}, {"string"})
    return s == stringpp.title(s)
end

---@param s string
---@param sep string
---@return table
function stringpp.split(s, sep)
    expected_args("split", {s, sep}, {"string", "string"})

    s = s .. sep
    local str = ""
    local res = {}

    local i = 1
    while(i < #s+1) do
        local next_chars = string.sub(s, i, i+#sep-1)

        if(next_chars == sep) then
            i = i + #sep-1
            table.insert(res, str)
            str = ""
        else
            str = str .. string.sub(s, i, i)
        end
        i = i + 1
    end
    return res
end

return stringpp