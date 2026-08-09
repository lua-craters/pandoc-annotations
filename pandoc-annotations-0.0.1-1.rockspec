rockspec_format = "3.0"
package = "pandoc-annotations"
version = "0.0.1"

source = {
    url = "git+https://github.com/lua-craters/pandoc-annotations.git",
    branch = "main"
}

description = {
    summary = "LLS Addon for Pandoc Lua Filters",
    detailed = [[
    The installable successor to massifrg/pandoc-luals-annotations.
    Provides full AST type definitions, globals (pandoc, FORMAT),
    and utility typings for developing Pandoc Lua filters with
    the Lua Language Server.
  ]],
    homepage = "https://github.com/lua-craters/pandoc-annotations",
    license = "MIT",
    maintainer = "Michael Cummings <mgcummings@yahoo.com>"
}

dependencies = {}

build = {
    type = "lls-addon",
    -- This block replaces config.json settings
    settings = {
        runtime = {
            version = "Lua 5.4",
            -- Optional: Disable standard libs to enforce strict Pandoc API usage
            -- builtin = { io = "disable", os = "disable" }
        },
        workspace = {
            checkThirdParty = false
        }
    }
}
