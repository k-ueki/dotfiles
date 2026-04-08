return {
	-- fzf
	{ "junegunn/fzf", build = "./install --all" },
	{ "junegunn/fzf.vim", dependencies = { "junegunn/fzf" } },

	-- Motion
	{
		"easymotion/vim-easymotion",
		init = function()
			vim.keymap.set({ "n", "o" }, "<Leader>m", "<Plug>(easymotion-overwin-f)")
		end,
	},

	-- Surround
	{ "kylechui/nvim-surround", event = "BufReadPre", opts = {} },

	-- Window resize
	-- { "simeji/winresizer" },

	-- Auto pairs + Enter indent
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			local autopairs = require("nvim-autopairs")
			autopairs.setup({ check_ts = true })

			-- nvim-cmp との連携
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},

	-- Comment
	{
		"numToStr/Comment.nvim",
		event = "BufReadPre",
		opts = {
			toggler = { line = "<Leader>/" },
			opleader = { line = "<Leader>/" },
		},
	},

	-- Indent/chunk highlight
	{
		"shellRaining/hlchunk.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			chunk = { enable = true },
			indent = { enable = true },
			line_num = { enable = true },
			blank = { enable = false },
		},
	},
}
