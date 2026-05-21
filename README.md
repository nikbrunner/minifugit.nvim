# flux.nvim

https://github.com/user-attachments/assets/54852a86-f04e-4eea-a432-700de08bb89f

A lightweight Git status UI for Neovim, inspired by
[vim-fugitive](https://github.com/tpope/vim-fugitive).

flux.nvim focuses on a compact status window for everyday Git operations
without leaving Neovim.

## Features

- Open a Git status window with `:Flux`.
- View your files' status.
- Discard unstaged changes or delete untracked paths, with confirmation by
  default.
- Stage and unstage files from the status window (visual mode as well).
- Preview diffs for the entry under the cursor in stacked or split view.
- Stage and unstage hunks from the diff window.
- Create commits.
- Animated loading spinner while pushing your commits.
- View unpushed commits in the status window and preview the diffs.
- Run `:checkhealth flux` to verify Neovim and Git requirements.

## Requirements

- Neovim 0.10+
- `git` executable on `PATH`

## Configuration

### vim.pack

```lua
vim.pack.add({
    'https://github.com/nikbrunner/flux.nvim',
    version = vim.version.range("*") -- stable version
    -- version = "nightly"
})
```

### lazy.nvim

```lua
{
    'nikbrunner/flux.nvim',
    cmd = { 'Flux' },
}
```

### Options

```lua
-- Returns Flux object
require('flux').setup({
    preview = {
        -- Start diff previews with wrapping disabled.
        wrap = false,

        -- Show old/new line numbers in diff previews.
        show_line_numbers = true,

        -- Show git diff metadata rows such as `diff --git`, `index`, `---`,
        -- and `+++`.
        show_metadata = true,

        -- Diff preview layout: 'stacked', 'split', or 'auto'.
        diff_layout = 'stacked',

        -- Editor width where 'auto' switches from stacked to split.
        diff_auto_threshold = 120,
    },
    status = {
        -- Fraction of the editor width used by the status window.
        width = 0.4,

        -- Minimum status window width in columns.
        min_width = 20,

        -- Layout: 'topleft' (opens as a vsplit on the far left) or 'replace'
        -- (replaces the current buffer, like Oil). In replace mode, o opens
        -- the picked file in place and closes the status view.
        layout = 'topleft',
    },
    -- Override specific keymaps by area. Omitted keys keep defaults.
    -- Areas: 'status', 'diff_stacked', 'diff_split', 'help'.
    keymaps = {
        status = {
            { key = 'q', modes = { 'n' }, desc = 'Close status' },
        },
    },
})
```

Diff-preview mappings can toggle `preview.wrap`, `preview.show_line_numbers`,
`preview.show_metadata`, and the diff layout at runtime for the current status
session.

## Usage

Open the status window:

```vim
:Flux
```

```lua
require('flux').status()
```

Default status-window mappings:

| Mode | Key | Action |
| --- | --- | --- |
| n | `<CR>` | Open entry |
| n | `o` | Open entry and close status |
| n | `=` | Preview diff |
| n | `q` | Close status window |
| n | `/` | Filter entries |
| n | `<BS>` | Clear filter |
| n | `r` | Refresh status |
| n,v | `s` | Stage/Unstage entry |
| n,v | `u` | Unstage entry |
| n | `S` | Stage all entries |
| n | `U` | Unstage all entries |
| n | `d` | Discard entry with confirmation |
| n | `D` | Discard entry without confirmation |
| n | `c` | Commit staged changes |
| n | `p` | Push unpushed commits |
| n | `al` | Alternate stacked/split diff layout |
| n | `?` | Toggle help |

Default diff-preview mappings:

| Mode | Key | Action |
| --- | --- | --- |
| n | `q` | Close diff preview |
| n | `[h` / `]h` | Jump to previous/next hunk |
| n | `s` | Stage current unstaged hunk |
| n | `u` | Unstage current staged hunk |
| n | `d` | Discard current unstaged hunk with confirmation |
| n | `aw` | Alternate wrap |
| n | `an` | Alternate line numbers |
| n | `am` | Alternate metadata rows *(stacked only)* |
| n | `al` | Alternate stacked/split layout |

## Testing

Tests use [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)'s busted-style
harness, vendored in the repo.

### Run with just (recommended)

```bash
just test
```

This clones plenary if needed, pins it to the expected commit, and runs the
full suite headlessly.

### Run without just

```bash
nvim --headless --noplugin \
  -u tests/minimal_init.lua \
  -c "lua require('plenary.test_harness').test_directory('tests', { minimal_init = 'tests/minimal_init.lua' })"
```

### Run a single test file

```bash
nvim --headless --noplugin \
  -u tests/minimal_init.lua \
  -c "lua require('plenary.test_harness').test_directory('tests/functional/diff/parser_spec.lua', { minimal_init = 'tests/minimal_init.lua' })"
```

Test files live under `tests/functional/` (pure-Lua unit/integration) and
`tests/ui/` (end-to-end with real Neovim windows and a temporary git
repository).

## Credits

flux.nvim is a fork of [minifugit.nvim](https://github.com/vieitesss/minifugit.nvim)
by [vieitesss](https://github.com/vieitesss). The original plugin provided the
foundation for this lightweight Git status UI — flux.nvim builds on it with a
fresh name and continued development.
