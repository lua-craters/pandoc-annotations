---@meta pandoc-types-module-structure
-- The `pandoc.structure` module (heading/section/chunking helpers) and its option and result types.
--
-- Part of the split pandoc-types LuaLS annotation set. Files in this set
-- cross-reference each other's types freely -- LuaLS resolves @class/@alias
-- names across ALL files in the same library folder, so file boundaries here
-- are purely organizational and carry no functional meaning.

---Access to the higher-level document structure, including hierarchical sections and the table of contents.
---@class PandocStructureModule
---@field make_sections fun(blocks: Blocks, opts?: MakeSectionsOptions): Blocks Puts `Blocks` into a hierarchical structure: a list of sections (each a `Div` with class "section" and first element a `Header`).
---@field slide_level fun(blocks: Blocks|Pandoc): integer Find level of header that starts slides (defined as the least header level that occurs before a non-header/non-hrule in the blocks).
---@field split_into_chunks fun(doc: Pandoc, opts?: SplitIntoChunksOptions): ChunkedDoc Converts a `Pandoc` document into a `ChunkedDoc`.
---@field table_of_contents fun(toc_source: Blocks|Pandoc|ChunkedDoc, opts?: WriterOptions): BulletList Generates a table of contents for the given object.

---@class Chunk
---@field contents Block[] The chunk’s block contents.
---@field heading Inline[] Heading text.
---@field id string Identifier.
---@field level integer Level of topmost heading in chunk.
---@field next Chunk|nil Link to the next section, if any.
---@field number integer Chunk number.
---@field path string Target filepath for this chunk.
---@field prev Chunk|nil Link to the previous section, if any.
---@field section_number string Hierarchical section number.
---@field unlisted boolean Whether the section in this chunk should be listed in the TOC even if the chunk has no section number.
---@field up Chunk|nil Link to the enclosing section, if any.

---@class ChunkedDoc
---@field chunks Chunk[] List of chunks that make up the document.
---@field meta Meta The document’s metadata.
---@field toc table Table of contents information.

---Options for the second argument of `pandoc.structure.make_sections`.
---@class MakeSectionsOptions: table
---@field number_sections? boolean When `true`, a number attribute containing the section number will be added to each `Header`.
---@field base_level? integer When set, `Header` levels will be reorganized so that there are no gaps, with numbering levels shifted by the given value.
---@field slide_level? integer When set, triggers the creation of slides at that heading level.

---Options for the second argument of `pandoc.structure.split_into_chunks`.
---@class SplitIntoChunksOptions: table
---@field path_template? string Template used to generate the chunks' filepaths. `%n` will be replaced with the chunk number (padded with leading 0s to 3 digits), `%s` with the section number of the heading, `%h` with the (stringified) heading text, `%i` with the section identifier. For example, `"section-%s-%i.html"` might be resolved to `"section-1.2-introduction.html"`. Default is `"chunk-%n"`.
---@field number_sections? boolean Whether sections should be numbered; default is `false`.
---@field chunk_level? integer The heading level the document should be split into chunks. The default is to split at the top-level, i.e., `1`.
---@field base_heading_level? integer|nil The base level to be used for numbering. Default is `nil`
