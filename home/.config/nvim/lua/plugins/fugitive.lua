local M = {
  "tpope/vim-fugitive",
  lazy = false,
  keys = {
    { "<leader>gs", ":Git<CR>", desc="[g]it [s]tatus" },
    { "<leader>gc", ":Gcommit --verbose<CR>", desc="[g]it [c]ommit" },
    { "<leader>gp", ":Git push<CR>", mode="n", desc="[g]it [p]ush" },
    { "<leader>gy", ":GBrowse!<CR>", mode="n", desc="[g]it [y]ank Copies the github url to the clipboard" },
    { "<leader>gy", ":GBrowse!<CR>", mode="v", desc="[g]it [y]ank Copies the github url to the clipboard" },
    { "<leader>gb", ":GBrowse<CR>", mode="n", desc="[g]it [b]rowse Open the github url in the browser" },
    { "<leader>gb", ":GBrowse<CR>", mode="v", desc="[g]it [b]rowse Open the github url in the browser" },
  },
  dependencies = {
    "tpope/vim-dispatch",
    "tpope/vim-rhubarb",
  },
}

return M
