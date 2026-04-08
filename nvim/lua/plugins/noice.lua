return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      cmdline = {
        view = "cmdline"
	  },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search        = true,   -- classic bottom cmdline for search
        command_palette      = true,   -- position cmdline and popupmenu together
        long_message_to_split = true,  -- long messages in split
        lsp_doc_border       = true,   -- border for hover/signature
      },
    },
  },
}
