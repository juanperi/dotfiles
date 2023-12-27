vim.g['test#strategy'] = "vimux"

return {
  "janko-m/vim-test",
  keys = {
    { "<leader>tt", ":w<CR>:TestNearest<CR>" },
    { "<leader>tT", ":w<CR>:TestFile<CR>" },
    { "<leader>ta", ":w<CR>:TestSuite<CR>" },
    { "<leader>tl", ":w<CR>:TestLast<CR>" },
    { "<leader>tf", ":w<CR>:TestSuite --failed<CR>" },
  },
}
