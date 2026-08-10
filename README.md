# Pandoc Annotations

> **The installable Lua Language Server (LLS) addon for Pandoc Lua filters.**
> *Successor to [massifrg/pandoc-luals-annotations](https://github.com/massifrg/pandoc-luals-annotations)*

Provides complete type definitions, AST structures, and global environment setup
for developing
[Pandoc](https://pandoc.org)
Lua filters with intelligent autocomplete and strict type checking.

## ✨ Why Use This?

Unlike the original project, which requires manually copying files and hand-editing
`.luarc.json`, **Pandoc Annotations** can be installed as a true **LuaRocks addon**:

- 🚀 **One-Command Install**: `luarocks install pandoc-annotations`
- 🌍 **Full Global Environment**: Ships proper typed declarations for `pandoc`,
  `FORMAT`, every `PANDOC_*` global, and `lpeg`/`re` — not just diagnostic
  suppressions, so you get real autocomplete on `pandoc.*`, not just silence on
  "undefined global."
- 🔄 **Easy Updates**: Keep types up to date with `luarocks upgrade`
- 🩹 **Verified, not guessed**: Constructor signatures, return shapes, and several
  behaviors the official manual doesn't document were confirmed by running Pandoc
  itself, not just read off the docs — see [Verification](#-verification) below.

## 📦 Installation

### Method 1: LuaRocks (Recommended)

Requires [LuaRocks](https://luarocks.org). No special flags or wrapper commands
needed — confirmed end-to-end against a real install:

```bash
luarocks install pandoc-annotations
```

If you're testing against a not-yet-published rockspec instead of the published
name, the equivalent is:

```bash
luarocks build pandoc-annotations-1.0.0-1.rockspec
```

This automatically pulls in its build dependency (`luarocks-build-lls-addon`, which
in turn pulls in `luarocks-loader`) the first time, runs the `lls-addon` build
backend, and merges its settings into a `.luarc.json`. Two things worth knowing
before you run it, both confirmed against real installs rather than assumed:

**1. Run it from inside a recognized LuaRocks project, or the `.luarc.json` won't
land where you want it.** LuaRocks only writes to your actual project when it can
detect one — specifically, it walks up from your current directory looking for a
folder containing *both* `.luarocks/` and `lua_modules/`. If it can't find that
pairing, the settings get written into a temporary build directory instead, which
gets deleted afterward and does you no good. The simplest fix, run once per project:
```bash
cd /path/to/your/pandoc-filter-project
luarocks init
luarocks install pandoc-annotations
```
(A bare `mkdir lua_modules` next to an existing `.luarocks/` folder is technically
enough to satisfy the detection check too, since it's just an existence check — but
`luarocks init` sets up the project tree properly and is the supported way to do it.)

**2. Don't mix `sudo` and non-`sudo`/`--local` runs for the same project.** They
install into, and write config for, two completely separate trees (`/usr/local/...`
vs. a project-local `lua_modules/...`). Switching between them mid-project can leave
a `.luarc.json` owned by `root` that a later non-`sudo` run then fails to write to
with a permission error. Pick one approach per project and stick with it — for a
personal/project-local addon like this, plain `luarocks --local install
pandoc-annotations` (no `sudo` at all) is the simplest choice.

Once installed, restart your editor. Here's an actual generated `.luarc.json` from a
real, confirmed install (note the `0.0.1-1` version in this example reflects the
rockspec version in use during testing — yours will show whatever version you
actually installed):
```json
{
  "runtime": {
    "version": "Lua 5.4"
  },
  "workspace": {
    "checkThirdParty": false,
    "library": ["lua_modules/lib/luarocks/rocks-5.4/pandoc-annotations/0.0.1-1/library"]
  }
}
```
If yours didn't get generated automatically, add the equivalent `workspace.library`
entry yourself, pointing at wherever `library/` ended up under your rocks tree.

### Method 2: Manual (Legacy Support)

For environments where LuaRocks is unavailable, or if you'd rather not depend on it:

1. Clone this repository:
   ```bash
   git clone https://github.com/lua-craters/pandoc-annotations.git
   ```

2. Point LuaLS at the `library/` folder directly. In your project's `.luarc.json`:
   ```json
   {
     "workspace.library": ["/absolute/path/to/pandoc-annotations/library"]
   }
   ```
   (Relative paths are resolved from wherever `.luarc.json` lives, so a relative
   path works too if the clone sits alongside your project.)

   Alternatively, if you'd rather use the Addon Manager's `userThirdParty`
   mechanism instead of a direct `workspace.library` entry, point it at the
   **parent** directory containing this clone (not the clone itself) — see the
   [Addons wiki page](https://luals.github.io/wiki/addons/) for that layout.

3. Reload your editor window.

## 🛠️ Features

* **Complete AST Typing**: Full definitions for every Block and Inline subtype
  (`pandoc.Div`, `pandoc.Str`, `pandoc.Para`, the full `Table`/`Row`/`Cell` family,
  and more), plus `Meta`/`MetaValue`, `Attr`, `List`, and `Filter`.
* **Utility Functions**: Typed helpers across `pandoc.utils`, `pandoc.mediabag`,
  `pandoc.path`, `pandoc.layout`, `pandoc.system`, `pandoc.text`, `pandoc.structure`,
  `pandoc.template`, and more — the whole `pandoc.*` module surface, not just the
  AST constructors.
* **Global Environment**: Proper typed declarations (not diagnostic suppressions)
  for every global Pandoc injects into a filter:
  * `pandoc`, `FORMAT`
  * `PANDOC_VERSION`, `PANDOC_API_VERSION`, `PANDOC_SCRIPT_FILE`, `PANDOC_STATE`,
    `PANDOC_READER_OPTIONS`, `PANDOC_WRITER_OPTIONS`
  * `lpeg`, `re` (bundled by Pandoc's embedded interpreter; typed as generic
    tables here rather than fully — see [Scope](#scope) below)
* **Lua 5.4 Targeted**: Matches Pandoc 3.0+, which embeds Lua 5.4 (confirmed via
  `pandoc --version`).

### Scope

`lpeg`/`re` are declared here only as recognized globals of type `table`, not with
full LPeg type coverage (pattern objects, captures, etc.) — that's a large,
Pandoc-independent typing effort that belongs in a dedicated LPeg addon, not
duplicated here. If one exists on LuaRocks, prefer depending on it over expecting
full LPeg types from this package.

## 📝 Usage Example

Once installed, you get full IntelliSense without extra setup:

```lua
-- No need for ---@module or manual requires!
-- LLS now knows 'pandoc' and 'FORMAT' automatically.

function Div(el)
  -- Autocomplete works on 'el' as a pandoc.Div
  if el.classes:includes("important") then
    return pandoc.Div(el.content, pandoc.Attr("", {"highlight"}, {}))
  end
end

function Str(el)
  -- Full type checking on string manipulation
  local text = pandoc.utils.stringify(el)
  return pandoc.Str(text:upper())
end
```

## 🏗️ Project Structure

```text
pandoc-annotations/
├── .luarocks/
│   └── default-lua-version.lua        # LuaRocks project-tree feature (see note below), not LLS/addon-specific
├── library/
│   ├── pandoc-types-globals.lua       # PANDOC_* globals, FORMAT, pandoc, lpeg, re
│   ├── pandoc-types-shared.lua        # Attr, Doc, Reader/WriterOptions, CommonState, ...
│   ├── pandoc-types-blocks.lua        # Block and every Block subtype (incl. the Table family)
│   ├── pandoc-types-inlines.lua       # Inline and every Inline subtype
│   ├── pandoc-types-document.lua      # Pandoc (document class), Meta/MetaValue
│   ├── pandoc-types-list-filter.lua   # List<T>, Blocks/Inlines, Filter
│   ├── pandoc-types-module-core.lua   # the pandoc constructors table
│   ├── pandoc-types-module-layout.lua
│   ├── pandoc-types-module-zip.lua
│   ├── pandoc-types-module-structure.lua
│   ├── pandoc-types-module-utils.lua
│   ├── pandoc-types-module-path.lua
│   ├── pandoc-types-module-mediabag.lua
│   ├── pandoc-types-module-system.lua
│   └── pandoc-types-module-misc.lua   # smaller submodules: text, template, format, cli, json, log, types, scaffolding
├── config.json                        # for the classic/manual Addon Manager path
├── info.json                          # addon display metadata
├── pandoc-annotations-1.0.0-1.rockspec
└── README.md
```

> **Note on `.luarocks/default-lua-version.lua`**: traced this directly in LuaRocks'
> own source rather than guessing from docs. It's a general LuaRocks project-tree
> feature, unrelated to LLS or addons specifically: when a directory is recognized
> as a project (see the `.luarocks/` + `lua_modules/` detection above),
> `<project>/.luarocks/default-lua-version.lua` is read and its returned string used
> as the default `--lua-version` for commands run in that project, if no version was
> given explicitly and no `.luarocks/config-X.Y.lua` exists. In practice this means
> the copy of the file *inside this repo* only matters if you're developing this
> addon locally and have run `luarocks init` inside your own clone of it — it has no
> effect on an end user simply installing the published rock.

## ✅ Verification

Constructor signatures and behaviors in this file weren't just transcribed from the
Pandoc manual — many were confirmed (and in a few cases corrected) by running actual
Pandoc 3.10 filters and inspecting the real Lua values at runtime. A handful of
things this caught that the manual doesn't fully spell out:

- Several constructors accept more optional parameters than documented, or accept
  zero arguments where you might expect a required one.
- Some AST types (`Attr`, `Citation`, `Doc`, `Version`) are userdata at runtime, not
  plain tables, which matters for how they're typed.
- `pandoc.mediabag.fetch` returns `(mimetype, contents)`, not `(contents, mimetype)`.
- Returning `(element, false)` from a filter handler stops descent into that
  element's children — confirmed behaviorally, not just asserted.

## 🔧 Troubleshooting (for addon developers)

If you're iterating on this repo locally rather than just installing it, two things
worth knowing that cost real debugging time to track down:

- **`luarocks build`/`install` always fetches from `source.url` in the rockspec, not
  your local working copy.** Since that's a `git+https://...` URL, local edits to
  `library/` do nothing until you `git push` — the build clones fresh from the
  remote every time. If a rebuild doesn't reflect a change you just made, check
  you've actually pushed first.
- **Rebuilds after a push may need `--force`.** Otherwise you'll just get
  `<name> is already installed`, matching whatever was cloned last time.

See the `.luarocks/`/`lua_modules/` project-detection note and the `sudo` vs.
`--local` note in [Installation](#-installation) above for the other two gotchas
found while getting a real install working end-to-end.

## 🤝 Contributing

Contributions are welcome! If you find missing types or inaccuracies in the Pandoc API:

1. Fork the repository.
2. Edit the files in `library/`.
3. Submit a Pull Request. If your change affects a constructor's signature or return
   shape, a short note on how you confirmed it (manual reference, or a runtime test
   against a specific Pandoc version) helps a lot with review.

## 📄 License

MIT License – See LICENSE for details.

## 🔗 References

* [Pandoc Lua Filters Documentation](https://pandoc.org/lua-filters.html)
* [Lua Language Server Addons](https://luals.github.io/wiki/addons/)
* [luarocks-build-addon](https://github.com/LuaLS/luarocks-build-addon)
* [Original Project (massifrg)](https://github.com/massifrg/pandoc-luals-annotations)
