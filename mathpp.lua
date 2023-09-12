--             mathpp (math plus plus)
-- extension of the standard Lua Lib (math)

local lua_math = require("math")

local format = string.format



-- expansion of `type`
local function type_pp(x)
    if lua_math.type(x) ~= "nil" then return lua_math.type(x) else return type(x) end
end

local function expected_arg(func_name, x, tp, arg)
    if tp == "float" or tp == "integer" then
        assert(lua_math.type(x) == tp, format("bad argument #%d to '%s' (%s expected, got %s)", arg, func_name, tp, type_pp(x)))
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
    expected_args("acos", {x}, {"number"})
    return lua_math.acos(x)
end

---@param x number
---@return number
function math.acosh(x)
    expected_args("acosh", {x}, {"number"})
    return lua_math.log(x + lua_math.sqrt(x^2 - 1))
end

---@param x number
---@return number
function math.asin(x)
    expected_args("asin", {x}, {"number"})
    return lua_math.asin(x)
end

---@param x number
---@return number
function math.asinh(x)
    expected_args("asinh", {x}, {"number"})
    return lua_math.log(x + lua_math.sqrt(x^2 + 1))
end

---@param x number
---@return number
function math.atan(x)
    expected_args("atan", {x}, {"number"})
   return lua_math.atan(x)
end

---@param x number
---@param y number
---@return number
function math.atan2(y, x)
    expected_args("atan2", {y,x}, {"number", "integer"})
    return lua_math.atan(y, x)
end

---@param x number
---@return number
function math.atanh(x)
    expected_args("atanh", {x}, {"number"})
    return 0.5 * lua_math.log((1 + x) / (1 - x))
end

---@param x number
---@return number
function math.ceil(x)
    expected_args("ceil", {x}, {"number"})
    return lua_math.floor(x) + 1
end

---@param n integer
---@param k integer
---@return integer
function math.comb(n, k)
    expected_args("comb", {n, k}, {"integer", "integer"})
    return math.factorial(n) / (math.factorial(k) * (n - k))
end

---@param x number
---@param y number
---@return number
function math.copysign(x, y)
    expected_args("copysign", {x, y}, {"number", "number"})
    if y < 0 then return -lua_math.abs(x) end
    return lua_math.abs(x)
end

---@param x number
---@return number
function math.cos(x)
    expected_args("cos", {x}, {"number"})
    return lua_math.cos(x)
end

---@param x number
---@return number
function math.cosh(x)
    expected_args("cosh", {x}, {"number"})
    return (lua_math.exp(x) + lua_math.exp(-x)) / 2
end

---@param x number
---@return number
function math.degress(x)
    expected_args("degress", {x}, {"number"})
    return x * (180 / math.pi)
end

---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
---@return number
function math.dist(x1, y1, x2, y2)
    expected_args("dist", {x1, y1, x2, y2}, {"number", "number", "number", "number"})
    return lua_math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

---@param x number
---@return number
function math.exp(x)
    expected_args("exp", {x}, {"number"})
    return lua_math.exp(x)
end

---@param x number
---@return number
function math.expm1(x)
    expected_args("expm1", {x}, {"number"})
    return lua_math.exp(x) - 1
end

---@param x number
---@return number
function math.fabs(x)
    expected_args("fabs", {x}, {"number"})
    return lua_math.abs(x)
end

---@param x integer
---@return number
function math.factorial(x)
    expected_args("factorial", {x}, {"integer"})

    local fat = 1

    for i = 1, x do
        fat = fat * i
    end

    return fat
end

---@param x number
---@return integer
function math.floor(x)
    expected_args("floor", {x}, {"number"})
    return lua_math.floor(x)
end

---@param x number
---@param y number
---@return number
function math.fmod(x, y)
    expected_args("fmod", {x, y}, {"number", "number"})
    return lua_math.fmod(x, y)
end

---@param x number
---@return integer
---@return integer
function math.frexp(x)
    expected_args("frexp", {x}, {"number"})

    if x == 0 then
        return 0, 0
    elseif x == lua_math.huge or x == -lua_math.huge or x ~= x then
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
    expected_args("fsum", {seq}, {"table"})
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
    expected_args("hypot", {x, y}, {"number", "number"})
    return lua_math.sqrt(x^2 + y^2)
end

---@param x number
---@return boolean
function math.isinf(x)
    expected_args("isinf", {x}, {"number"})
    return x == math.inf
end

---@param x number
---@return boolean
function math.isnan(x)
    expected_args("isnan", {x}, {"number"})
    return x == math.nan
end

---@param x number
---@param i number
---@return number
function math.ldexp(x, i)
    expected_args("ldexp", {x, i}, {"number", "number"})
    return x * 2 ^ i
end

---@param x number
---@param base? integer
---@return number
function math.log(x, base)
    expected_args("log", {x, base}, {"number", "integer"})
    return lua_math.log(x, base)
end

---@param x number
---@return number
function math.sin(x)
    expected_args("sin", {x}, {"number"})
    return lua_math.sin(x)
end

---@param x number
---@return number
function math.sinh(x)
    expected_args("sinh", {x}, {"number"})
    return (lua_math.exp(x) -(lua_math.exp(-x)))/2
end

---@param x number
---@return number
function math.sqrt(x)
    expected_args("sqrt", {x}, {"number"})
    return lua_math.sqrt(x)
end

---@param x number
---@return number
function math.tan(x)
    expected_args("tan", {x}, {"number"})
    return lua_math.tan(x)
end

---@param x number
---@return number
function math.tanh(x)
    expected_args("tanh", {x}, {"number"})
    return (lua_math.exp(2*x) - 1) / (lua_math.exp(2*x + 1))
end

---@param x number
---@return number
function math.abs(x)
    expected_args("abs", {x}, {"number"})
    return lua_math.abs(x)
end

return math