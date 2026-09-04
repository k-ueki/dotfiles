return {
	-- Syntax highlighting and text objects (nvim-treesitter main branch)
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		lazy = false,
		config = function()
			require("nvim-treesitter").setup()

			local parsers = {
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
				"typescript",
				"tsx",
				"javascript",
			}

			-- Install parsers that are missing. `install` is async and no-ops when
			-- a parser is already present, so this is cheap on subsequent starts.
			require("nvim-treesitter").install(parsers)

			-- Enable highlighting per buffer. main branch does not auto-attach
			-- like the old configs.setup did, so we start treesitter on FileType.
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(ev)
					local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
					if lang and pcall(vim.treesitter.start, ev.buf, lang) then
						-- Indent from treesitter (opt-in, main branch)
						vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = "VeryLazy",
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
					include_surrounding_whitespace = false,
				},
				move = {
					set_jumps = true,
				},
			})

			local select = require("nvim-treesitter-textobjects.select")
			local move = require("nvim-treesitter-textobjects.move")

			-- Select
			vim.keymap.set({ "x", "o" }, "af", function()
				select.select_textobject("@function.outer", "textobjects")
			end, { desc = "Around function" })
			vim.keymap.set({ "x", "o" }, "if", function()
				select.select_textobject("@function.inner", "textobjects")
			end, { desc = "Inner function" })
			vim.keymap.set({ "x", "o" }, "ac", function()
				select.select_textobject("@class.outer", "textobjects")
			end, { desc = "Around class" })
			vim.keymap.set({ "x", "o" }, "ic", function()
				select.select_textobject("@class.inner", "textobjects")
			end, { desc = "Inner class" })

			-- Move
			vim.keymap.set("n", "]f", function()
				move.goto_next_start("@function.outer", "textobjects")
			end, { desc = "Next function" })
			vim.keymap.set("n", "[f", function()
				move.goto_previous_start("@function.outer", "textobjects")
			end, { desc = "Prev function" })
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
