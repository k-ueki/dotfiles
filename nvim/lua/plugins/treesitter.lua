return {
	-- Syntax highlighting and text objects
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "TSInstall", "TSUpdate", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"go",
					"lua",
					"bash",
					"json",
					"yaml",
					"toml",
					"markdown",
					"markdown_inline",
					"vim",
					"vimdoc",
					"scala",
				},
				auto_install = true,
				highlight = { enable = true },
				indent    = { enable = true },
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = { ["]f"] = "@function.outer" },
						goto_previous_start = { ["[f"] = "@function.outer" },
					},
				},
			})
		end,
	},

	-- Markdown rendering (tables, code blocks, headings)
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		ft = { "markdown" },
		opts = {
			heading = { enabled = true },
			code = { enabled = true },
			bullet = { enabled = true },
		},
	},
}
