-- Better up/down
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Windows management
vim.keymap.set("n", "<leader>we", "<c-w>v<c-w>l")
vim.keymap.set("n", "<leader>ws", "<c-w>s<c-w>j")
vim.keymap.set("n", "<leader>wq", "<c-w>v<c-w>h")
vim.keymap.set("n", "<leader>w2", "<c-w>s<c-w>k")
vim.keymap.set("n", "<leader>wc", "<c-w>c")
vim.keymap.set("n", "<leader>wx", "<c-w>x")
vim.keymap.set("n", "<s-l>", "gt")
vim.keymap.set("n", "<s-h>", "gT")

-- Faster save
vim.keymap.set("n", "<leader>s", ":w<cr>")

-- escape insert mode
vim.keymap.set("i", "jj", "<ESC>")

-- make the dash be considered as part of a word. Useful for completions
vim.opt.iskeyword:append("-")


-- Allows you to easily change the current word and all occurrences to something else.
vim.keymap.set("n", "<leader>cw", ":%s/<C-r><C-w>/<C-r><C-w>")
vim.keymap.set("v", "<leader>cw", "y:%s/<C-r>\"/<C-r>\"")
-- Search for selected text in visual mode
vim.keymap.set("v", "//", "y/<C-R>=escape(@\",'/')<CR><CR>")

-- Format json
vim.keymap.set("n", "fj", ":%!jq .<CR>")

-- remove highlight
vim.keymap.set("n", "<leader><space>", ":nohlsearch<CR>")
