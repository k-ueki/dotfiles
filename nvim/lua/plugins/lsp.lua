return {
	-- LSP progress indicator
	{
		"j-hui/fidget.nvim",
		opts = {
			progress = {
				display = {
					render_limit = 16,
					done_ttl = 3,
					progress_ttl = math.huge,
				},
			},
			notification = {
				window = {
					winblend = 0,
					align = "bottom",
				},
			},
		},
	},

	-- Mason: LSP/formatter/linter installer
	{
		"williamboman/mason.nvim",
		opts = {},
	},

	-- Auto-install formatters/linters via Mason
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"stylua", -- Lua formatter
			},
		},
	},

	-- Bridge between mason and lspconfig
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			require("mason-lspconfig").setup({
				ensure_installed = { "gopls", "terraformls" },
				handlers = {
					function(server)
						require("lspconfig")[server].setup({ capabilities = capabilities })
					end,
				},
			})
		end,
	},

	-- Scala: nvim-metals (metals has a custom setup flow)
	{
		"scalameta/nvim-metals",
		dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/cmp-nvim-lsp" },
		ft = { "scala", "sbt", "java" },
		config = function()
			local metals = require("metals")
			local config = metals.bare_config()
			config.capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- metals バイナリ自体を Java 17 で起動する
			local java17 = "/opt/homebrew/opt/openjdk@17"
			config.cmd_env = {
				JAVA_HOME = java17,
				PATH = java17 .. "/bin:" .. vim.env.PATH,
			}

			config.settings = {
				showImplicitArguments = true,
				excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
			}

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "scala", "sbt", "java" },
				callback = function()
					metals.initialize_or_attach(config)
				end,
			})
		end,
	},
}
