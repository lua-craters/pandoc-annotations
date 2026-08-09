---@diagnostic disable: duplicate-doc-field, duplicate-doc-alias
---@meta pandoc-types-document
-- Pandoc (the whole-document class) and Meta/MetaValue and its variants.
--
-- Part of the split pandoc-types LuaLS annotation set. Files in this set
-- cross-reference each other's types freely -- LuaLS resolves @class/@alias
-- names across ALL files in the same library folder, so file boundaries here
-- are purely organizational and carry no functional meaning.

---@class Meta A Pandoc document's metadata table.
---@field [string] MetaValue

---@alias MetaBlocks Blocks

---@alias MetaBool boolean

---@alias MetaInlines Inlines

---@alias MetaList List<MetaValue>

---@alias MetaMap table<string, MetaValue>

---@alias MetaString string

---A number passed in as a Meta value is accepted at construction time but
---is coerced to `string` once stored; `pandoc.utils.type` will report
---`string`, never `number`, for any value read back from a `Meta` table.
---@alias MetaValue boolean | string | Inlines | Blocks | MetaList | MetaMap

---@class Pandoc
---@field blocks Blocks
---@field meta Meta
---@field walk fun(self: Pandoc, filter: Filter): Pandoc Walks the whole document and returns a new, modified `Pandoc` document.
