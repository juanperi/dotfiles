local M = {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  lazy = false,
  config = function()
    vim.o.termguicolors = true
    vim.o.background = "dark"
    vim.cmd([[colorscheme gruvbox]])
  end,
}

return M
