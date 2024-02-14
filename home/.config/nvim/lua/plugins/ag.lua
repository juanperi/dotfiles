vim.g.ag_prg = 'ag -S --nocolor --nogroup --column'

local M = {
  "rking/ag.vim",
  lazy = false,
  keys = {
    { "F", ":Ag<CR>" },
  }
}

return M
