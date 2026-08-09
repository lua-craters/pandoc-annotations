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
