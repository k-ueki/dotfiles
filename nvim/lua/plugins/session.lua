return {
  {
    "folke/persistence.nvim",
    lazy = false,
    opts = {},
    config = function(_, opts)
      -- Register BEFORE persistence.setup so this runs first on VimLeavePre
      vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function()
          pcall(vim.cmd, "Neotree close")
          -- Wipe neo-tree buffers so they are not saved in the session file
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.bo[buf].filetype == "neo-tree" then
              pcall(vim.api.nvim_buf_delete, buf, { force = true })
            end
          end
        end,
      })

      require("persistence").setup(opts)

      -- Auto-restore session on startup when no file args given
      vim.api.nvim_create_autocmd("UIEnter", {
        once = true,
        nested = true,
        callback = function()
          if vim.fn.argc(-1) == 0 then
            require("persistence").load()
          end
        end,
      })
    end,
  },
}
