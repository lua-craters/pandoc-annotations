---@meta pandoc-types-blocks
-- Block and every Block subtype, including the full Table family (Row, Cell, TableHead, TableBody, TableFoot, Caption, ColSpec).
--
-- Part of the split pandoc-types LuaLS annotation set. Files in this set
-- cross-reference each other's types freely -- LuaLS resolves @class/@alias
-- names across ALL files in the same library folder, so file boundaries here
-- are purely organizational and carry no functional meaning.

---@alias Alignment "AlignLeft"|"AlignRight"|"AlignCenter"|"AlignDefault"

---@class Block: WithTag A Pandoc `Block`.
---@field content List The content of the Block.
---@field walk fun(self: self, filter: Filter): self Walks the element and returns a new, modified element. The original concrete tag is preserved (e.g. walking a `Para` returns a `Para`); the `self` return type lets LuaLS track this through the call.

---@alias BlockFilterResult nil|Block|Blocks|EmptyList|List<Blocks>

---@alias BlockList Blocks

---@class BlockQuote: Block A Pandoc `BlockQuote`
---@field content Blocks

---@alias BlockWithAttr Header|Div|Figure|Table|CodeBlock

---@class BulletList: Block A Pandoc `BulletList`
---@field content List<Blocks>

---@class Caption A Pandoc `Table` or `Figure` caption
---@field long Blocks|nil
---@field short Inlines|nil

---@class Cell: WithAttr A Pandoc `Table` cell
---@field alignment Alignment
---@field contents Blocks
---@field col_span integer
---@field row_span integer

---@class CodeBlock: Block,WithAttr A Pandoc `CodeBlock`
---@field text string

---A pair of cell alignment and relative column width (`nil`/`ColWidthDefault` if the column width is not set). Represented at runtime as a plain two-element Lua table (`{alignment, width}`), not a `List`.
---@alias ColSpec [Alignment, number|nil]

---@class DefinitionList: Block A Pandoc `DefinitionList`
---@field content List<DefinitionListItem>

---@class DefinitionListItem
---@field term Inlines
---@field data List<Blocks>

---@class Div: Block,WithAttr A Pandoc `Div`.
---@field content Blocks

---@class Figure: Block,WithAttr A Pandoc `Figure`.
---@field content Blocks
---@field caption Caption

---@class Header: Block,WithAttr A Pandoc `Header`
---@field level integer
---@field content Inlines

---@class HorizontalRule: Block A Pandoc `HorizontalRule`.

---@class LineBlock: Block A Pandoc `LineBlock`
---@field content List<Inlines>

---@class ListAttributes
---@field start integer Number of the first list item.
---@field style ListNumberStyle Style of list numbers.
---@field delimiter ListNumberDelim Delimiter of list numbers.

---@alias ListNumberDelim "DefaultDelim"|"Period"|"OneParen"|"TwoParens"

---@alias ListNumberStyle "DefaultStyle"|"Example"|"Decimal"|"LowerRoman"|"UpperRoman"|"LowerAlpha"|"UpperAlpha"

---@class OrderedList: Block,ListAttributes A Pandoc `OrderedList`
---@field content List<Blocks>
---@field listAttributes ListAttributes|nil
---@field start integer
---@field style string
---@field delimiter string

---@class Para: Block A Pandoc `Para`.
---@field content Inlines

---@class Plain: Block A Pandoc `Plain`.
---@field content Inlines

---@class RawBlock: Block A Pandoc `RawBlock`
---@field format string
---@field text string

---@class Row: WithAttr A Pandoc `Table` row
---@field cells List<Cell>

---@alias SimpleCell Blocks

---@class SimpleTable: Block,WithAttr A Pandoc `SimpleTable` (tables in pre pandoc 2.10)
---@field caption Caption Table caption.
---@field aligns List<Alignment> Alignments of every column.
---@field widths number[] Column widths.
---@field headers List<SimpleCell> Table header row.
---@field rows List<List<SimpleCell>> Table body.

---@class Table: Block,WithAttr A Pandoc `Table`. Note: `pandoc.utils.type` reports this (like all Blocks) as `"Block"`; use `.t`/`.tag` (`"Table"`) to check the specific tag.
---@field caption Caption
---@field colspecs List<ColSpec>
---@field head TableHead
---@field bodies List<TableBody>
---@field foot TableFoot

---@class TableBody: WithAttr A Pandoc `Table` body
---@field body List<Row> table body rows.
---@field head List<Row> intermediate head.
---@field row_head_columns integer number of columns taken up by the row head of each row.

---@class TableFoot: WithAttr A Pandoc `Table` foot
---@field rows List<Row>

---@class TableHead: WithAttr A Pandoc `Table` head
---@field rows List<Row>
