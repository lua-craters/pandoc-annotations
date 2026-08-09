---@diagnostic disable: duplicate-doc-field, duplicate-doc-alias
---@meta pandoc-types-inlines
-- Inline and every Inline subtype.
--
-- Part of the split pandoc-types LuaLS annotation set. Files in this set
-- cross-reference each other's types freely -- LuaLS resolves @class/@alias
-- names across ALL files in the same library folder, so file boundaries here
-- are purely organizational and carry no functional meaning.

---@class Citation A Pandoc `Citation`. Runtime values are userdata (`pandoc.utils.type` reports `"Citation"`).
---@field id string
---@field mode CitationMode
---@field prefix Inlines
---@field suffix Inlines
---@field note_num integer
---@field hash integer

---@alias CitationMode "AuthorInText"|"SuppressAuthor"|"NormalCitation"

---@class Cite: Inline A Pandoc `Cite`.
---@field content Inlines
---@field citations List<Citation>

---@class Code: Inline,WithAttr A Pandoc `Code`.
---@field text string

---@class Emph: Inline A Pandoc `Emph`.
---@field content Inlines

---@class Image: Inline,WithAttr A Pandoc `Image`.
---@field caption Inlines|Inline[]
---@field src string
---@field title string

---@class Inline: WithTag A Pandoc `Inline`.
---@field content List The content of the Inline.
---@field walk fun(self: self, filter: Filter): self Walks the element and returns a new, modified element, preserving its concrete tag (e.g. walking a `Str` returns a `Str`).

---@alias InlineFilterResult nil|Inline|Inlines|EmptyList|List<Inlines>

---@alias InlineList Inlines

---@alias InlineWithAttr Span|Code|Link|Image

---@class LineBreak: Inline A Pandoc `LineBreak`.

---@class Link: Inline,WithAttr A Pandoc `Link`.
---@field content Inlines|Inline[]
---@field target string
---@field title string

---@class Math: Inline A Pandoc `Math`.
---@field mathtype MathType
---@field text string

---@alias MathType "DisplayMath"|"InlineMath"

---@class Note: Inline A Pandoc `Note`.
---@field content Blocks

---@class Quoted: Inline A Pandoc `Quoted`.
---@field quotetype QuoteType
---@field content Inlines

---@alias QuoteType "SingleQuote"|"DoubleQuote"

---@class RawInline: Inline A Pandoc `RawInline`.
---@field format string
---@field text string

---@class SmallCaps: Inline A Pandoc `SmallCaps`.
---@field content Inlines

---@class SoftBreak: Inline A Pandoc `SoftBreak`.

---@class Space: Inline A Pandoc `Space`.

---@class Span: Inline,WithAttr A Pandoc `Span`.
---@field content Inlines|Inline[]

---@class Str: Inline A Pandoc `Str`.
---@field text string

---@class Strikeout: Inline A Pandoc `Strikeout`.
---@field content Inlines

---@class Strong: Inline A Pandoc `Strong`.
---@field content Inlines

---@class Subscript: Inline A Pandoc `Subscript`.
---@field content Inlines

---@class Superscript: Inline A Pandoc `Superscript`.
---@field content Inlines

---@class Underline: Inline A Pandoc `Underline`.
---@field content Inlines
