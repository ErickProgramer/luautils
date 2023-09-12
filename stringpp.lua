--      stringpp (string plus plus)
--  expansion of string lib

local stringpp = {}

---@param s string
---@return string
function stringpp.title(s)
    local spl = stringpp.split(s, " ")
    for i = 1, #spl do
        spl[i] = stringpp.captalize(spl[i])
    end
    return table.concat(spl, " ")
end

---@param s string
---@return string
function stringpp.captalize(s)
    return string.upper(string.sub(s, 1)) .. string.lower(string.sub(s, 2))
end

---@param s string
---@return string
function stringpp.casefold(s)
    return string.lower(s)
end

-- adjust `s` to center
---@param s string
---@param width integer
---@param fillchar string
---@return string
function stringpp.center(s, width, fillchar)
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
    return string.match(s, " ") == nil and
           string.match(s, "%d") == nil
end

---@param s string
---@return boolean
function stringpp.isdecimal(s)
    return tonumber(s) ~= nil
end

---@param s string
---@return boolean
function stringpp.islower(s)
    return s == string.lower(s)
end

---@param s string
---@return boolean
function stringpp.isupper(s)
    return s == string.upper(s)
end

---@param s string
---@return boolean
function stringpp.isspace(s)
    if s == "" then return false end
    return string.gsub(s, " ", "") == ""
end

---@param s string
---@return boolean
function stringpp.istitle(s)
    return s == stringpp.title(s)
end

---@param s string
---@param sep string
---@return table
function stringpp.split(s, sep)
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