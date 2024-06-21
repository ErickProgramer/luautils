-- MIT License
--
-- Copyright (c) 2023 LuaUtils
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

--      stringpp (string plus plus)
--  expansion of string lib


local ok, aux = pcall(require, "luautils.auxiliar")
if not ok then
    ok, aux = pcall(require, "auxiliar")
end

local expected_args = aux.expected_args


---@class stringpplib: stringlib
local stringpp = {}

--- it returns a version of the string where each word is titlecased.
---```
---stringpp.title("exAMPLe") --> Example
---stringpp.title("anotheR EXAmPLE") --> Another Example
---```
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

--- it returns a capitalized version of the string.
---```
---stringpp.capitalize("fiRST eXAMPLe") --> First example
---stringpp.capitalize("sECOND example") --> Second example
---```
---@param s string
---@return string
function stringpp.capitalize(s)
    expected_args("capitalize", {s}, {"string"})
    return string.upper(string.sub(s, 1)) .. string.lower(string.sub(s, 2))
end

--- Return a version of the string suitable for caseless comparisons.
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

--- returns how many times `x` appeared in `s` starting from the `start` position to the `stop` position
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

--- Return True if the string is an alphabetic string, False otherwise.
--- A string is alphabetic if all characters in the string are alphabetic and there
--- is at least one character in the string.
---@param s string
---@return boolean
function stringpp.isalpha(s)
    expected_args("isalpha", {s}, {"string"})

    return string.match(s, " ") == nil and
           string.match(s, "%d") == nil
end

--- Return True if the string is a decimal string, False otherwise.
--- A string is a decimal string if all characters in the string are decimal and
--- there is at least one character in the string.
---@param s string
---@return boolean
function stringpp.isdecimal(s)
    expected_args("isdecimal", {s}, {"string"})
    return tonumber(s) ~= nil
end

--- Return True if the string is a lowercase string, False otherwise.
--- A string is lowercase if all cased characters in the string are lowercase and
--- there is at least one cased character in the string.
---@param s string
---@return boolean
function stringpp.islower(s)
    expected_args("islower", {s}, {"string"})
    return s == string.lower(s)
end

--- Return True if the string is an uppercase string, False otherwise.
--- A string is uppercase if all cased characters in the string are uppercase and
--- there is at least one cased character in the string.
---@param s string
---@return boolean
function stringpp.isupper(s)
    expected_args("isupper", {s}, {"string"})
    return s == string.upper(s)
end

--- Return True if the string is a whitespace string, False otherwise.
--- A string is whitespace if all characters in the string are whitespace and there
--- is at least one character in the string.
---@param s string
---@return boolean
function stringpp.isspace(s)
    expected_args("isspace", {s}, {"string"})
    if s == "" then return false end
    return string.gsub(s, " ", "") == ""
end

--- Return True if the string is a title-cased string, False otherwise.
--- In a title-cased string, upper- and title-case characters may only
--- follow uncased characters and lowercase characters only cased ones.
---@param s string
---@return boolean
function stringpp.istitle(s)
    expected_args("istitle", {s}, {"string"})
    return s == stringpp.title(s)
end

--- splits `s` with `sep` separator
---```
---stringpp.split("Hello World!") --> {"Hello", "World!"}
---stringpp.split("Hello,World!,") --> {"Hello", "World!", ""}
---```
---@param s string
---@param sep string
---@return table
function stringpp.split(s, sep)
    sep = sep or " "
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