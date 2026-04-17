# Neovim Configuration

Plugin manager: [lazy.nvim](https://github.com/folke/lazy.nvim) / Colorscheme: tokyonight (night variant, customized) / Font: JetBrainsMono Nerd Font

## Plugins

### LSP & Completion
| Plugin | Purpose |
|--------|---------|
| mason.nvim + mason-lspconfig | LSP server installer (gopls, terraformls) |
| nvim-lspconfig | LSP client configuration |
| nvim-metals | Scala LSP (Metals with Java 17 + Bloop) |
| fidget.nvim | LSP progress indicator |
| nvim-cmp | Completion engine |
| cmp-nvim-lsp / cmp-buffer / cmp-path / cmp-cmdline | Completion sources |
| cmp-nvim-lsp-signature-help | Signature help in completion |
| LuaSnip + cmp_luasnip | Snippet engine |

### UI
| Plugin | Purpose |
|--------|---------|
| neo-tree.nvim | File explorer |
| lualine.nvim | Statusline |
| bufferline.nvim | Tab/buffer line |
| alpha-nvim | Dashboard |
| noice.nvim | Command line / notification UI |
| which-key.nvim | Keybinding hints |
| nvim-scrollbar | Scrollbar with diagnostics |
| outline.nvim | Symbol outline sidebar |
| barbecue.nvim + nvim-navic | Breadcrumbs |
| hlchunk.nvim | Indent / chunk highlight |
| diffview.nvim | Side-by-side diff view |

### Editor
| Plugin | Purpose |
|--------|---------|
| hop.nvim | Word/anywhere jumping |
| quick-scope | f/t target highlight |
| vim-edgemotion | Jump to indent-block boundary |
| nvim-hlslens | Search match count overlay |
| nvim-surround | Surround text objects |
| nvim-autopairs | Auto-close brackets/quotes |
| Comment.nvim | Toggle comments |
| vim-toggle-quickfix | Toggle quickfix/loclist |
| nvim-bqf | Quickfix preview (auto-close on jump) |
| ~~undotree~~ | Disabled (rarely used) |

### Git
| Plugin | Purpose |
|--------|---------|
| gitsigns.nvim | Git signs in gutter |
| vim-fugitive | Git commands |
| diffview.nvim | File history / branch diff |

### Diagnostics
| Plugin | Purpose |
|--------|---------|
| trouble.nvim | Diagnostics / references panel |
| todo-comments.nvim | TODO/FIXME/HACK highlights |

### Treesitter
| Plugin | Purpose |
|--------|---------|
| nvim-treesitter | Syntax highlighting + text objects |
| render-markdown.nvim | Markdown rendering |

### Other
| Plugin | Purpose |
|--------|---------|
| conform.nvim | Formatter (goimports, gofmt, stylua) |
| telescope.nvim + fzf-native | Fuzzy finder |
| persistence.nvim | Auto-save sessions per directory |

## Keymaps

Leader: `Space`

### General
| Key | Action |
|-----|--------|
| `<Leader>w` | Save |
| `<Leader>wq` | Save and quit |
| `<Leader>qq` | Force quit |
| `<Leader>s` | Horizontal split |
| `<Leader>v` | Vertical split |
| `<Leader>a` / `<Leader>e` | Line start / end |
| `<C-h>` / `<C-l>` | Window left / right |
| `<M-Left>` / `<M-Right>` | Resize window horizontally |
| `<M-Up>` / `<M-Down>` | Resize window vertically |
| `<F3>` | Clear search highlight |
| `jj` | Escape (insert mode) |

### LSP
| Key | Action |
|-----|--------|
| `<Leader>g` | Go to definition |
| `<Leader>i` | Go to implementation |
| `<Leader>u` | References (Trouble, refresh) |
| `<Leader>U` | References (quickfix) |
| `K` | Hover |
| `<C-k>` | Signature help (insert) |
| `<Leader>rn` | Rename |
| `<Leader>ca` | Code action |
| `<Leader>d` | Diagnostics float |
| `]d` / `[d` | Next / prev diagnostic |
| `<Leader>h` | Toggle inlay hints |
| `<Leader>cl` | Run code lens |

### Navigation
| Key | Action |
|-----|--------|
| `<Leader>m` | Hop words |
| `<Leader>M` | Hop anywhere |
| `<C-j>` / `<C-k>` | Edge motion down / up |
| `<Leader>f` | Telescope find files |
| `<Leader>r` | Telescope live grep |
| `<Leader>b` | Telescope buffers |
| `<Leader>t` | Neo-tree toggle |

### Git
| Key | Action |
|-----|--------|
| `<Leader>gd` | Diffview toggle |
| `<Leader>gh` | Diffview file history |
| `<Leader>gH` | Diffview branch history |
| `]c` / `[c` | Next / prev hunk (gitsigns) |

### Diagnostics
| Key | Action |
|-----|--------|
| `<Leader>xx` | Workspace diagnostics |
| `<Leader>xd` | Document diagnostics |
| `<Leader>xq` | Quickfix list (Trouble) |
| `<Leader>xt` | Todo list |
| `]t` / `[t` | Next / prev todo |
| `<Leader>q` | Toggle quickfix |
| `<Leader>l` | Toggle loclist |

### Buffer
| Key | Action |
|-----|--------|
| `<Tab>` / `<S-Tab>` | Next / prev buffer |
| `<Leader>x` | Close buffer |

### Other
| Key | Action |
|-----|--------|
| `<Leader>o` | Outline toggle |
