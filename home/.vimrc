" Juan Peri

" Settings {{{
" Vim Environment {{{

let mapleader = "\<space>"

set lazyredraw

" viminfo stores the the state of your previous editing session
if isdirectory($HOME . '/.vim/tmp') == 0
  :silent !mkdir -p ~/.vim/tmp >/dev/null 2>&1
endif
set viminfo+=n~/.vim/tmp/viminfo

"disable backups and swapfile
set nobackup
set nowritebackup
set noswapfile

" ,ev Shortcut to edit .vimrc file on the fly on a vertical window.
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backups, uses .vim-undo first, then ~/.vim/tmp/undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/.vim/tmp/undo') == 0
    :silent !mkdir -p ~/.vim/tmp/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim/tmp/undo//
  set undofile
endif

" }}}

" Vim Moving Around {{{
" Disabling default keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" windows management
nnoremap <leader>we <c-w>v<c-w>l
nnoremap <leader>ws <c-w>s<c-w>j
nnoremap <leader>wq <c-w>v<c-w>h
nnoremap <leader>w2 <c-w>s<c-w>k
nnoremap <leader>wc <c-w>c
nnoremap <c-x> <c-w>x
" }}}

" Vim Editing {{{
set pastetoggle=<F3> " Make pasting done without any indentation break.
set number
set norelativenumber
set mouse=a

"Faster save
noremap <leader>s :w<cr>

"Settings for Searching and Moving
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <silent> <leader><space> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

" Make Vim to handle long lines nicely.
"set wrap
"set textwidth=79
"set formatoptions=qrn1
set synmaxcol=200 " do not syntax highlight lines longer than 200 chars
"" Long lines in diff mode also handled nicely
"autocmd FilterWritePre * if &diff | setlocal wrap< | endif

" remove trailing whitespaces when saving
autocmd BufWritePre * :%s/\s\+$//e

" To  show special characters in Vim
set listchars=tab:▸-
set list!

" ,v Select just pasted text.
"nnoremap <leader>v V`]

" jj For Quicker Escaping between normal and editing mode.
inoremap jj <ESC>

" make the dash be considered as part of a word. Useful for completions
set iskeyword+=-

" Allows you to easily change the current word and all occurrences to something else.
nnoremap <Leader>cw :%s/\<<C-r><C-w>\>/<C-r><C-w>
vnoremap <Leader>cw y:%s/<C-r>"/<C-r>"
" search for selected text in visual mode
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" Inserts date, time or datetime
nnoremap <Leader>id "=strftime("%Y-%m-%d")<CR>P
nnoremap <Leader>idt "=strftime("%Y-%m-%d %H:%M:%S")<CR>P
nnoremap <Leader>it "=strftime("%H:%M:%S")<CR>P
" }}}

" Autocomplete {{{
" }}}

" Plugins {{{
" Start Setup Plugins {{{
call plug#begin('~/.vim/plugged')
" }}}

" vim-sensible {{{
Plug 'tpope/vim-sensible'
" }}}
" show ansi colors {{{
"Plug 'powerman/vim-plugin-AnsiEsc'
" }}}
" Replace text without overwriting register {{{
Plug 'vim-scripts/ReplaceWithRegister'
" }}}
" Toggle single line arguments to multiline {{{
Plug 'FooSoft/vim-argwrap'
nnoremap <leader>aw :ArgWrap<cr>
" }}}
" Surround. Manage surrownding of targets in pairs{{{
"Plug 'tpope/vim-surround'
" }}}
" Surround. Manage surrownding of targets in pairs{{{
let g:VimTodoListsDatesEnabled = 1
let g:VimTodoListsDatesFormat = "%Y-%m-%d %H:%M"
Plug 'aserebryakov/vim-todo-lists'
" }}}
" fzf {{{
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all --no-update-rc' }
Plug 'junegunn/fzf.vim'
let $FZF_DEFAULT_COMMAND= 'ag -g ""'
let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
nnoremap <c-p> :FZF<cr>
" }}}
" Ag {{{
Plug 'rking/ag.vim'
" Search word under cursor
nnoremap F :Ag<CR>
if executable('ag')
  let g:ag_prg='ag -S --nocolor --nogroup --column --ignore "./tags" --ignore "./public/stylesheets/*" --ignore "./tags.vendor" --ignore "./app/cache" --ignore "./app/logs"'
