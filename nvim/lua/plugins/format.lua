return {
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		opts = {
			formatters_by_ft = {
				go = { "goimports", "gofmt" },
				lua = { "stylua" },
				-- Scala: delegate to LSP (Metals + scalafmt). No formatter in this list
				-- so conform falls back to LSP per `format_on_save.lsp_format`.
				scala = {},
			},
			format_on_save = {
				timeout_ms = 3000, -- Scala formatting can be slow
				lsp_format = "fallback",
			},
		},
	},
}
