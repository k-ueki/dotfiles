return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "prochri/telescope-all-recent.nvim", dependencies = { "kkharji/sqlite.lua" } },
		},
		cmd = "Telescope",
		keys = {
			{ "<Leader>f", "<Cmd>Telescope git_files<CR>", desc = "Git files" },
			{ "<Leader>F", "<Cmd>Telescope git_status<CR>", desc = "Git status" },
			{ "<Leader>b", "<Cmd>Telescope buffers<CR>", desc = "Buffers" },
			{ "<Leader>.", "<Cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Buffer lines" },
			{ "<Leader>r", "<Cmd>Telescope live_grep<CR>", desc = "Live grep" },
			{ "<Leader>h", "<Cmd>Telescope oldfiles<CR>", desc = "Recent files" },
			{ "<Leader>?", "<Cmd>Telescope keymaps<CR>", desc = "Keymaps" },
		},
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				defaults = {
					sorting_strategy = "ascending",
					layout_config = { prompt_position = "top" },
				},
			})
			telescope.load_extension("fzf")
			require("telescope-all-recent").setup({})
		end,
	},
}
