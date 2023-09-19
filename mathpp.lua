--             mathpp (math plus plus)
-- extension of the standard Lua Lib (math)

local aux = require("auxiliar")
local lua_math = require("math")

local expected_args = aux.expected_args

local math = {}

-- constants --
math.e   = 2.7182818284590452354
math.pi  = lua_math.pi
math.inf = lua_math.huge
math.nan = 0/0
---------------

--- return the acos of `x`
---@param x number
---@return number
function math.acos(x)
    expected_args("acos", {x}, {"number"})
    return lua_math.acos(x)
end

--- return the acosh of `x`
---@param x number
---@return number
function math.acosh(x)
    expected_args("acosh", {x}, {"number"})
    return lua_math.log(x + lua_math.sqrt(x^2 - 1))
end

--- return the asin of `x`
---@param x number
---@return number
function math.asin(x)
    expected_args("asin", {x}, {"number"})
    return lua_math.asin(x)
end

--- return the asinh of `x`
---@param x number
---@return number
function math.asinh(x)
    expected_args("asinh", {x}, {"number"})
    return lua_math.log(x + lua_math.sqrt(x^2 + 1))
end

--- return the atan of `x`
---@param x number
---@return number
function math.atan(x)
    expected_args("atan", {x}, {"number"})
   return lua_math.atan(x)
end

--- return the atan2 of `x` and `y`
---@param x number
---@param y number
---@return number
function math.atan2(y, x)
    expected_args("atan2", {y,x}, {"number", "integer"})
    return lua_math.atan(y, x)
end

--- return the atanh of `x`
---@param x number
---@return number
function math.atanh(x)
    expected_args("atanh", {x}, {"number"})
    return 0.5 * lua_math.log((1 + x) / (1 - x))
end

--- rounds to the nearest whole number
---@param x number
---@return number
function math.ceil(x)
    expected_args("ceil", {x}, {"number"})
    return lua_math.ceil(x)
end

--- Find the total number of possibilities to choose `k` things from `n` items
---@param n integer
---@param k integer
---@return integer
function math.comb(n, k)
    expected_args("comb", {n, k}, {"integer", "integer"})
    return math.factorial(n) / (math.factorial(k) * (n - k))
end

--- copy the signal of `y` to `x` (doesn't work with 0)
---@param x number
---@param y number
---@return number
function math.copysign(x, y)
    expected_args("copysign", {x, y}, {"number", "number"})
    if y < 0 then return -lua_math.abs(x) end
    return lua_math.abs(x)
end

--- return the cos of `x`
---@param x number
---@return number
function math.cos(x)
    expected_args("cos", {x}, {"number"})
    return lua_math.cos(x)
end

--- return the cosh of `x`
---@param x number
---@return number
function math.cosh(x)
    expected_args("cosh", {x}, {"number"})
    return (lua_math.exp(x) + lua_math.exp(-x)) / 2
end

--- Convert angles from radians to degrees
---@param x number
---@return number
function math.degress(x)
    expected_args("degress", {x}, {"number"})
    return x * (180 / math.pi)
end

--- return the distance of the points `x1`, `y1`, `x2` and `y2`
---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
---@return number
function math.dist(x1, y1, x2, y2)
    expected_args("dist", {x1, y1, x2, y2}, {"number", "number", "number", "number"})
    return lua_math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

--- returns the value `e^x` (equivalent to: `math.e ^ x`)
---@param x number
---@return number
function math.exp(x)
    expected_args("exp", {x}, {"number"})
    return lua_math.exp(x)
end

--- return the expm1 of `x`
---@param x number
---@return number
function math.expm1(x)
    expected_args("expm1", {x}, {"number"})
    return lua_math.exp(x) - 1
end

--- return `x` positive
---@param x number
---@return number
function math.fabs(x)
    expected_args("fabs", {x}, {"number"})
    return lua_math.abs(x)
end

--- return the factorial of `x`
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

--- convert `x` to integer
---@param x number
---@return integer
function math.floor(x)
    expected_args("floor", {x}, {"number"})
    return lua_math.floor(x)
end

--- Returns the remainder of the division of x by y that rounds the quotient towards zero.
---@param x number
---@param y number
---@return number
function math.fmod(x, y)
    expected_args("fmod", {x, y}, {"number", "number"})
    return lua_math.fmod(x, y)
end

--- Find the mantissa and exponent of a number
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

--- returns the sum of the table `seq`
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

--- Find the hypotenuse of a right-angled triangle where perpendicular and base are known
---@param x number
---@param y number
---@return number
function math.hypot(x, y)
    expected_args("hypot", {x, y}, {"number", "number"})
    return lua_math.sqrt(x^2 + y^2)
end

--- returns if `x` is `inf` (infinity)
---@param x number
---@return boolean
function math.isinf(x)
    expected_args("isinf", {x}, {"number"})
    return x == math.inf
end

--- returns if `x` is `nan` (Not a Number)
---@param x number
---@return boolean
function math.isnan(x)
    expected_args("isnan", {x}, {"number"})
    return x == math.nan
end

--- Returns `x * 2 ^ i`
---@param x number
---@param i number
---@return number
function math.ldexp(x, i)
    lua_math.ldexp
    expected_args("ldexp", {x, i}, {"number", "number"})
    return x * 2 ^ i
end

--- Returns the logarithm of `x` in the base `base`
---@param x number
---@param base? integer
---@return number
function math.log(x, base)
    if not base then
        expected_args("log", {x}, {"number"})
        return lua_math.log(x)
    end
    expected_args("log", {x, base}, {"number", "integer"})
    return lua_math.log(x, base)
end


--- returns the sine of `x`
---@param x number
---@return number
function math.sin(x)
    expected_args("sin", {x}, {"number"})
    return lua_math.sin(x)
end

--- returns the sinh of `x`
---@param x number
---@return number
function math.sinh(x)
    expected_args("sinh", {x}, {"number"})
    return (lua_math.exp(x) -(lua_math.exp(-x)))/2
end

--- returns the square root of `x`
---@param x number
---@return number
function math.sqrt(x)
    expected_args("sqrt", {x}, {"number"})
    return lua_math.sqrt(x)
end

--- returns the tangent of `x`
---@param x number
---@return number
function math.tan(x)
    expected_args("tan", {x}, {"number"})
    return lua_math.tan(x)
end

--- returns the tanh of `x`
---@param x number
---@return number
function math.tanh(x)
    expected_args("tanh", {x}, {"number"})
    return (lua_math.exp(2*x) - 1) / (lua_math.exp(2*x + 1))
end

--- returns the absolute value of `x`
---@param x number
---@return number
function math.abs(x)
    expected_args("abs", {x}, {"number"})
    return lua_math.abs(x)
end

return math