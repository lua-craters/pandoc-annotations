---@meta pandoc-types-list-filter
-- List<T> and its Blocks/Inlines subclasses, iterator/predicate/comparator/map-function aliases, and the Filter class.
--
-- Part of the split pandoc-types LuaLS annotation set. Files in this set
-- cross-reference each other's types freely -- LuaLS resolves @class/@alias
-- names across ALL files in the same library folder, so file boundaries here
-- are purely organizational and carry no functional meaning.

---@class Blocks: List<Block>
---@field walk fun(self: self, filter: Filter): self Walks each element and returns a new `Blocks` list. NOTE: `pandoc.utils.type` confirms `filter`/`walk` results stay `Blocks`, but generic `List` methods like `:map` degrade the result to a plain `List<Block>` (see `List` class).

---@alias BlocksWriter fun(blocks: Blocks): Doc

---@alias Comparator<T> fun(a: T, b: T): boolean

---@class EmptyList An empty List.

---A table of functions used to filter/transform the Pandoc AST while it is being traversed (via `doc:walk(filter)`, or the top-level filter table returned from a `--lua-filter` script). Each field is a handler for one AST element type.
---
---Return value conventions:
---  - Returning `nil` (or nothing) leaves the element untouched.
---  - Returning a replacement element/list replaces it. Returning `EmptyList` (or `{}`) deletes it.
---  - For elements that can contain other elements, the handler may return a SECOND value: `false`. Confirmed via testing: returning `(newElement, false)` stops the traversal from descending into the returned element's children — any handlers for element types nested inside it will NOT be called for that subtree. This is useful for e.g. protecting the contents of a `Div`/`Span` marked with a specific class from further processing.
---@class Filter
---@field Blocks? fun(blocks: Blocks): BlockFilterResult,boolean? `nil` = leave untouched, `EmptyList` = delete.
---@field BlockQuote? fun(blockquote: BlockQuote): BlockFilterResult,boolean? `nil` = leave untouched, `EmptyList` = delete. Confirmed callable via testing; was missing from earlier versions of this file.
---@field BulletList? fun(bulletlist: BulletList): BlockFilterResult,boolean? `nil` = leave untouched, `EmptyList` = delete.
---@field Cite? fun(cite: Cite): InlineFilterResult,boolean? `nil` = leave untouched, `EmptyList` = delete.
---@field Code? fun(code: Code): InlineFilterResult `nil` = leave untouched, `EmptyList` = delete.
---@field CodeBlock? fun(codeblock: CodeBlock): BlockFilterResult `nil` = leave untouched, `EmptyList` = delete.
---@field DefinitionList? fun(definitionlist: DefinitionList): BlockFilterResult,boolean? `nil` = leave untouched, `EmptyList` = delete.
---@field Div? fun(div: Div): BlockFilterResult,boolean? `nil` = leave untouched, `EmptyList` = delete.
---@field Emph? fun(emph: Emph): InlineFilterResult,boolean? `nil` = leave untouched, `EmptyList` = delete.
---@field Figure? fun(figure: Figure): BlockFilterResult,boolean? `nil` = leave untouched, `EmptyList` = delete.
---@field Header? fun(header: Header): BlockFilterResult,boolean? `nil` = leave untouched, `EmptyList` = delete. `nil` = leave untouched, `EmptyList` = delete.
---@field HorizontalRule? fun(): BlockFilterResult `nil` = leave untouched, `EmptyList` = delete.
---@field Image? fun(image: Image): InlineFilterResult,boolean? `nil` = leave untouched, `EmptyList` = delete.
---@field Inlines? fun(inlines: Inlines): BlockFilterResult,boolean? `nil` = leave untouched, `EmptyList` = delete.
---@field LineBlock? fun(lineblock: LineBlock): BlockFilterResult,boolean? `nil` = leave untouched, `EmptyList` = delete.
---@field LineBreak? fun(): InlineFilterResult `nil` = leave untouched, `EmptyList` = delete.
---@field Link? fun(link: Link): InlineFilterResult,boolean? `nil` = leave untouched, `EmptyList` = delete.
---@field Math? fun(math: Math): InlineFilterResult `nil` = leave untouched, `EmptyList` = delete.
---@field Meta? fun(meta: Meta): Meta|nil A dedicated `Meta`-only handler, distinct from the `meta` argument of the `Pandoc` handler below. Confirmed callable via testing; runs before the document body is traversed. `nil` = leave untouched.
---@field Note? fun(note: Note): InlineFilterResult,boolean? `nil` = leave untouched, `EmptyList` = delete.
---@field OrderedList? fun(orderedlist: OrderedList): BlockFilterResult,boolean? `nil` = leave untouched, `EmptyList` = delete.
---@field Pandoc? fun(doc: Pandoc, meta?: Meta): Pandoc|nil `nil` = leave untouched.
---@field Para? fun(para: Para): BlockFilterResult,boolean? `nil` = leave untouched, `EmptyList` = delete.
---@field Plain? fun(plain: Plain): BlockFilterResult,boolean? `nil` = leave untouched, `EmptyList` = delete.
---@field Quoted? fun(quoted: Quoted): InlineFilterResult,boolean? `nil` = leave untouched, `EmptyList` = delete.
---@field RawBlock? fun(rawblock: RawBlock): BlockFilterResult `nil` = leave untouched, `EmptyList` = delete.
---@field RawInline? fun(rawinline: RawInline): InlineFilterResult `nil` = leave untouched, `EmptyList` = delete.
---@field SmallCaps? fun(smallcaps: SmallCaps): InlineFilterResult,boolean? `nil` = leave untouched, `EmptyList` = delete.
---@field SoftBreak? fun(): InlineFilterResult `nil` = leave untouched, `EmptyList` = delete.
---@field Space? fun(): InlineFilterResult `nil` = leave untouched, `EmptyList` = delete.
---@field Span? fun(span: Span): InlineFilterResult,boolean? `nil` = leave untouched, `EmptyList` = delete.
---@field Str? fun(str: Str): InlineFilterResult `nil` = leave untouched, `EmptyList` = delete.
---@field Strikeout? fun(strikeout: Strikeout): InlineFilterResult,boolean? `nil` = leave untouched, `EmptyList` = delete.
---@field Strong? fun(strong: Strong): InlineFilterResult,boolean? `nil` = leave untouched, `EmptyList` = delete.
---@field Subscript? fun(subscript: Subscript): InlineFilterResult,boolean? `nil` = leave untouched, `EmptyList` = delete.
---@field Superscript? fun(superscript: Superscript): InlineFilterResult,boolean? `nil` = leave untouched, `EmptyList` = delete.
---@field Table? fun(table: Table): BlockFilterResult,boolean? `nil` = leave untouched, `EmptyList` = delete.
---@field traverse? "topdown"|"typewise" Traversal order of this filter (default: `typewise`).
---@field Underline? fun(underline: Underline): InlineFilterResult,boolean? `nil` = leave untouched, `EmptyList` = delete.

