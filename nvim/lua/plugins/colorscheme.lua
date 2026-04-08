-- Load the bundled kuroi colorscheme from dotfiles/nvim/colors/
return {
	{
		-- dummy spec to apply local colorscheme on startup
		dir = vim.fn.stdpath("config"),
		name = "kuroi",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("kuroi")

			-- bufferline needs contrast between tab bg and fill bg
			-- kuroi's TabLine (#1c1c1c) and TabLineFill (#1b1918) are nearly identical
			local set = vim.api.nvim_set_hl
			set(0, "TabLine", { fg = "#c5c8c6", bg = "#2d2d2d" })
			set(0, "TabLineFill", { bg = "#1b1918" })
			set(0, "TabLineSel", { fg = "#ffffff", bg = "#3d4148", bold = true })
		end,
	},

	-- Colorscheme (using bundled kuroi)
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		enabled = false, -- using local kuroi
	},
}