endif
" }}}
" NerdTree {{{
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
nmap <leader>n <ESC>:NERDTreeToggle<cr>
nmap <leader>nf <ESC>:NERDTreeFind<cr>
let NERDTreeIgnore=['\^.vim$', '\~$', '\.pyc$']
" }}}
" UndoTree {{{
Plug 'mbbill/undotree'
nnoremap <leader>u :UndotreeToggle<cr>
" }}}
" NerdCommenter {{{
Plug 'scrooloose/nerdcommenter'
"" }}}
" Dispatch. Async dispatch used on fugitive {{{
Plug 'tpope/vim-dispatch'
" }}}
" Fugitive {{{
Plug 'tpope/vim-fugitive'
nnoremap <leader>gs  :Gstatus<cr>
nnoremap <leader>gc  :Gcommit --verbose<cr>
nnoremap <leader>gp  :Gpush<cr>
autocmd BufReadPost fugitive://* set bufhidden=delete
" }}}
" Git Gutter {{{
Plug 'airblade/vim-gitgutter'
" }}}
" Git Log {{{
Plug 'junegunn/gv.vim'
" }}}
"" Indent guides {{{
"Plug 'nathanaelkane/vim-indent-guides'
"let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_auto_colors = 1
"let g:indent_guides_guide_size = 1
"let g:indent_guides_start_level = 2
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=None
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=235
"" }}}
" Airline {{{
"Plug 'bling/vim-airline'
"let g:airline_section_b = '%{getcwd()}'
"let g:airline_section_c = '%t'
"let g:airline#extensions#branch#displayed_head_limit = 15
"let g:airline#extensions#tabline#fnamemod = ':p:.'
" }}}
" Markdown {{{
" Syntax {{{
Plug 'tpope/vim-markdown'
" }}}
" Preview {{{
Plug 'kannokanno/previm' "Realtime preview Markdown, reStructuredText, textile
let g:previm_enable_realtime = 1
" }}}
" }}}
" Yaml {{{
Plug 'stephpy/vim-yaml'
" }}}
" Open In Browser {{{
Plug 'tyru/open-browser.vim' "Open URI with your favorite browser
nmap <leader>ob <Plug>(openbrowser-open)
vmap <leader>ob <Plug>(openbrowser-open)
" }}}
" PHP {{{
"" Namespaces {{{
"Plug 'arnaud-lb/vim-php-namespace'
""Import classes (add use statements)
"noremap <Leader>nu :call PhpInsertUse()<CR>
"" Make class names fully qualified
"noremap <Leader>ne :call PhpExpandClass()<CR>
"" }}}
" Sintax {{{
Plug 'StanAngeloff/php.vim', { 'for': 'php' }
Plug '2072/PHP-Indenting-for-VIm', { 'for': 'php' }
" }}}
"" PHP Refactor {{{
"Plug 'vim-php/vim-php-refactoring'
"let g:php_refactor_command='php /usr/local/bin/refactor.phar'
"" }}}
"" Vdebug {{{
"Plug 'joonty/vdebug', { 'for': 'php' }
"if !exists("g:vdebug_options")
    "let g:vdebug_options={}
"endif
"let g:vdebug_options['break_on_open'] = 0
"let g:vdebug_options['timeout'] = 40
"let g:vdebug_options['server'] = "0.0.0.0"
"" }}}
" }}}
" Ruby {{{
" Sintax {{{
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
" }}}
" End blocks automatically {{{
Plug 'tpope/vim-endwise'
" }}}
" Slim Templates {{{
Plug 'slim-template/vim-slim', { 'for': 'slim' }
" }}}
" Rubocop {{{
Plug 'kagux/vim-rubocop-autocorrect', { 'for': 'ruby' }
" }}}
" }}}
" Elixir {{{
" Syntax {{{
Plug 'elixir-editors/vim-elixir'
" }}}
" Autocompletion {{{
"let g:elixirls = {
  "\ 'path': printf('%s/%s', stdpath('config'), 'plugged/elixir-ls'),
  "\ }

"let g:elixirls.lsp = printf(
  "\ '%s/%s',
  "\ g:elixirls.path,
  "\ 'release/language_server.sh')

"function! g:elixirls.compile(...)
  "let l:commands = join([
    "\ 'mix local.hex --force',
    "\ 'mix local.rebar --force',
    "\ 'mix deps.get',
    "\ 'mix compile',
    "\ 'mix elixir_ls.release'
    "\ ], '&&')

  "echom '>>> Compiling elixirls'
  "silent call system(l:commands)
  "echom '>>> elixirls compiled'
"endfunction

"Plug 'elixir-lsp/elixir-ls', { 'do': { -> g:elixirls.compile() } }
" }}}
" }}}
" Tests Runner {{{
Plug 'janko-m/vim-test'
let g:test#strategy = 'vimux'
nmap <silent> <leader>tt :w<CR>:TestNearest<CR>
nmap <silent> <leader>tT :w<CR>:TestFile<CR>
nmap <silent> <leader>ta :w<CR>:TestSuite<CR>
nmap <silent> <leader>tl :w<CR>:TestLast<CR>
" }}}
" BufOnly {{{
Plug 'duff/vim-bufonly'
" }}}
" Color Theme:  gruvbox {{{
Plug 'morhetz/gruvbox'
" }}}
" Tmux {{{
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'
let g:VimuxUseNearest = 1 "use nearest pane for output
let g:VimuxOrientation = 'h'
let g:VimuxHeight = "30"
" }}}
"" Css - less {{{
"Plug 'groenewege/vim-less'
"" }}}
" Local Vimrc {{{
Plug 'embear/vim-localvimrc'
let g:localvimrc_persistent=2
" }}}
" Convert from/to snake and camel case {{{
Plug 'tpope/vim-abolish'
" }}}
" Auto read files {{{
Plug 'djoshea/vim-autoread'
" }}}
" highlight movement targets on line {{{
"Plug 'unblevable/quick-scope'
" }}}
"" Format SQL {{{
"Plug 'vim-scripts/SQLUtilities'
"Plug 'vim-scripts/Align'
"" }}}
" Base64 encode/decode {{{
Plug 'christianrondeau/vim-base64'
" }}}
"" language server protocol {{{
"Plug 'prabirshrestha/vim-lsp'
"" }}}

" End Setup Plugins {{{
" Add plugins to &runtimepath
call plug#end()
" }}}
" }}}

" StartUp {{{
" FileTypes Config {{{
" Generic {{{
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
" }}}
" Theme config  {{{
if !has("gui_running")
  let g:gruvbox_italic=0
endif
set background=dark
silent! colorscheme gruvbox
highlight Normal ctermbg=None
" }}}
" }}}

" vim:foldmethod=marker:foldlevel=1
