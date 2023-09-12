--             mathpp (math plus plus)
-- extension of the standard Lua Lib (math)

local lua_math = require("math")


-- auxiliars
local function expected_number(x)
    assert(type(x) == "number", "expected number, got " .. type(x))
end

local function expected_arg(func_name, x, tp, arg)
    assert(type(x) == tp, string.format("bad argument #%d to '%s' (%s expected, got %s)"), arg, func_name, tp, type(x))
end

local function expected_args(func_name, values, expected)
    for i = 1, #values do
        expected_arg(func_name, values[i], expected[i], i)
    end
end

local math = {}

-- constants --
math.e   = 2.7182818284590452354
math.pi  = lua_math.pi
math.inf = lua_math.huge
math.nan = 0/0
---------------

---@param x number
---@return number
function math.acos(x)
    expected_number(x)
    return lua_math.acos(x)
end

---@param x number
---@return number
function math.acosh(x)
    expected_number(x)
    return lua_math.log(x + lua_math.sqrt(x^2 - 1))
end

---@param x number
---@return number
function math.asin(x)
    expected_number(x)
    return lua_math.asin(x)
end

---@param x number
---@return number
function math.asinh(x)
    expected_number(x)
    return lua_math.log(x + lua_math.sqrt(x^2 + 1))
end

---@param x number
---@return number
function math.atan(x)
    expected_number(x)
   return lua_math.atan(x)
end

---@param x number
---@param y number
---@return number
function math.atan2(y, x)
    expected_arg("atan", y, "number", 1)
    expected_arg("atan", x, "number", 1)
    return lua_math.atan(y, x)
end

---@param x number
---@return number
function math.atanh(x)
    expected_number(x)
    return 0.5 * lua_math.log((1 + x) / (1 - x))
end

---@param x number
---@return number
function math.ceil(x)
    expected_number(x)
    return lua_math.floor(x) + 1
end

---@param n integer
---@param k integer
---@return integer
function math.comb(n, k)
    return math.factorial(n) / (math.factorial(k) * (n - k))
end

---@param x number
---@param y number
---@return number
function math.copysign(x, y)
    expected_arg("copysign", x, "number", 1)
    expected_arg("copysign", y, "number", 1)
    if y < 0 then return -math.abs(x) end
    return math.abs(x)
end

---@param x number
---@return number
function math.cos(x)
    expected_number(x)
    return lua_math.cos(x)
end

---@param x number
---@return number
function math.cosh(x)
    expected_number(x)
    return (lua_math.exp(x) + lua_math.exp(-x)) / 2
end

---@param x number
---@return number
function math.degress(x)
    expected_number(x)
    return x * (180 / math.pi)
end

---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
---@return number
function math.dist(x1, y1, x2, y2)
    expected_arg("dist", x1, "number", 1)
    expected_arg("dist", y1, "number", 1)
    expected_arg("dist", x2, "number", 1)
    expected_arg("dist", y2, "number", 1)
    return lua_math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

---@param x number
---@return number
function math.exp(x)
    expected_number(x)
    return lua_math.exp(x)
end

---@param x number
---@return number
function math.expm1(x)
    expected_number(x)
    return lua_math.exp(x) - 1
end

---@param x number
---@return number
function math.fabs(x)
    expected_number(x)
    return lua_math.abs(x)
end

---@param x integer
---@return number
function math.factorial(x)
    assert(lua_math.type(x) == "integer", "impossible to make factorial of float")

    local fat = 1

    for i = 1, x do
        fat = fat * i
    end

    return fat
end

---@param x number
---@return integer
function math.floor(x)
    expected_number(x)
    return lua_math.floor(x)
end

---@param x number
---@param y number
---@return number
function math.fmod(x, y)
    expected_arg("fmod", x, "number", 1)
    expected_arg("fmod", y, "number", 1)
    return lua_math.fmod(x, y)
end

---@param x number
---@return integer
---@return integer
function math.frexp(x)
    expected_number(x)
    if x == 0 then
        return 0, 0
    elseif x == math.huge or x == -math.huge or x ~= x then
        return x, 0
    end

    local e = 0
    while math.abs(x) >= 1 do
        x = x / 2
        e = e + 1
    end

    return x, e
end

---@param seq table
---@return number
function math.fsum(seq)
    expected_arg("fsum", seq, "table", 1)
    local sum = 0
    for i, v in ipairs(seq) do
        sum = sum + v
    end
    return sum
end

---@param x number
---@param y number
---@return number
function math.hypot(x, y)
    expected_arg("hypot", x, "number", 1)
    expected_arg("hypot", x, "number", 2)
    return lua_math.sqrt(x^2 + y^2)
end

---@param x number
---@return boolean
function math.isinf(x)
    expected_number(x)
    return x == math.inf
end

---@param x number
---@return boolean
function math.isnan(x)
    expected_number(x)
    return x == math.nan
end

---@param x number
---@param i number
---@return number
function math.ldexp(x, i)
    expected_arg("ldexp", x, "number", 1)
    expected_arg("ldexp", i, "number", 2)
    return x * 2 ^ i
end

---@param x number
---@param base? integer
---@return number
function math.log(x, base)
    expected_arg("log", x, "number", 1)
    expected_arg("log", base, "integer", 1)
    return lua_math.log(x, base)
end

---@param x number
---@return number
function math.sin(x)
    expected_number(x)
    return lua_math.sin(x)
end

---@param x number
---@return number
function math.sinh(x)
    expected_number(x)
    return (lua_math.exp(x) -(lua_math.exp(-x)))/2
end

---@param x number
---@return number
function math.sqrt(x)
    expected_number(x)
    return lua_math.sqrt(x)
end

---@param x number
---@return number
function math.tan(x)
    expected_number(x)
    return lua_math.tan(x)
end

---@param x number
---@return number
function math.tanh(x)
    expected_number(x)
    return (lua_math.exp(2*x) - 1) / (lua_math.exp(2*x + 1))
end

return math