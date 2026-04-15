local map = vim.keymap.set

-- Save / quit
map("n", "<Leader>w",  "<Cmd>w<CR>",  { desc = "Save" })
map("n", "<Leader>wq", "<Cmd>wq<CR>", { desc = "Save and quit" })
map("n", "<Leader>qq", "<Cmd>q!<CR>", { desc = "Force quit" })

-- Split
map("n", "<Leader>s", "<Cmd>split<CR><C-w>j",  { desc = "Horizontal split" })
map("n", "<Leader>v", "<Cmd>vsplit<CR><C-w>l",  { desc = "Vertical split" })
map("n", "ss", "<Cmd>sp<CR><C-w>j")
map("n", "sv", "<Cmd>vs<CR><C-w>l")

-- Window navigation (<C-j>/<C-k> are used by edgemotion)
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")

-- Line navigation
map({ "n", "v" }, "<Leader>a", "^", { desc = "Line start" })
map({ "n", "v" }, "<Leader>e", "$", { desc = "Line end" })

-- Buffer navigation (defined in plugins/bufferline.lua)

-- Clear search highlight
map("n", "<F3>", "<Cmd>noh<CR>")

-- Escape shortcut
map("i", "jj", "<ESC>")

-- Completion navigation (for nvim-cmp / fallback)
map("i", "<CR>",  'pumvisible() ? "<C-y>" : "<CR>"',   { expr = true })
map("i", "<C-j>", 'pumvisible() ? "<Down>" : "<C-n>"', { expr = true })

-- neo-tree (keys are defined in plugins/ui.lua)
-- telescope (keys are defined in plugins/telescope.lua)

-- LSP (set up on LspAttach)
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local opts = { buffer = ev.buf }
		-- Navigation
		map("n", "<Leader>g",  vim.lsp.buf.definition,     vim.tbl_extend("force", opts, { desc = "Go to definition" }))
		map("n", "<Leader>i",  vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
		map("n", "<Leader>u",  "<Cmd>Trouble lsp_references toggle<CR>", vim.tbl_extend("force", opts, { desc = "References" }))
		map("n", "K",          vim.lsp.buf.hover,          opts)
		map("i", "<C-k>",      vim.lsp.buf.signature_help, opts)
		-- Refactor
		map("n", "<Leader>rn", vim.lsp.buf.rename,         vim.tbl_extend("force", opts, { desc = "Rename" }))
		map("n", "<Leader>ca", vim.lsp.buf.code_action,    vim.tbl_extend("force", opts, { desc = "Code action" }))
		-- Diagnostics
		map("n", "<Leader>d",  vim.diagnostic.open_float,  vim.tbl_extend("force", opts, { desc = "Diagnostics float" }))
		map("n", "]d",         vim.diagnostic.goto_next,   opts)
		map("n", "[d",         vim.diagnostic.goto_prev,   opts)
		-- Inlay hints (toggle with <Leader>h)
		if vim.lsp.inlay_hint then
			vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
			map("n", "<Leader>h", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
			end, vim.tbl_extend("force", opts, { desc = "Toggle inlay hints" }))
		end
		-- Code Lens
		if vim.lsp.codelens then
			vim.lsp.codelens.refresh()
			map("n", "<Leader>cl", vim.lsp.codelens.run, vim.tbl_extend("force", opts, { desc = "Run code lens" }))
		end
	end,
})

-- Auto-refresh code lens on buffer changes
vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
	callback = function()
		if #vim.lsp.get_clients({ bufnr = 0 }) > 0 then
			vim.lsp.codelens.refresh()
		end
	end,
})
