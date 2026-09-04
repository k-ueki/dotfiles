local map = vim.keymap.set

-- Save / quit
map("n", "<Leader>w", "<Cmd>w<CR>", { desc = "Save" })
map("n", "<Leader>wq", "<Cmd>wq<CR>", { desc = "Save and quit" })
map("n", "<Leader>qq", "<Cmd>q!<CR>", { desc = "Force quit" })

-- Split
map("n", "<Leader>s", "<Cmd>split<CR><C-w>j", { desc = "Horizontal split" })
map("n", "<Leader>v", "<Cmd>vsplit<CR><C-w>l", { desc = "Vertical split" })
map("n", "ss", "<Cmd>sp<CR><C-w>j")
map("n", "sv", "<Cmd>vs<CR><C-w>l")

-- Window navigation (<C-j>/<C-k> are used by edgemotion)
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")

-- Window resize
map("n", "<M-Left>",  "<Cmd>vertical resize -5<CR>", { desc = "Resize window left" })
map("n", "<M-Right>", "<Cmd>vertical resize +5<CR>", { desc = "Resize window right" })
map("n", "<M-Up>",    "<Cmd>resize +3<CR>",          { desc = "Resize window up" })
map("n", "<M-Down>",  "<Cmd>resize -3<CR>",          { desc = "Resize window down" })

-- Line navigation
map({ "n", "v" }, "<Leader>a", "^", { desc = "Line start" })
map({ "n", "v" }, "<Leader>e", "$", { desc = "Line end" })

-- Buffer navigation (defined in plugins/bufferline.lua)

-- Clear search highlight
map("n", "<F3>", "<Cmd>noh<CR>")

-- Escape shortcut
map("i", "jj", "<ESC>")

-- Completion navigation (for nvim-cmp / fallback)
map("i", "<CR>", 'pumvisible() ? "<C-y>" : "<CR>"', { expr = true })
map("i", "<C-j>", 'pumvisible() ? "<Down>" : "<C-n>"', { expr = true })

-- neo-tree (keys are defined in plugins/ui.lua)
-- telescope (keys are defined in plugins/telescope.lua)

