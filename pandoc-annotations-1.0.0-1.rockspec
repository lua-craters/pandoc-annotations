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

dependencies = {
  "lua >= 5.4"  -- Pandoc 3.0+ requires Lua 5.4
}

build = {
  type = "lls-addon",
  -- This block replaces config.json settings
  settings = {
    Lua = {
      runtime = {
        version = "Lua 5.4",
        -- Optional: Disable standard libs to enforce strict Pandoc API usage
        -- builtin = { io = "disable", os = "disable" }
      },
      diagnostics = {
        -- Automatically defines globals so no "undefined global" errors
        globals = {
          "pandoc",
          "FORMAT",
          "PANDOC_VERSION",
          "PANDOC_API_VERSION",
          "PANDOC_SCRIPT_FILE",
          "PANDOC_STATE",
          "PANDOC_READER_OPTIONS",
          "PANDOC_WRITER_OPTIONS",
          "lpeg",
          "re"
        }
      },
      workspace = {
        -- Ensures the library folder is indexed by LLS
        library = {"${3rd}/pandoc-annotations/library"}
      }
    }
  }
}
