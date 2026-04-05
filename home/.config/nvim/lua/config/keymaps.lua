local map = vim.keymap.set

-- Better up/down
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Down (wrap-aware)" })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Up (wrap-aware)" })

-- Windows management
map("n", "<leader>we", "<C-w>v<C-w>l", { silent = true, desc = "Window: split right" })
map("n", "<leader>ws", "<C-w>s<C-w>j", { silent = true, desc = "Window: split down" })
map("n", "<leader>wq", "<C-w>v<C-w>h", { silent = true, desc = "Window: split left" })
map("n", "<leader>w2", "<C-w>s<C-w>k", { silent = true, desc = "Window: split up" })
map("n", "<leader>wc", "<C-w>c", { silent = true, desc = "Window: close" })
map("n", "<leader>wx", "<C-w>x", { silent = true, desc = "Window: swap" })
map("n", "<S-l>", "gt", { silent = true, desc = "Tab: next" })
map("n", "<S-h>", "gT", { silent = true, desc = "Tab: prev" })

-- Faster save
map("n", "<C-s>", "<cmd>write<cr>", { silent = true, desc = "Save" })

-- escape insert mode
map("i", "jj", "<ESC>", { desc = "Escape" })

-- Make the dash be considered as part of a word. Useful for completions.
vim.opt.iskeyword:append("-")

-- Allows you to easily change the current word and all occurrences to something else.
map(
  "n",
  "<leader>cw",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace word (all)" }
)
map(
  "v",
  "<leader>cw",
  [[y:%s/<C-r>=escape(@", '/\\')<cr>/<C-r>=escape(@", '/\\')<cr>/gI<Left><Left><Left>]],
  { desc = "Replace selection (all)" }
)

-- Base64 encode/decode selection
map(
  "v",
  "<leader>e64",
  [[c<C-r>=substitute(system('base64 --wrap=0', @"), '\n\+$', '', '')<cr><esc>]],
  { silent = true, desc = "[E]ncode Base[64]" }
)
map(
  "v",
  "<leader>d64",
  [[c<C-r>=substitute(system('base64 --wrap=0 --decode', @"), '\n\+$', '', '')<cr><esc>]],
  { silent = true, desc = "[D]ecode Base[64]" }
)

-- URL encode/decode selection
map(
  "v",
  "<leader>eu",
  [[c<C-r>=system('python3 -c "import sys,urllib.parse;print(urllib.parse.quote(sys.stdin.read(),safe=\"\"),end=\"\")"', @")<cr><esc>]],
  { silent = true, desc = "[E]ncode [U]RL" }
)
map(
  "v",
  "<leader>du",
  [[c<C-r>=system('python3 -c "import sys,urllib.parse;print(urllib.parse.unquote(sys.stdin.read()),end=\"\")"', @")<cr><esc>]],
  { silent = true, desc = "[D]ecode [U]RL" }
)

-- Search for selected text in visual mode
map("v", "//", [[y/<C-R>=escape(@", '/\\')<CR><CR>]], { desc = "Search selection" })

-- Format json
map("n", "fj", "<cmd>%!jq .<cr>", { silent = true, desc = "Format JSON (jq)" })

-- Close all buffers except current
map("n", "<leader>bo", "<cmd>%bd|e#<cr>", { silent = true, desc = "[B]uffer: [O]nly" })

-- remove highlight
map("n", "<leader><space>", "<cmd>nohlsearch<cr>", { silent = true, desc = "Clear search highlight" })