-- LSP (set up on LspAttach)
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local opts = { buffer = ev.buf }
		-- Navigation
		-- Jump + center cursor
		local function jump_center(jump_fn)
			return function()
				jump_fn()
				vim.schedule(function()
					vim.cmd("normal! zz")
				end)
			end
		end
		map("n", "<Leader>g", jump_center(vim.lsp.buf.definition), vim.tbl_extend("force", opts, { desc = "Go to definition" }))
		map(
			"n",
			"<Leader>i",
			jump_center(vim.lsp.buf.implementation),
			vim.tbl_extend("force", opts, { desc = "Go to implementation" })
		)
		-- <Leader>u : references. For Scala/Metals, if the symbol under cursor is an
		-- override, ask Metals for the super method position and run references there
		-- so trait-level callers + all impls show up. Falls back to plain references
		-- when there is no super method or the client is not metals.
		local function metals_super_references()
			local client
			for _, c in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
				if c.name == "metals" then
					client = c
					break
				end
			end
			if not client then
				vim.lsp.buf.references()
				return
			end

			local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
			client:request("workspace/executeCommand", {
				command = "metals.goto-super-method",
				arguments = { params },
			}, function(err, result)
				-- Metals returns the super location as a side-effect via
				-- `textDocument/definition`-like flow; if there is no super it
				-- returns nil / an error. In either case we still want references
				-- for the current symbol.
				if err or not result or (type(result) == "table" and vim.tbl_isempty(result)) then
					vim.lsp.buf.references()
					return
				end

				local loc = result[1] or result
				if not (loc and loc.uri and loc.range) then
					vim.lsp.buf.references()
					return
				end

				-- Open the super location in a way that lsp.buf.references can read
				-- the cursor from, then run references there. Use bufnr + set_cursor
				-- without jumping the window so the user's focus is preserved.
				local bufnr = vim.uri_to_bufnr(loc.uri)
				vim.fn.bufload(bufnr)
				local super_params = {
					textDocument = { uri = loc.uri },
					position = loc.range.start,
					context = { includeDeclaration = true },
				}
				client:request("textDocument/references", super_params, function(rerr, rresult)
					if rerr or not rresult or vim.tbl_isempty(rresult) then
						vim.lsp.buf.references()
						return
					end
					local items = vim.lsp.util.locations_to_items(rresult, client.offset_encoding)
					vim.fn.setqflist({}, " ", { title = "References (via super)", items = items })
					vim.cmd("copen")
				end, bufnr)
			end)
		end

		map("n", "<Leader>u", metals_super_references, vim.tbl_extend("force", opts, { desc = "References (super-aware for Scala)" }))
		-- Fallback: plain references only, ignoring super method resolution.
		map("n", "<Leader>uu", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "References (local, no super)" }))

		if ev.data and ev.data.client_id then
			local client = vim.lsp.get_client_by_id(ev.data.client_id)
			if client and client.name == "metals" then
				map("n", "<Leader>us", function()
					require("metals").goto_super_method()
				end, vim.tbl_extend("force", opts, { desc = "Metals: goto super method" }))
				map("n", "<Leader>uh", function()
					require("metals").super_method_hierarchy()
				end, vim.tbl_extend("force", opts, { desc = "Metals: super method hierarchy" }))
			end
		end
		map("n", "K", vim.lsp.buf.hover, opts)
		map("i", "<C-k>", vim.lsp.buf.signature_help, opts)
		-- Refactor
		map("n", "<Leader>R", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename (LSP)" }))
		map("n", "<Leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
		-- Diagnostics
		map("n", "<Leader>d", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Diagnostics float" }))
		map("n", "]d", vim.diagnostic.goto_next, opts)
		map("n", "[d", vim.diagnostic.goto_prev, opts)
		-- Inlay hints (toggle with <Leader>h)
		-- Note: initial state is controlled elsewhere (see config/options.lua)
		-- so that reloading / re-attaching LSP doesn't flip user's choice.
		if vim.lsp.inlay_hint then
			map("n", "<Leader>h", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end, vim.tbl_extend("force", opts, { desc = "Toggle inlay hints (global)" }))
		end
		-- Code Lens (nvim 0.12+: `enable` supersedes `refresh` and auto-refreshes)
		if vim.lsp.codelens and vim.lsp.codelens.enable then
			vim.lsp.codelens.enable(true, { bufnr = ev.buf })
			map("n", "<Leader>cl", vim.lsp.codelens.run, vim.tbl_extend("force", opts, { desc = "Run code lens" }))
		end
		-- Document highlight: highlight the symbol under cursor
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client and client.server_capabilities.documentHighlightProvider then
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = ev.buf,
				callback = vim.lsp.buf.document_highlight,
			})
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = ev.buf,
				callback = vim.lsp.buf.clear_references,
			})
		end
	end,
})

-- <Leader>ac : insert `REVIEW: ` (fix request), <Leader>aq : insert `REVIEW?: ` (question).
-- Comment prefix is taken from the buffer's `commentstring` so it works across languages.
-- Paired with the `review-fix` Claude Code skill: leave notes here, run `/review-fix` later.
local function insert_review_comment(marker)
	local cs = vim.bo.commentstring
	if cs == "" then
		cs = "# %s"
	end
	local line = cs:gsub("%%s", marker)
	local row = vim.api.nvim_win_get_cursor(0)[1]
	local indent = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]:match("^%s*") or ""
	vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, { indent .. line })
	vim.api.nvim_win_set_cursor(0, { row, #indent + #line })
	vim.cmd("startinsert!")
end

vim.keymap.set("n", "<Leader>ac", function()
	insert_review_comment("REVIEW: ")
end, { desc = "Add REVIEW comment (fix — for /review-fix)" })

vim.keymap.set("n", "<Leader>aq", function()
	insert_review_comment("REVIEW?: ")
end, { desc = "Add REVIEW? comment (question — for /review-fix)" })
