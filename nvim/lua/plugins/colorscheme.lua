return {
	-- Bundled kuroi colorscheme (backup, disabled)
	{
		dir = vim.fn.stdpath("config"),
		name = "kuroi",
		priority = 1000,
		enabled = false,
	},

	-- Tokyo Night (active)
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				style = "night", -- "storm" | "night" | "moon" | "day"
				transparent = false,
				on_colors = function(c)
					c.bg = "#070707"
					c.bg_dark = "#040404"
					c.bg_float = "#070707"
					c.bg_sidebar = "#040404"
					c.bg_statusline = "#040404"
				end,
				on_highlights = function(hl, c)
					-- Diff colors (stronger contrast against dark bg)
					hl.DiffAdd    = { bg = "#1e3a2f" }
					hl.DiffChange = { bg = "#1f2937" }
					hl.DiffText   = { bg = "#264f78", fg = "#ffffff" }
					hl.DiffDelete = { bg = "#3a1f24", fg = "#3a1f24" }
					hl.DiffviewDiffAddAsDelete = { bg = "#3a1f24", fg = "#3a1f24" }
					hl.DiffviewDiffDelete      = { fg = "#1a1a1a" }
					-- Highlight same symbols under cursor (via LSP document highlight)
					hl.LspReferenceText  = { bg = "#2a2f3d" }
					hl.LspReferenceRead  = { bg = "#2a2f3d" }
					hl.LspReferenceWrite = { bg = "#3a2f3d" }
				end,
			})
			vim.cmd.colorscheme("tokyonight-night")

			-- Use dotted filler character for deleted regions in diff
			vim.opt.fillchars:append({ diff = "╱" })
		end,
	},

	-- Kanagawa: LSP/TreeSitter-rich dark theme
	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		enabled = false,
		config = function()
			require("kanagawa").setup({
				theme = "wave",
				background = { dark = "wave" },
			})
			vim.cmd.colorscheme("kanagawa-wave")
		end,
	},
}
