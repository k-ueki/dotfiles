return {
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G" },
		keys = {
			{ "<Leader>gB", "<Cmd>Git blame<CR>", desc = "Git blame (full file)" },
		},
	},

	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "▁" },
				topdelete = { text = "▔" },
				changedelete = { text = "▎" },
			},
			on_attach = function(buf)
				local gs = package.loaded.gitsigns
				local map = function(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buf, desc = desc })
				end
				map("n", "]c", gs.next_hunk, "Next hunk")
				map("n", "[c", gs.prev_hunk, "Prev hunk")
				map("n", "<Leader>hp", gs.preview_hunk, "Preview hunk")
				map("n", "<Leader>hr", gs.reset_hunk, "Reset hunk")
				map("n", "<Leader>hb", gs.blame_line, "Blame line")
				map("n", "<Leader>gb", gs.blame_line, "Git blame (current line)")
			end,
		},
	},
}
