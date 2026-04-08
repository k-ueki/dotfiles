return {
	{
		"nvim-tree/nvim-web-devicons",
		lazy = false,
		opts = { default = true },
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			close_if_last_window = true,
			filesystem = {
				filtered_items = {
					visible = true, -- show hidden files (dimmed)
					hide_dotfiles = false,
					hide_gitignored = false,
				},
				follow_current_file = { enabled = true },
			},
			window = {
				width = 35,
				mappings = {
					[">"] = function()
						vim.cmd("vertical resize +" .. 5)
					end,
					["<"] = function()
						vim.cmd("vertical resize -" .. 5)
					end,
				},
			},
		},
		keys = {
			{ "<C-f>", "<Cmd>Neotree toggle<CR>", desc = "Toggle neo-tree" },
			{ "<C-d>", "<Cmd>Neotree reveal<CR>", desc = "Reveal file in neo-tree" },
		},
	},
}
