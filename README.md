# Pandoc Annotations

> **The installable Lua Language Server (LLS) addon for Pandoc Lua filters.**
> *Successor to [massifrg/pandoc-luals-annotations](https://github.com/massifrg/pandoc-luals-annotations)*

Provides complete type definitions, AST structures, and global environment setup
for developing
[Pandoc](https://pandoc.org)
Lua filters with intelligent autocomplete and strict type checking.

## ✨ Why Use This?

Unlike the original project which requires manual file copying and `.luarc.json`
configuration, **Pandoc Annotations** is a true **LuaRocks addon**:

- 🚀 **One-Command Install**: `luarocks install pandoc-annotations`
- ⚡ **Zero Configuration**: Automatically injects globals (`pandoc`, `FORMAT`,
    `PANDOC_VERSION`)
- 📦 **Auto-Activation**: Detects Pandoc filter patterns and suggests enabling
- 🔄 **Easy Updates**: Keep types up-to-date with `luarocks upgrade`

## 📦 Installation

### Method 1: LuaRocks (Recommended)
Requires [LuaRocks](https://luarocks.org) and the `luarocks-build-lls-addon` backend.

```bash
# Install the addon globally
luarocks install pandoc-annotations
```

```bash
# Or install locally for the current user
luarocks --local install pandoc-annotations
```

Once installed, restart your editor. LLS will automatically detect the types.

### Method 2: Manual (Legacy Support)
For environments where LuaRocks is unavailable:

1. Clone this repository:
git clone https://github.com/lua-craters/pandoc-annotations.git

2. Add the path to your .luarc.json (in your project root or global config):
   ```json
   {
       "workspace.userThirdParty": ["~/path/to/pandoc-annotations"]
   }
   ```

3. Reload your editor window.

### 🛠️ Features

* Complete AST Typing: Full definitions for pandoc.Div, pandoc.Str, pandoc.Meta, etc.
* Utility Functions: Typed helpers for pandoc.utils.stringify, blocks_to_inlines, etc.
* Global Environment: Pre-configured globals to eliminate "undefined global" warnings:
  * pandoc, FORMAT, PANDOC_VERSION
  * PANDOC_API_VERSION, PANDOC_SCRIPT_FILE
  * lpeg, re (if used in your filters)
* Lua 5.4 Targeted: Optimized for Pandoc 3.0+ (which runs on Lua 5.4).

### 📝 Usage Example
Once installed, you get full IntelliSense without extra setup:

```lua
-- No need for ---@module or manual requires!
-- LLS now knows 'pandoc' and 'FORMAT' automatically.

function Div(el)
  -- Autocomplete works on 'el' as pandoc.Div
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

### 🏗️ Project Structure

```text
pandoc-annotations/
├── library/
│   ├── pandoc.lua          # AST definitions
│   └── pandoc_utils.lua    # Helper functions
├── pandoc-annotations-1.0.0-1.rockspec
├── config.json             # For manual installation support
└── README.md
```

### 🤝 Contributing

Contributions are welcome! If you find missing types or inaccuracies in the Pandoc API:

1. Fork the repository.
2. Edit the files in library/.
3. Submit a Pull Request.

### 📄 License
MIT License – See LICENSE for details.

### 🔗 References

* [Pandoc Lua Filters Documentation](https://pandoc.org/lua-filters.html)
* [Lua Language Server Addons](https://luals.github.io/wiki/addons/)
* [Original Project (massifrg)](https://github.com/massifrg/pandoc-luals-annotations)
