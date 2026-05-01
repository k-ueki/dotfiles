vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.wrap = false
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.autoread = true

-- Auto-reload files changed outside nvim (e.g. by CLI tools)
vim.api.nvim_create_autocmd({ "WinEnter", "FocusGained", "BufEnter" }, {
	pattern = "*",
	command = "checktime",
})
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamed"
vim.opt.hidden = true
vim.opt.encoding = "utf-8"
vim.opt.list = true
-- vim.opt.listchars = { tab = "--" }
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.timeoutlen = 400  -- Mapping timeout (e.g. jj, <Leader>xx)
vim.opt.ttimeoutlen = 10  -- Terminal key code timeout (fast ESC response)
vim.opt.updatetime = 300  -- Faster CursorHold (LSP document highlight, etc.)
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- .sbt files as Scala
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.sbt",
	command = "set filetype=scala",
})

-- Inlay hints: disabled by default (toggle with <Leader>h)
-- Metals sometimes returns `<notype>` placeholders, so we keep it off globally.
