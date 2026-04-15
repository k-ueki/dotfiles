return {
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		opts = {
			formatters_by_ft = {
				go = { "goimports", "gofmt" },
				lua = { "stylua" },
				scala = { "lsp" },
			},
			format_on_save = {
				timeout_ms = 3000, -- Scala formatting can be slow
				lsp_fallback = true,
			},
		},
	},
}
