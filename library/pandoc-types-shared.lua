---@meta pandoc-types-shared
-- Attr/AttributeList/WithAttr/WithTag, Doc, Reader/Writer options, Template, CommonState, and the small tag-enum aliases used across many element types.
--
-- Part of the split pandoc-types LuaLS annotation set. Files in this set
-- cross-reference each other's types freely -- LuaLS resolves @class/@alias
-- names across ALL files in the same library folder, so file boundaries here
-- are purely organizational and carry no functional meaning.

---@class Attr A Pandoc `Attr` data structure. Runtime values are userdata (`pandoc.utils.type` reports `"Attr"`), not plain Lua tables, but fields are readable/writable as shown below.
---@field attributes AttributeList
---@field classes List<string>
---@field identifier string

---@class AttributeList An association list of attribute key/value pairs, as found in `Attr.attributes`. Runtime values are userdata (`pandoc.utils.type` reports `"AttributeList"`), but keys can be read/written like a normal `table<string,string>`.
---@field [string] string

---@alias CiteMethodType "citeproc"|"natbib"|"biblatex"

---@class CommonState The state used by pandoc to collect information and make it available to readers and writers. Exposed to filters as the global `PANDOC_STATE`. At runtime `pandoc.utils.type` reports this as `"CommonStateInterface"` rather than `"CommonState"`.
---@field input_files? string[] List of input files from command line.
---@field output_file? string|nil Output file from command line.
---@field log? LogMessage[] A list of log messages in reverse order.
---@field request_headers? table Headers to add for HTTP requests; table with header names as keys and header contents as value.
---@field resource_path? string[] Path to search for resources like included images.
---@field source_url? string|nil Absolute URL or directory of first source file.
---@field user_data_dir? string|nil Directory to search for data files.
---@field trace? boolean Whether tracing messages are issued.
---@field verbosity? VerbosityLevelType Verbosity level; one of INFO, WARNING, ERROR.

---@class Doc Reflowable plain-text document. A `Doc` value can be rendered and reflown to fit a given column width. Runtime values are userdata (`pandoc.utils.type` reports `"Doc"`); `tostring(doc)` renders it unreflowed.

---@alias EmailObfuscationType "none"|"references"|"javascript"

---The state of an extension (enabled, disabled, or default state)
---@alias ExtensionState
---| '"enable"'  # extension enabled
---| true        # extension enabled
---| '"disable"' # extension disabled
---| false       # extension disabled
---| nil         # default state

---@alias HtmlMathMethodType "plain"|"gladtex"|"webtex"|"mathml"|"mathjax"

---@class Input The raw input to be parsed by a custom `Reader`, as a list of sources. Use `tostring` to get a string version of the input.

---@class LogMessage A pandoc log message. It has no fields, but can be converted to a string via `tostring`.

---@alias Reader fun(input: Input, options?: ReaderOptions): Pandoc

---@class ReaderOptions Runtime values (from `pandoc.ReaderOptions(...)` or `PANDOC_READER_OPTIONS`) are userdata, not plain tables, but fields are readable as shown below. `PANDOC_READER_OPTIONS` specifically reports `pandoc.utils.type` as `"ReaderOptions (read-only)"` and cannot be `tostring`'d.
---@field abbreviations? string[] Set of known abbreviations.
---@field columns? integer Number of columns in terminal.
---@field default_image_extension? string Default extension for images.
---@field extensions? string[] String representation of the syntax extensions bit field.
---@field indented_code_classes? string[] Default classes for indented code blocks.
---@field standalone? boolean Whether the input was a standalone document with header.
---@field strip_comments? boolean HTML comments are stripped instead of parsed as raw HTML.
---@field tab_stop? integer Width (i.e. equivalent number of spaces) of tab stops.
---@field track_changes? string Track changes setting for docx; one of accept-changes, reject-changes, and all-changes.

---@alias ReferenceLocationType "end-of-block"|"end-of-section"|"end-of-document"|"block"|"section"|"document"

