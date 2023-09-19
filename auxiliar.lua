local aux = {}

function aux.type_pp(x)
    if math.type(x) ~= "nil" then return math.type(x) else return type(x) end
end

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

---@param func_name string
---@param parameters table
---@param parameters_expected table
function aux.expected_args(func_name, parameters, parameters_expected)
    for i = 1, #parameters do
        aux.expected_arg(func_name, parameters[i], parameters_expected[i], i)
    end
end

return aux