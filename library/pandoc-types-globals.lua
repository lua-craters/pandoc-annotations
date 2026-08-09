---@meta pandoc-types-globals
-- Filter-environment globals (PANDOC_VERSION, PANDOC_STATE, FORMAT, the Writer entry point, etc).
--
-- Part of the split pandoc-types LuaLS annotation set. Files in this set
-- cross-reference each other's types freely -- LuaLS resolves @class/@alias
-- names across ALL files in the same library folder, so file boundaries here
-- are purely organizational and carry no functional meaning.

--[[
Globals injected by pandoc into the Lua filter/reader/writer environment.
Confirmed against Pandoc 3.10 (Lua 5.4) via runtime inspection:
  PANDOC_VERSION         -> lua=userdata pandoc=Version         (comparable, indexable, #-able)
  PANDOC_API_VERSION     -> lua=userdata pandoc=Version
  PANDOC_SCRIPT_FILE     -> lua=string   pandoc=string
  PANDOC_STATE           -> lua=table    pandoc=CommonStateInterface
  PANDOC_READER_OPTIONS  -> lua=userdata pandoc="ReaderOptions (read-only)"; tostring() errors on it
  PANDOC_WRITER_OPTIONS  -> lua=userdata pandoc=WriterOptions
  FORMAT                 -> lua=string   pandoc=string (only set for writers/custom readers)
]] --
---@type Version
PANDOC_VERSION = nil

---@type Version
PANDOC_API_VERSION = nil

---The path to the currently running script, as given on the command line.
---@type string
PANDOC_SCRIPT_FILE = nil

---@type CommonState
PANDOC_STATE = nil

---A read-only copy of the reader options that were used to parse the input. `nil` for custom writers with no input document.
---@type ReaderOptions|nil
PANDOC_READER_OPTIONS = nil

---The options that will be used for writing the current document. Only set for writers and custom readers/writers.
---@type WriterOptions|nil
PANDOC_WRITER_OPTIONS = nil

---The name of the output format. Only set for writers and custom readers/writers.
---@type string|nil
FORMAT = nil

---The `pandoc` module itself, injected as a global into every filter/reader/writer environment. NOTE: this declaration was missing entirely from earlier drafts of this file -- only the `pandoc` CLASS (the shape of the table) was defined, with no matching global-variable declaration, so LuaLS would have reported `pandoc.Str(...)` etc. as an undefined global in real filter code despite every field on it being fully typed. Fixed here the same way `PANDOC_VERSION` and friends are declared below.
---@type pandoc
pandoc = nil

---Pandoc's embedded Lua interpreter bundles LPeg and its `re` regex-like front end as real globals, confirmed by testing (`lpeg`/`re`/`require("lpeg")`/`require("re")` all resolve against Pandoc 3.10). Neither is given full type annotations here -- if you need those, depend on a dedicated LPeg LuaCATS addon/rock rather than duplicating that work in this file -- but they're declared as `table` so LuaLS at least recognizes them as valid globals instead of flagging them undefined.
---@type table
lpeg = nil

---@type table
re = nil

---Custom writers must define this global as either a function `(doc: Pandoc, opts: WriterOptions) -> string` or (in Pandoc >= 2.17) by assigning `pandoc.scaffolding.Writer` to it, which handles most of the boilerplate and only requires render functions per AST element type to be filled in. Confirmed via testing: inside the `Writer` function, `doc` is a `Pandoc` userdata and `opts` is a `WriterOptions` userdata. NOTE: the legacy globals `PANDOC_DOCUMENT` and `Extensions` from older custom-writer examples were NOT present when tested against Pandoc 3.10 — do not rely on them.
---@type (fun(doc: Pandoc, opts: WriterOptions): string)|table|nil
Writer = nil
