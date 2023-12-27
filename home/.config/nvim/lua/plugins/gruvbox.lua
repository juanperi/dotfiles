local M = {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = true,
  lazy = false,
  config = function()
     vim.cmd([[colorscheme gruvbox]])
  end,
}

return M
