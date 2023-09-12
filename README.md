# LuaUtils
    module with specific sub-modules that aim to expand Lua's standard libraries


## mathpp
    expansion of the standard "math" lib, contains many more math functions

### examples
```lua
local mathpp = require("mathpp")
mathpp.cos(10) -- -0.83907152907645
mathpp.cosh(10) -- 11013.232920103
mathpp.acos(10) -- nan
mathpp.acosh(10) -- 2.9932228461264
mathpp.tan(10) -- 0.64836082745909

mathpp.copysign(x, y) -- copy the sign from y to x

```

