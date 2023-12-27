local FZF = {
  "junegunn/fzf",
  dir = "~/.fzf",
  build = "./install --all"
}
local FZFVIM = {
  "junegunn/fzf.vim",
  keys = {
    {"<c-p>", ":FZF<CR>"}
  }
}

return {FZF, FZFVIM}
