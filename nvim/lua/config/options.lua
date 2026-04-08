vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.cursorline     = true
vim.opt.tabstop        = 4
vim.opt.shiftwidth     = 4
vim.opt.expandtab      = false
vim.opt.ignorecase     = true
vim.opt.smartcase      = true
vim.opt.hlsearch       = true
vim.opt.wrap           = false
vim.opt.backup         = false
vim.opt.swapfile       = false
vim.opt.autoread       = true
vim.opt.mouse          = "a"
vim.opt.clipboard      = "unnamed"
vim.opt.hidden         = true
vim.opt.encoding       = "utf-8"
vim.opt.list           = true
vim.opt.listchars      = { tab = ">-" }
vim.opt.completeopt    = { "menuone", "noinsert", "noselect" }
vim.opt.signcolumn     = "yes"
vim.opt.termguicolors  = true

vim.g.mapleader      = " "
vim.g.maplocalleader = " "

-- .sbt files as Scala
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.sbt",
  command = "set filetype=scala",
})
