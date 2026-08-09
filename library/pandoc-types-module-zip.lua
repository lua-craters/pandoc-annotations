---@diagnostic disable: duplicate-doc-field, duplicate-doc-alias
---@meta pandoc-types-module-zip
-- The `pandoc.zip` module and its archive/entry/options types.
--
-- Part of the split pandoc-types LuaLS annotation set. Files in this set
-- cross-reference each other's types freely -- LuaLS resolves @class/@alias
-- names across ALL files in the same library folder, so file boundaries here
-- are purely organizational and carry no functional meaning.

---Functions to create, modify, and extract files from zip archives.
---@class PandocZipModule Functions to create, modify, and extract files from zip archives. The module can be called as a function, in which case it behaves like its `zip` function.
---@field Archive fun(bytestring_or_entries?: string|ZipEntry[]): ZipArchive Reads an Archive structure from a raw zip archive or a list of Entry items; throws an error if the given string cannot be decoded into an archive. The argument defaults to an empty list of `ZipEntry`.
---@field Entry fun(path: string, contents: string, modtime?: integer): ZipEntry Generates a `ZipEntry` from a filepath, uncompressed content, and the file’s modification time.
---@field read_entry fun(filepath: string, opts?: ZipOptions): ZipEntry Generates a ZipEntry from a file or directory.
---@field zip fun(filepaths: string[], opts: ZipOptions): ZipArchive Package and compress the given files into a new Archive.

---@class ZipArchive A zip Archive.
---@field entries ZipEntry[] Files in this zip archive.
---@field bytestring fun(self: ZipArchive): string Returns the raw binary `string` representation of the archive.
---@field extract fun(self: ZipArchive, opts?: ZipOptions) Extract all files from this archive, creating directories as needed. Note that the last-modified time is set correctly only in POSIX, not in Windows. This function fails if encrypted entries are present.

---@class ZipEntry An entry in a `ZipArchive`.
---@field modtime integer Modification time (seconds since unix epoch).
---@field path string Relative path, using `/` as separator.
---@field contents fun(self: ZipEntry, password?: string): string Binary contents of this entry.

---@class ZipOptions
---@field recursive? boolean Recurse directories when set to `true`.
---@field verbose? boolean Print info messages to stdout.
---@field destination? string The directory in which to extract.
---@field location? string It is used as path name, defining where files are placed.
---@field preserve_symlinks? boolean Whether symbolic links are preserved as such. This option is ignored on Windows.
