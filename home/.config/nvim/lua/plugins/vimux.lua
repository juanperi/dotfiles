vim.g.VimuxUseNearest = 1 -- use nearest pane for output
vim.g.VimuxOrientation = 'h'
vim.g.VimuxHeight = 30

return {
  "preservim/vimux",
  lazy = false,
  keys = {
    { "<leader>rl", ":w<CR>:VimuxRunLastCommand<CR>" }
  }
}
