-- init.lua
-- Shared inspection helpers for Pandoc Lua API probes.

local M = {}

local MAX_DEPTH = 8
local MAX_ITEMS = 50

local function safe_pandoc_type(value)
    local ok, result = pcall(pandoc.utils.type, value)
    if ok then
        return tostring(result)
    end
    return "<error>"
end

local function scalar_repr(value)
    local value_type = type(value)

    if value == nil then
        return "nil"
    end
    if value_type == "string" then
        return string.format("%q", value)
    end
    if value_type == "number" or value_type == "boolean" then
        return tostring(value)
    end
    return tostring(value)
end

local function is_container(value)
    local value_type = type(value)
    return value_type == "table" or value_type == "userdata"
end

local function sorted_string_keys(value)
    local keys = {}
    for key in pairs(value) do
        if type(key) == "string" then
            keys[#keys + 1] = key
        end
    end
    table.sort(keys)
    return keys
end

local function sequence_length(value)
    if not is_container(value) then
        return 0
    end

    local length = 0
    for index = 1, MAX_ITEMS do
        if value[index] == nil then
            break
        end
        length = index
    end
    return length
end

local function describe(value)
    return string.format(
        "lua=%s pandoc=%s value=%s",
        type(value),
        safe_pandoc_type(value),
        scalar_repr(value)
    )
end

function M.configure(options)
    options = options or {}
    if options.max_depth ~= nil then
        MAX_DEPTH = options.max_depth
    end
    if options.max_items ~= nil then
        MAX_ITEMS = options.max_items
    end
end

function M.section(title)
    print("")
    print(string.rep("=", 60))
    print(title)
    print(string.rep("=", 60))
end

function M.subsection(title)
    print("")
    print(string.rep("-", 60))
    print(title)
    print(string.rep("-", 60))
end

function M.runtime()
    M.section("Runtime")
    print("Pandoc: " .. tostring(PANDOC_VERSION))
    print("Lua:    " .. _VERSION)
    print("Arch:   " .. tostring(pandoc.system.arch))
    print("OS:     " .. tostring(pandoc.system.os))
end

function M.exists(label, value)
    print(string.format(
        "%s: exists=%s lua_type=%s",
        label,
        tostring(value ~= nil),
        type(value)
    ))
end

function M.value(label, value)
    print(label .. ": " .. describe(value))
end

function M.dump(label, value)
    local seen = {}

    local function visit(path, current, depth)
        local indent = string.rep("  ", depth)
        print(indent .. path .. ": " .. describe(current))

        if depth >= MAX_DEPTH or not is_container(current) then
            return
        end

        if seen[current] then
            print(indent .. "  <already visited>")
            return
        end
        seen[current] = true

        local length = sequence_length(current)
        if length > 0 then
            print(indent .. "  sequence length: " .. tostring(length))
            for index = 1, math.min(length, MAX_ITEMS) do
                visit(
                    string.format("%s[%d]", path, index),
                    current[index],
                    depth + 1
                )
            end
        end

        if type(current) ~= "table" then
            return
        end

        local keys = sorted_string_keys(current)
        if #keys == 0 then
            return
        end

        print(indent .. "  named keys:")
        for index = 1, math.min(#keys, MAX_ITEMS) do
            local key = keys[index]
            visit(path .. "." .. key, current[key], depth + 1)
        end
    end

    visit(label, value, 0)
end

-- Call a function and preserve every return slot, including trailing nils.
--
-- Returns:
--     ok, packed_results_or_error
function M.call(label, fn)
    M.subsection(label)

    local ok, packed_or_error = pcall(function()
        return table.pack(fn())
    end)

    if not ok then
        print("status: ERROR")
        print("error:  " .. tostring(packed_or_error))
        return false, packed_or_error
    end

    print("status:  OK")
    print("returns: " .. tostring(packed_or_error.n))

    for index = 1, packed_or_error.n do
        local value = packed_or_error[index]
        print("")
        print(string.format("[%d]", index))
        M.dump("result", value)
    end

    return true, packed_or_error
end

function M.constructor(name, fn)
    return M.call("constructor: " .. name, fn)
end

function M.method(name, object, fn)
    return M.call("method: " .. name, function()
        return fn(object)
    end)
end

function M.try(label, fn)
    return M.call(label, fn)
end

return M
