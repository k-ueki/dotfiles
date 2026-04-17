return {
	-- Diagnostics / references panel
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		keys = {
			{
				"<Leader>xx",
				"<Cmd>Trouble diagnostics toggle<CR>",
				desc = "Workspace diagnostics",
			},
			{
				"<Leader>xd",
				"<Cmd>Trouble diagnostics toggle filter.buf=0<CR>",
				desc = "Document diagnostics",
			},
			{ "<Leader>xu", "<Cmd>Trouble lsp_references toggle<CR>", desc = "LSP references" },
			{ "<Leader>xq", "<Cmd>Trouble qflist toggle<CR>", desc = "Quickfix list" },
		},
		opts = {
			focus = true,
		},
	},

	-- TODO/FIXME/HACK highlights
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{
				"]t",
				function()
					require("todo-comments").jump_next()
				end,
				desc = "Next todo",
			},
			{
				"[t",
				function()
					require("todo-comments").jump_prev()
				end,
				desc = "Prev todo",
			},
			{ "<Leader>xt", "<Cmd>Trouble todo toggle<CR>", desc = "Todo list" },
		},
		opts = {},
	},
}
