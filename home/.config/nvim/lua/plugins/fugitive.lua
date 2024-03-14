local M = {
  "tpope/vim-fugitive",
  lazy = false,
  keys = {
    { "<leader>gs", ":Git<CR>" },
    { "<leader>gc", ":Gcommit --verbose<CR>" },
    { "<leader>gp", ":Git push<CR>" },
  },
  dependencies = {
    "tpope/vim-dispatch",
  },
}

return M
