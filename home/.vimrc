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
nnoremap j gj
nnoremap k gk

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
set relativenumber

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
"set synmaxcol=200 " do not syntax highlight lines longer than 200 chars
"" Long lines in diff mode also handled nicely
"autocmd FilterWritePre * if &diff | setlocal wrap< | endif

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
" }}}

" Autocomplete {{{
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType eco set omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

" autocomplete to longest common mantch and show even if there is only one option
set completeopt=menuone,longest

inoremap <expr> <C-j> ((pumvisible())?("\<C-n>"):("\<C-j>"))
inoremap <expr> <C-k> ((pumvisible())?("\<C-p>"):("\<C-k>"))
" }}}

" }}}
" Plugins {{{
" Start Setup Plugins {{{
call plug#begin('~/.vim/plugged')
" }}}

" vim-sensible {{{
Plug 'tpope/vim-sensible'
" }}}
" highlight tabs and trailing spaces {{{
Plug 'jpalardy/spacehi.vim'
" }}}
" Replace text without overwriting register {{{
Plug 'vim-scripts/ReplaceWithRegister'
" }}}
" Toggle single line arguments to multiline {{{
Plug 'FooSoft/vim-argwrap'
nnoremap <leader>aw :ArgWrap<cr>
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
" Execute commands on quickfix files {{{
Plug 'henrik/vim-qargs'
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
" Neomake {{{
if has('nvim')
  Plug 'benekastah/neomake'
  autocmd! BufWritePost * Neomake
endif
" }}}
"" Tagbar {{{
"Plug 'majutsushi/tagbar'
"nmap <leader>l <ESC>:TagbarToggle<cr>
"" }}}
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
" Deoplete autocomplete {{{
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : deoplete#mappings#manual_complete()
inoremap <expr> <C-j> ((pumvisible())?("\<C-n>"):("\<C-j>"))
inoremap <expr> <C-k> ((pumvisible())?("\<C-p>"):("\<C-k>"))
" }}}
" Lint Trailing Whitespace {{{
Plug 'ntpeters/vim-better-whitespace'
",W Command to remove white space from a file.
nnoremap <leader>W :StripWhitespace<CR>
" }}}
" Indent guides {{{
Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=236
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=235
" }}}
"" Airline {{{
"Plug 'bling/vim-airline'
""let g:airline_section_b = '%{getcwd()}'
""let g:airline_section_c = '%t'
"let g:airline#extensions#branch#displayed_head_limit = 15
"let g:airline#extensions#tabline#fnamemod = ':p:.'
"" }}}
"" Mkdir {{{
"Plug 'pbrisbin/vim-mkdir'
"" }}}
"" CoffeeScript {{{
"Plug 'kchmck/vim-coffee-script'
"Plug 'mustache/vim-mustache-handlebars'
"" }}}
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
" }}}
"" Javascript Syntax {{{
"Plug 'jelera/vim-javascript-syntax'
"" }}}
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
" Vdebug {{{
Plug 'joonty/vdebug', { 'for': 'php' }
if !exists("g:vdebug_options")
    let g:vdebug_options={}
endif
let g:vdebug_options['break_on_open'] = 0
let g:vdebug_options['timeout'] = 40
let g:vdebug_options['server'] = "0.0.0.0"
" }}}
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
Plug 'elixir-lang/vim-elixir', { 'for': 'elixir' }
" }}}
" Autocompletion {{{
Plug 'slashmili/alchemist.vim'
" }}}
" }}}
"" Golang {{{
"Plug 'fatih/vim-go'
"" }}}
"" Twig Templates {{{
"Plug 'evidens/vim-twig'
"" }}}
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
Plug 'unblevable/quick-scope'
" }}}
"" Format SQL {{{
"Plug 'vim-scripts/SQLUtilities'
"Plug 'vim-scripts/Align'
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
" }}}
" }}}

" vim:foldmethod=marker:foldlevel=1
