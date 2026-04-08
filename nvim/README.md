# Neovim Configuration

Plugin manager: [lazy.nvim](https://github.com/folke/lazy.nvim)

## Colorscheme

| Plugin | Description |
|--------|-------------|
| kuroi (local) | Bundled dark colorscheme (`nvim/colors/kuroi.vim`) |

## UI

| Plugin | Description | Keys |
|--------|-------------|------|
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | File icons | — |
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | File explorer sidebar | `<C-f>` toggle, `<C-d>` reveal, `<C-g>` git status |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline | — |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Buffer tabs | `<Tab>` next, `<S-Tab>` prev, `<Leader>bd` close |
| [alpha-nvim](https://github.com/goolord/alpha-nvim) | Dashboard on startup | `f` files, `r` recent, `g` grep, `s` session, `q` quit |
| [noice.nvim](https://github.com/folke/noice.nvim) | UI overrides (cmdline, messages, popups) | — |
| [fidget.nvim](https://github.com/j-hui/fidget.nvim) | LSP progress indicator | — |
| [nvim-scrollbar](https://github.com/petertriho/nvim-scrollbar) | Scrollbar with search/git markers | — |
| [hlchunk.nvim](https://github.com/shellRaining/hlchunk.nvim) | Indent/chunk highlight | — |

## File Search

| Plugin | Description | Keys |
|--------|-------------|------|
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder | `<Leader>f` git files, `<Leader>F` git status, `<Leader>b` buffers, `<Leader>.` buffer lines, `<Leader>r` live grep, `<Leader>h` recent files, `<Leader>?` keymaps |
| [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) | fzf sorter for telescope | — |
| [telescope-all-recent.nvim](https://github.com/prochri/telescope-all-recent.nvim) | Frecency sorting (SQLite) | — |

## LSP & Completion

| Plugin | Description |
|--------|-------------|
| [mason.nvim](https://github.com/williamboman/mason.nvim) | LSP/formatter/linter installer |
| [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) | Bridge between mason and lspconfig |
| [mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) | Auto-install tools (stylua) |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP client configs. Servers: `gopls` |
| [nvim-metals](https://github.com/scalameta/nvim-metals) | Scala/Metals LSP (Java 17 required) |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Completion engine |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine |

LSP keymaps (on attach):

| Key | Action |
|-----|--------|
| `<Leader>g` | Go to definition |
| `<Leader>i` | Go to implementation |
| `<Leader>u` | References |
| `K` | Hover |
| `<C-k>` | Signature help (insert mode) |
| `<Leader>rn` | Rename |
| `<Leader>ca` | Code action |
| `<Leader>d` | Diagnostics float |
| `]d` / `[d` | Next/prev diagnostic |

## Diagnostics

| Plugin | Description | Keys |
|--------|-------------|------|
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Diagnostics/references panel | `<Leader>xx` workspace, `<Leader>xd` document, `<Leader>xu` references, `<Leader>xq` quickfix |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | TODO/FIXME/HACK highlights | `]t` / `[t` jump, `<Leader>xt` list |

## Git

| Plugin | Description | Keys |
|--------|-------------|------|
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git hunk signs in signcolumn | `]c` / `[c` next/prev hunk, `<Leader>hp` preview, `<Leader>hr` reset, `<Leader>hb` blame |

## Treesitter

| Plugin | Description |
|--------|-------------|
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting + parsing. Languages: go, lua, bash, json, yaml, toml, markdown, vim, vimdoc, scala |
| [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) | Text objects: `af`/`if` function, `ac`/`ic` class; `]f`/`[f` move |

## Motion & Editing

| Plugin | Description | Keys |
|--------|-------------|------|
| [hop.nvim](https://github.com/hadronized/hop.nvim) | EasyMotion-style jumping | `<Leader>m` words, `<Leader>M` anywhere |
| [quick-scope](https://github.com/unblevable/quick-scope) | f/t target highlight | automatic |
| [vim-edgemotion](https://github.com/haya14busa/vim-edgemotion) | Jump to indent block boundary | `<C-j>` down, `<C-k>` up |
| [nvim-hlslens](https://github.com/kevinhwang91/nvim-hlslens) | Search match count overlay | `n`/`N`/`*`/`#` (enhanced) |
| [nvim-surround](https://github.com/kylechui/nvim-surround) | Surround text objects | `ys`/`cs`/`ds` |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto-close brackets/quotes | automatic |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | Toggle comments | `<Leader>/` |
| [undotree](https://github.com/mbbill/undotree) | Visual undo history (persistent) | `<Leader>U` |

## Formatting

| Plugin | Description |
|--------|-------------|
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Format on save. Go: `goimports`+`gofmt`, Lua: `stylua` |

## Session

| Plugin | Description |
|--------|-------------|
| [persistence.nvim](https://github.com/folke/persistence.nvim) | Auto-save/restore sessions per directory |

Session is restored automatically on startup (when no file args given). neo-tree buffers are excluded from the session file.

## Keymaps (global)

| Key | Action |
|-----|--------|
| `<Leader>w` | Save |
| `<Leader>wq` | Save and quit |
| `<Leader>qq` | Force quit |
| `<Leader>s` | Horizontal split |
| `<Leader>v` | Vertical split |
| `<C-h>` / `<C-l>` | Window navigation |
| `<Leader>a` / `<Leader>e` | Line start / end |
| `<F3>` | Clear search highlight |
| `jj` | Escape (insert mode) |
| `<Leader>?` | Show all keymaps (Telescope) |

[which-key.nvim](https://github.com/folke/which-key.nvim) shows available keybindings after pressing `<Leader>`.
