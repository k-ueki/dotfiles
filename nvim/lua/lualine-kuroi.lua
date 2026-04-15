-- Lualine theme for kuroi colorscheme
-- Palette extracted from colors/kuroi.vim
local colors = {
  bg        = "#1b1918",
  fg        = "#c5c8c6",
  selection = "#373b41",
  line      = "#282a2e",
  comment   = "#707880",
  red       = "#d75f87",
  orange    = "#d78700",
  yellow    = "#ffd700",
  green     = "#5faf5f",
  aqua      = "#87afd7",
  blue      = "#5fafff",
  purple    = "#8787ff",
  statusbg  = "#6c6c6c",
  gray      = "#262626",
}

return {
  normal = {
    a = { fg = colors.bg, bg = colors.blue, gui = "bold" },
    b = { fg = colors.fg, bg = colors.selection },
    c = { fg = colors.comment, bg = colors.gray },
  },
  insert = {
    a = { fg = colors.bg, bg = colors.green, gui = "bold" },
  },
  visual = {
    a = { fg = colors.bg, bg = colors.purple, gui = "bold" },
  },
  replace = {
    a = { fg = colors.bg, bg = colors.red, gui = "bold" },
  },
  command = {
    a = { fg = colors.bg, bg = colors.orange, gui = "bold" },
  },
  inactive = {
    a = { fg = colors.comment, bg = colors.gray },
    b = { fg = colors.comment, bg = colors.gray },
    c = { fg = colors.comment, bg = colors.gray },
  },
}
