-- inspect-returns.lua
local inspect = require("tools.inspect")

inspect.runtime()
inspect.section("Multiple-return smoke tests")

inspect.call("two values", function()
    return "value", 42
end)

inspect.call("nil in the middle", function()
    return "first", nil, "third"
end)

inspect.call("trailing nil", function()
    return "first", nil
end)

inspect.call("all nil", function()
    return nil, nil, nil
end)

inspect.call("no values", function()
    return
end)
