# LuaUtils
module with specific sub-modules that aim to expand Lua's standard libraries


# mathpp
expansion of the "math" standard library, contains more mathematical functions, for more information look at the source code

inspired by Python's math standard library

Compatible with all Lua versions

functions overview:

- `acos`
- `acosh`
- `tan`
- `tanh`
- `degress`
- `dist`
- `exp`
... (+31 functions)

# stringpp
expansion of the standard "string" library, containing useful functions such as capitalizing text, transforming into titles, splitting, etc.

Compatible with all Lua versions

functions overview

- `capitalize`
- `title`
- `split`
- `center`
- `left`
- `right`
... (+8 functions)



# tablepp
expansion of the "table" standard library containing many functions, including those already in the table standard library, the difference being that they are compatible with all versions of lua, have functions such as finding the maximum and minimum argument, finding the maximum value and minimum value, print a table on the screen, transform a table into a string, sort, etc.

functions overview
- `max`
- `min`
- `argmax`
- `argmin`
- `list_tostring`
- `sort`
- `foreach`
- `foreachi`
- `filter`
- `filteri`
...(+15 functions)