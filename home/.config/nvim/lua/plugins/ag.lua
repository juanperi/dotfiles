vim.g.ag_prg = 'ag -S --nocolor --nogroup --column'

local M = {
  "rking/ag.vim",
  keys = {
    { "F", ":Ag<CR>" },
  }
}

return M
