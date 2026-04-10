return {
	-- Motion: word/anywhere jumping
	{
		"hadronized/hop.nvim",
		event = "BufReadPre",
		config = function()
			local hop = require("hop")
			hop.setup()
			local map = vim.keymap.set
			map({ "n", "v" }, "<Leader>m", hop.hint_words,    { desc = "Hop words" })
			map({ "n", "v" }, "<Leader>M", hop.hint_anywhere, { desc = "Hop anywhere" })
		end,
	},

	-- Motion: highlight f/t targets
	{ "unblevable/quick-scope", event = "BufReadPre" },

	-- Motion: jump to indent-block boundary
	{
		"haya14busa/vim-edgemotion",
		event = "BufReadPre",
		init = function()
			local map = vim.keymap.set
			map({ "n", "v" }, "<C-j>", "<Plug>(edgemotion-j)", { desc = "Edge down" })
			map({ "n", "v" }, "<C-k>", "<Plug>(edgemotion-k)", { desc = "Edge up" })
		end,
	},

	-- Search: match count overlay
	{
		"kevinhwang91/nvim-hlslens",
		event = "BufReadPre",
		config = function()
			require("hlslens").setup()
			local map  = vim.keymap.set
			local opts = { noremap = true, silent = true }
			map("n", "n",  [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], opts)
			map("n", "N",  [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], opts)
			map("n", "*",  [[*<Cmd>lua require('hlslens').start()<CR>]], opts)
			map("n", "#",  [[#<Cmd>lua require('hlslens').start()<CR>]], opts)
			map("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], opts)
			map("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], opts)
		end,
	},

	-- Editing: surround text objects
	{ "kylechui/nvim-surround", event = "BufReadPre", opts = {} },

	-- Editing: auto-close brackets/quotes
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({ check_ts = true })
			-- nvim-cmp 連携
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},

	-- Editing: toggle comments
	{
		"numToStr/Comment.nvim",
		event = "BufReadPre",
		opts = {
			toggler  = { line = "<Leader>/" },
			opleader = { line = "<Leader>/" },
		},
	},

	-- Toggle quickfix/loclist
	{
		"drmingdrmer/vim-toggle-quickfix",
		event = "VeryLazy",
		init = function()
			vim.keymap.set("n", "<Leader>q", "<Plug>window:quickfix:toggle", { desc = "Toggle quickfix" })
			vim.keymap.set("n", "<Leader>l", "<Plug>window:location:toggle", { desc = "Toggle loclist" })
		end,
	},

	-- Undo tree with persistent history
	{
		"mbbill/undotree",
		cmd  = "UndotreeToggle",
		keys = {
			{ "<Leader>U", "<Cmd>UndotreeToggle<CR>", desc = "Undo tree" },
		},
	},
}