---A document source (local file path or URI)
---@alias Source string

---@class Template An opaque object holding a compiled template.

---@alias TopLevelDivisionType "top-level-part"|"top-level-chapter"|"top-level-section"|"top-level-default"|"part"|"chapter"|"section"|"default"

---@alias VerbosityLevelType "INFO"|"WARNING"|"ERROR"

---@class WithAttr
---@field attr Attr The primary attributes object.
---@field attributes table<string,string> Alias for attr.attributes.
---@field classes List<string> Alias for attr.classes.
---@field identifier string Alias for attr.identifier.

---@class WithTag
---@field t string The elements's tag.
---@field tag string The elements's tag.

---@alias WrapTextType "wrap-auto"|"wrap-none"|"wrap-preserve"|"auto"|"none"|"preserve"

---@alias Writer fun(doc: Pandoc, options: WriterOptions): string

---@class WriterOptions Runtime values (from `pandoc.WriterOptions(...)` or `PANDOC_WRITER_OPTIONS`) are userdata, not plain tables, but fields are readable/writable as shown below.
---@field chunk_template? string Template used to generate chunked HTML filenames.
---@field cite_method? string How to print cites – one of `citeproc`, `natbib`, or `biblatex`.
---@field columns? integer Characters in a line (for text wrapping).
---@field dpi? integer DPI for pixel to/from inch/cm conversions.
---@field email_obfuscation? string How to obfuscate emails – one of `none`, `references`, or `javascript`.
---@field epub_chapter_level? integer Header level for chapters, i.e., how the document is split into separate files.
---@field epub_fonts? string[] Paths to fonts to embed (sequence of strings).
---@field epub_metadata? string|nil Metadata to include in EPUB.
---@field epub_subdirectory? string Subdir for epub in OCF.
---@field extensions? string[] Markdown extensions that can be used.
---@field highlight_style? table|nil Style to use for highlighting; see the output of pandoc `--print-highlight-style=...` for an example structure. The value nil means that no highlighting is used.
---@field html_math_method? HtmlMathMethodType|table How to print math in HTML; one `plain`, `gladtex`, `webtex`, `mathml`, `mathjax`, or a table with keys method and url.
---@field html_q_tags? boolean Use `<q>` tags for quotes in HTML.
---@field identifier_prefix? string Prefix for section & note ids in HTML and for footnote marks in markdown.
---@field incremental? boolean True if lists should be incremental.
---@field listings? boolean Use listings package for code.
---@field number_offset? integer[] Starting number for section, subsection, …
---@field number_sections? boolean Number sections in LaTeX.
---@field prefer_ascii? boolean Prefer ASCII representations of characters when possible.
---@field reference_doc? string Path to reference document if specified.
---@field reference_links? boolean Use reference links in writing markdown, rst.
---@field reference_location? ReferenceLocationType Location of footnotes and references for writing markdown; one of `end-of-block`, `end-of-section`, `end-of-document`. The common prefix may be omitted when setting this value.
---@field section_divs? boolean Put sections in div tags in HTML.
---@field setext_headers? boolean Use setext headers for levels 1-2 in markdown.
---@field slide_level integer Force header level of slides.
---@field tab_stop? integer Tabstop for conversion btw spaces and tabs.
---@field table_of_contents? boolean Include table of contents.
---@field template? Template Template to use.
---@field toc_depth? integer Number of levels to include in TOC.
---@field top_level_division? TopLevelDivisionType Type of top-level divisions; one of `top-level-part`, `top-level-chapter`, `top-level-section`, or `top-level-default`. The prefix `top-level` may be omitted when setting this value.
---@field variables? table Variables to set in template; string-indexed table.
---@field wrap_text? WrapTextType Option for wrapping text; one of `wrap-auto`, `wrap-none`, or `wrap-preserve`. The `wrap-` prefix may be omitted when setting this value.
