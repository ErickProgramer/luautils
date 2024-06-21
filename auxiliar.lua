local math = require("math")
local aux = {}

local type = type

--- expands the `type` function
--- if the type of `x` is a number, it returns float or integer,
--- else return: `type(x)`
---@param x any
---@return string
function aux.type_pp(x)
    if type(x) ~= "number" then
        return type(x)
    end
    local _, d = math.modf(x)
    return d == 0 and "integer" or "float"
end

--- checks if the `parameter` is of type `parameter_expected`
--- if it is not, it displays an error message on the screen with all the necessary information
--- if `parameter_expected` is `"number"` this means that `parameter` can be float or integer
---@param func_name string
---@param parameter any
---@param parameter_expected string
---@param argument integer
function aux.expected_arg(func_name, parameter, parameter_expected, argument)
    if parameter_expected == "float" or parameter_expected == "integer" then
        assert(math.type(parameter) == parameter_expected, string.format("bad argument #%d to '%s' (%s expected, got %s)", argument, func_name, parameter_expected, aux.type_pp(parameter)))
    else
        assert(type(parameter) == parameter_expected, string.format("bad argument #%d to '%s' (%s expected, got %s)", argument, func_name, parameter_expected, type(parameter)))
    end
end

--- works like `expected_arg`, but allowing you to check more than one parameter at once
---@param func_name string
---@param parameters table
---@param parameters_expected table
function aux.expected_args(func_name, parameters, parameters_expected)
    for i = 1, #parameters do
        aux.expected_arg(func_name, parameters[i], parameters_expected[i], i)
    end
end

return aux