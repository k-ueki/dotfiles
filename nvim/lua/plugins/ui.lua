return {
	-- Icons (used by neo-tree, bufferline, etc.)
	{
		"nvim-tree/nvim-web-devicons",
		lazy = false,
		opts = { default = true },
	},

	-- File explorer
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
			{ "<C-g>", "<Cmd>Neotree git_status toggle<CR>", desc = "Git status (neo-tree)" },
		},
	},

	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		event = "VimEnter",
		opts = {
			options = {
				theme = require("lualine-kuroi"),
				section_separators = "",
				component_separators = "|",
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		},
	},

	-- Buffer tabs
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
						{ filetype = "neo-tree" },
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

	-- Dashboard
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VimEnter",
		config = function()
			local alpha = require("alpha")
			local dash = require("alpha.themes.dashboard")
			dash.section.header.val = {
				"                                                     ",
				"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
				"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
				"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
				"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
				"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
				"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
				"                                                     ",
			}
			dash.section.buttons.val = {
				dash.button("f", "  Find file", "<Cmd>Telescope git_files<CR>"),
				dash.button("r", "  Recent files", "<Cmd>Telescope oldfiles<CR>"),
				dash.button("g", "  Live grep", "<Cmd>Telescope live_grep<CR>"),
				dash.button("s", "  Restore session", "<Cmd>lua require('persistence').load()<CR>"),
				dash.button("q", "  Quit", "<Cmd>qa<CR>"),
			}
			alpha.setup(dash.config)
		end,
	},

	-- UI overrides (cmdline, messages, popups)
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		opts = {
			cmdline = { view = "cmdline" },
			lsp = {
				progress = { enabled = false }, -- fidget.nvim が担当
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				lsp_doc_border = true,
			},
		},
	},

	-- Keybinding hints
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = { delay = 500 },
	},

	-- Scrollbar with search/git markers
	{
		"petertriho/nvim-scrollbar",
		event = "BufReadPre",
		opts = {
			handlers = {
				cursor = true,
				search = true, -- hlslens 連携
				gitsigns = true, -- gitsigns 連携
			},
		},
	},

	-- Symbol outline — IntelliJ-like structure view
	{
		"hedyhli/outline.nvim",
		cmd = { "Outline", "OutlineOpen" },
		keys = {
			{ "<Leader>o", "<Cmd>Outline<CR>", desc = "Toggle symbol outline" },
		},
		opts = {
			outline_window = {
				position = "right",
				width = 30,
			},
			symbols = {
				filter = {
					default = {
						"Class",
						"Constructor",
						"Enum",
						"Field",
						"Function",
						"Interface",
						"Method",
						"Module",
						"Namespace",
						"Object",
						"Property",
						"Struct",
						"Trait",
						"Variable",
					},
				},
			},
		},
	},

	-- Breadcrumbs (winbar) — IntelliJ-like navigation context
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			show_dirname = false,
			show_basename = true,
			kinds = false, -- use nvim-web-devicons instead of kind icons
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

	-- Diffview — IntelliJ-like side-by-side diff
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
		keys = {
			{ "<Leader>gd", "<Cmd>DiffviewOpen<CR>", desc = "Diffview: open" },
			{ "<Leader>gh", "<Cmd>DiffviewFileHistory %<CR>", desc = "Diffview: file history" },
			{ "<Leader>gH", "<Cmd>DiffviewFileHistory<CR>", desc = "Diffview: branch history" },
		},
		opts = {},
	},
}
