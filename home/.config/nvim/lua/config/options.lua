-- Remap space as leader key
vim.g.mapleader = " "

---- Searching and Moving
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.gdefault = true
--vim.opt.incsearch = true
--vim.opt.showmatch = true

--vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath('config') .. '/undo'

--vim.opt.pumheight = 10 -- pop up menu height
vim.opt.swapfile = false
vim.opt.smartindent = true
--vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.sidescrolloff = 10 -- how many lines to scroll when using the scrollbar
--vim.opt.autoindent = true
--vim.opt.signcolumn = "yes"
--vim.opt.sessionoptions = "buffers,curdir,folds,help,tabpages,terminal,globals"
---- vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.expandtab = true
--vim.opt.termguicolors = true
--vim.opt.updatetime = 100
--vim.opt.writebackup = false
vim.opt.number = true
--vim.opt.jumpoptions = "view"
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
--vim.opt.cmdheight = 0
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
--vim.opt.splitkeep = "screen"
---- vim.opt.syntax = "on"
--vim.opt.spelloptions = "camel,noplainbuffer"
--vim.opt.foldlevel = 99
--vim.o.foldcolumn = "1"
---- vim.o.foldlevelstart = 99
--vim.opt.foldmethod = "expr"
--vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
--vim.opt.foldenable = true
--vim.opt.fillchars = {
--  foldopen = "",
--  foldclose = "",
--  fold = " ",
--  foldsep = " ",
--  diff = "/",
--  eob = " ",
--}
--vim.opt.mousemoveevent = true

---- command completion
--vim.opt.wildmode = "longest:full:full"
--vim.opt.wildignore = "*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx,*DS_STORE,*.db"
