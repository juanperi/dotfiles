local M = {
  "morhetz/gruvbox",
  priority = 1000,
  config = true,
  lazy = false,
  config = function()
    vim.o.termguicolors = true
    vim.o.background = "dark"
    vim.cmd([[colorscheme gruvbox]])
  end,
}

return M