---@class Inlines: List<Inline>
---@field walk fun(self: self, filter: Filter): self Walks each element and returns a new `Inlines` list.

---@alias InlinesWriter fun(inlines: Inlines): Doc

---@alias IteratorFunction fun(state: IteratorState, value: IteratorValue)

---@class IteratorState An opaque value to be passed to the iterator function.

---@class IteratorValue Current value of an iterator.

---@class List<T>: {[integer]: T} A Pandoc List.
---@field at fun(self: List<`T`>, index: integer, default?: `T`): `T`
---@field clone fun(self: List<`T`>): List<`T`>
---@field extend fun(self: List<`T`>, list: List<`T`>)
---@field filter fun(self: List<`T`>, predicate: Predicate<`T`>): List<`T`>
---@field find fun(self: List<`T`>, needle: `T`, init?: integer): `T`|nil,integer|nil
---@field find_if fun(self: List<`T`>, predicate: Predicate<`T`>, init?: integer): `T`|nil,integer|nil
---@field includes fun(self: List<`T`>, needle: `T`, init?: integer): boolean
---@field insert fun(self: List<`T`>, pos: integer, value: `T`)
---@field insert fun(self: List<`T`>, value: `T`)
---@field iter fun(self: List<`T`>, step?: integer): IteratorFunction
---@field map fun(self: List<`T`>, f: MapFunction<`T`,`U`>): List<`U`>
---@field new fun(self: List<`T`>, t?: table<`T`>):List<`T`>
---@field remove fun(self: List<`T`>, pos?: integer)
---@field sort fun(self: List<`T`>, comparator: Comparator<`T`>)

---@alias MapFunction<T,U> fun(t: T): U

---@alias Predicate<T> fun(t: T): boolean
