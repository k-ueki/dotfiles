return {
	{
		"akinsho/bufferline.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		keys = {
			{ "<C-p>", "<Cmd>BufferLineCyclePrev<CR>" },
			{ "<C-n>", "<Cmd>BufferLineCycleNext<CR>" },
			{ "<Leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", desc = "Buffer 1" },
			{ "<Leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", desc = "Buffer 2" },
			{ "<Leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", desc = "Buffer 3" },
			{ "<Leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", desc = "Buffer 4" },
			{ "<Leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", desc = "Buffer 5" },
			{ "<Leader>9", "<Cmd>BufferLineGoToBuffer -1<CR>", desc = "Last buffer" },
		},
		config = function()
			require("nvim-web-devicons").setup({ default = true })

			require("bufferline").setup({
				options = {
					separator_style = "slant",
					diagnostics = "nvim_lsp",
					diagnostics_indicator = function(count, level)
						local icon = level:match("error") and " " or " "
						return " " .. icon .. count
					end,
					show_buffer_icons = true,
					color_icons = true,
					show_close_icon = false,
					show_buffer_close_icons = false,
					indicator = { style = "underline" },
					sort_by = "insert_after_current",
					hover = {
						enabled = true,
						delay = 150,
						reveal = { "close" },
					},
					offsets = {
						{
							filetype = "neo-tree",
						},
					},
				},
				highlights = {
					indicator_selected = { fg = "#5fafff" },
					buffer_selected = { fg = "#ffffff", bold = true, italic = false },
					modified = { fg = "#d78700" },
					modified_selected = { fg = "#d78700" },
					modified_visible = { fg = "#d78700" },
				},
			})
		end,
	},
}
