# Overview

Custom Neovim configuration built for the **nightly snapshot**.

## Features

- **Native Package Management**: Uses built-in `vim.pack.add()` (no plugin manager required)
- **Modern Editor Tools**: LSP, Treesitter and Completion `Blink.cmp`. "It just werks"
- **Nice UI Elements**: Smooth scrolling, which-key hints, status-line.
- **Navigation**: FZF-based file/buffer/grep searching with `fzf-lua`
- **Neovim Lua Configuration**: LSP and completions to configure neovim, with `plenary`.
- TODO: Coherent keybinds (copy doom emacs?).
- TODO: Package manager helpers?
    Something that deletes removed packages when delisted from vim.pack
    Keybinding for automatic update

Help me to refactor my neovim configuration with the following goals:
    - Expand the configuration into multiple files.
    - Remove the abbreviations like map and automcd, where the complete call its defined in variables.
    - Implement a fast and minimal solution for autoformat, which currently uses conform. Prioritize fast and built-in tools, for the js formatter for example I heard there are alternative tools to prettier which are much faster, or even the new bun formatter if possible.
    - Fix LSP, which stopped working out of nowhere for js/ts.
    - Set wrap inside text or md files.
