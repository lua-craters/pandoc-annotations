---@diagnostic disable: duplicate-doc-field, duplicate-doc-alias
---@meta pandoc-types-module-misc
-- The smaller pandoc submodules, grouped together since each is only a handful of lines on its own: `pandoc.text`, `.template`, `.format`, `.cli`, `.json`, `.log`, `.types` (+ Version), `.scaffolding`.
--
-- Part of the split pandoc-types LuaLS annotation set. Files in this set
-- cross-reference each other's types freely -- LuaLS resolves @class/@alias
-- names across ALL files in the same library folder, so file boundaries here
-- are purely organizational and carry no functional meaning.

---UTF-8 aware text manipulation functions, implemented in Haskell.
---@class PandocTextModule
---@field fromencoding fun(s: string, encoding?: string): string Converts a string to UTF-8.
---@field len fun(s: string): integer Returns the length of a UTF-8 string, i.e., the number of characters.
---@field lower fun(s: string): string Returns a copy of a UTF-8 string, converted to lowercase.
---@field reverse fun(s: string): string Returns a copy of a UTF-8 string, with characters reversed.
---@field sub fun(s: string, i: integer, j?: integer): string Returns a substring of a UTF-8 string, using Lua’s string indexing rules.
---@field toencoding fun(s: string, encoding?: string): string Converts a UTF-8 string to a different encoding. The `encoding` parameter defaults to the current ANSI code page on Windows; on other platforms it will try to guess the file system’s encoding.
---@field upper fun(s: string): string Returns a copy of a UTF-8 string, converted to uppercase.

---Handle pandoc templates.
---@class PandocTemplateModule
---@field apply fun(template: Template, context: table): Doc Applies a context with variable assignments to a template, returning the rendered template. The context parameter must be a table with variable names as keys and `Doc`, `string`, `boolean`, or `table` as values, where the table can be either be a list of the aforementioned types, or a nested context.
---@field compile fun(template: string, templates_path?: string[]): Template Compiles a template string into a Template object usable by pandoc. If the `templates_path` parameter is specified, should be the file path associated with the template. It is used when checking for partials. Partials will be taken only from the default data files if this parameter is omitted.
---@field default fun(writer?: string): string Returns the default template for a given writer as a string. An error if no such template can be found. `writer` defaults to the global `FORMAT`.
---@field get fun(filename: string): string Retrieve text for a template. This function first checks the resource paths for a file of this name; if none is found, the templates directory in the user data directory is checked. Returns the content of the file, or throws an error if no file is found.
---@field meta_to_context fun(meta: Meta, blocks_writer: BlocksWriter, inlines_writer: InlinesWriter) Creates template context from the document’s Meta data, using the given functions to convert `Blocks` and `Inlines` to `Doc` values.

---Information about the formats supported by pandoc.
---@class PandocFormatModule
---@field all_extensions fun(format: string): string[] Returns the list of all valid extensions for a format. No distinction is made between input and output; an extension can have an effect when reading a format but not when writing it, or _vice versa_.
---@field default_extensions fun(format: string): string[] Returns the list of default extensions of the given format; this function does not check if the format is supported, it will return a fallback list of extensions even for unknown formats.
---@field extensions fun(format: string): table<string,ExtensionState> Returns the extension configuration for the given format. The configuration is represented as a table with all supported extensions as keys and their default status as value, with `true` indicating that the extension is enabled by default, while `false` marks a supported extension that’s disabled.
---@field from_path fun(path: string|string[]): string|nil Try to determine the format of file(s) by heuristic.

---Command line options and argument parsing.
---@class PandocCliModule
---@field default_options table<string,any> Default CLI options, using a JSON-like representation.
---@field parse_options fun(args: string[]): table<string,string> Parses command line arguments into pandoc options. Typically this function will be used in stand-alone pandoc Lua scripts, taking the list of arguments from the global `arg`.
---@field repl fun(env: table<string,string>): any Starts a read-eval-print loop (REPL). The function returns all values of the last evaluated input.

---JSON module to work with JSON; based on the Aeson Haskell package.
---@class PandocJsonModule
---@field decode fun(str: string, pandoc_types?: boolean): any Creates a Lua object from a JSON string. The function returns an `Inline`, `Block`, `Pandoc`, `Inlines`, or `Blocks` element if the input can be decoded into represent any of those types. Otherwise the default decoding is applied, using tables, booleans, numbers, and `null` to represent the JSON value.
---@field encode fun(object: any): string Encodes a Lua object as JSON string.
---@field null userdata Userdata representing a JSON `null`.

---@class PandocLogModule
---@field info fun(message: string) Reports a ScriptingInfo message to pandoc’s logging system.
---@field silence fun(fn: function): List<string> Applies the function to the given arguments while preventing log messages from being added to the log.
---@field warn fun(message: string) Reports a ScriptingWarning to pandoc’s logging system. The warning will be printed to stderr unless logging verbosity has been set to ERROR.

---Constructors for types which are not part of the pandoc AST.
---@class PandocTypesModule
---@field Version fun(v: string|integer[]|integer): Version Creates a Version object.

---A version specifier such as `PANDOC_VERSION` or `PANDOC_API_VERSION`. Runtime values are userdata (`pandoc.utils.type` reports `"Version"`), not a plain integer array, but they support `#`, integer indexing (`v[1]`, `v[2]`, ...), `tostring`, and the comparison operators `==`, `<`, `<=`, `>`, `>=` against another `Version` or a plain integer array (e.g. `PANDOC_VERSION > {2,17}`). NOTE: LuaLS's `@operator` annotation only supports arithmetic/bitwise/concat/`len`/`call` metamethods, not the relational ones (`lt`/`le`/`eq`) — those comparisons work at runtime but can't be declared here, so LuaLS won't type-check them.
---@class Version
---@operator len: integer
---@field [integer] integer

---Scaffolding for custom writers.
---@class PandocScaffoldingModule
---@field Writer table An object to be used as a `Writer` function; the construct handles most of the boilerplate, expecting only render functions for all AST elements.
