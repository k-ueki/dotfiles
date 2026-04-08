return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "go", "lua", "bash",
          "json", "yaml", "toml",
          "markdown", "markdown_inline",
          "vim", "vimdoc",
        },
        highlight    = { enable = true },
        indent       = { enable = true },
        textobjects  = {
          select = {
            enable    = true,
            lookahead = true,
            keymaps   = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
          move = {
            enable              = true,
            set_jumps           = true,
            goto_next_start     = { ["]f"] = "@function.outer" },
            goto_previous_start = { ["[f"] = "@function.outer" },
          },
        },
      })
    end,
  },
}
