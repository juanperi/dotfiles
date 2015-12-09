" Juan Peri

" Settings {{{
" Vim Environment {{{
set nocompatible              " required
set modelines=0
filetype off                  " required
set t_Co=256
set modelines=1

let mapleader = "\<space>"

set shell=/bin/bash
set lazyredraw
set matchtime=3

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

if !has('mac') && exists("+clipboard")
  set clipboard=unnamedplus
endif

" Working with split screen nicely resize Split When the window is resized"
au VimResized * :wincmd =

"Make Sure that Vim returns to the same line when we reopen a file"
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \ execute 'normal! g`"zvzz' |
        \ endif
augroup END

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
set tags+=vendor.tags

set title " Set title to window
set dictionary=/usr/share/dict/words " Dictionary path, from which the words are being looked up.
set pastetoggle=<F3> " Make pasting done without any indentation break.
set mouse=a " Enable Mouse

"TAB settings.
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" More Common Settings.
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell

"set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2

"set relativenumber
set number
if v:version >= 703
    set norelativenumber
endif

"Settings for Searching and Moving
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>

" Make Vim to handle long lines nicely.
set wrap
set textwidth=79
set formatoptions=qrn1
" Long lines in diff mode also handled nicely
autocmd FilterWritePre * if &diff | setlocal wrap< | endif

" To  show special characters in Vim
set listchars=tab:▸\ ,eol:¬

" Get Rid of help keys
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Map : to ; also in command mode.
nnoremap ; :
" Insert ; at the end of the line
inoremap ;; <End>;<Esc>

",W Command to remove white space from a file.
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" ,ft Fold tag, helpful for HTML editing.
nnoremap <leader>ft vatzf

" ,q Re-hardwrap Paragraph
nnoremap <leader>q gqip

" ,v Select just pasted text.
nnoremap <leader>v V`]


" jj For Qicker Escaping between normal and editing mode.
inoremap jj <ESC>

" This method uses a command line abbreviation so %% expands to the full path of the directory that contains the current file.
" while editing file /some/path/myfile.txt, typing :e %%/ on the command line
" will expand to :e /some/path/
cabbr <expr> %% expand('%:p')

"This allows for change paste motion cp{motion}
nmap <silent> cp :set opfunc=ChangePaste<CR>g@
function! ChangePaste(type, ...)
   silent exe "normal! `[v`]\"_c"
   silent exe "normal! p"
endfunction

filetype plugin indent on

" }}}

" }}}

" Plugins {{{
" Start Setup Plugins{{{
call plug#begin('~/.vim/plugged')
" }}}

" CtrlP {{{
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_max_files = 0
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --skip-vcs-ignores --nocolor -g ""'
endif
" }}}
" Ag {{{
Plug 'rking/ag.vim'
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
" SimplePairs {{{
Plug 'vim-scripts/simple-pairs'
" }}}
" NerdCommenter {{{
Plug 'scrooloose/nerdcommenter'
" }}}
" Syntastic {{{
Plug 'scrooloose/syntastic'
" Syntastic disable style checkers
let g:syntastic_quiet_messages = { "type": "style" }
" }}}
" Tagbar {{{
Plug 'majutsushi/tagbar'
nmap <leader>l <ESC>:TagbarToggle<cr>
" }}}
" Fugitive {{{
Plug 'tpope/vim-fugitive'
nnoremap <leader>gs  :Gstatus<cr>
nnoremap <leader>ga  :Gwrite<cr>
nnoremap <leader>gc  :Gcommit --verbose<cr>
nnoremap <leader>grm :Gremove<cr>
nnoremap <leader>gmv :Gmove<cr>
nnoremap <leader>gp  :Gpush<cr>
" }}}
" Git Gutter {{{
Plug 'airblade/vim-gitgutter'
" }}}
" Supertab {{{
Plug 'ervandew/supertab'
" }}}
" UltiSnips {{{
if v:version >= 704
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<c-j>"
    let g:UltiSnipsJumpBackwardTrigger="<c-k>"
endif
" }}}
" Better Whitespace {{{
Plug 'ntpeters/vim-better-whitespace'
" }}}
" Indent guides {{{
Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=235
" }}}
" Airline {{{
Plug 'bling/vim-airline'
"let g:airline_section_b = '%{getcwd()}'
"let g:airline_section_c = '%t'
let g:airline#extensions#branch#displayed_head_limit = 15
let g:airline#extensions#tabline#fnamemod = ':p:.'
" }}}
" Mkdir {{{
Plug 'pbrisbin/vim-mkdir'
" }}}
" CoffeeScript {{{
Plug 'kchmck/vim-coffee-script'
Plug 'mustache/vim-mustache-handlebars'
" }}}
" Tabular {{{
Plug 'godlygeek/tabular'
nmap <Leader>t= :Tabularize /=/l1l0<CR>
vmap <Leader>t= :Tabularize /=/l1l0<CR>
nmap <Leader>t: :Tabularize /:\zs<CR>
vmap <Leader>t: :Tabularize /:\zs<CR>
" }}}
" Markdown {{{
Plug 'tpope/vim-markdown'
Plug 'kannokanno/previm' "Realtime preview Markdown, reStructuredText, textile
let g:previm_enable_realtime = 1
" }}}
" Yaml {{{
Plug 'stephpy/vim-yaml'
" }}}
" Open In Browser {{{
Plug 'tyru/open-browser.vim' "Open URI with your favorite browser
" }}}
" Javascript Syntax {{{
Plug 'jelera/vim-javascript-syntax'
" }}}
" Php Namespaces {{{
Plug 'arnaud-lb/vim-php-namespace'

"Import classes (add use statements)
noremap <Leader>nu :call PhpInsertUse()<CR>
" Make class names fully qualified
noremap <Leader>ne :call PhpExpandClass()<CR>
" }}}
" PHP Vim {{{
Plug 'StanAngeloff/php.vim'
Plug '2072/PHP-Indenting-for-VIm'
" }}}
" PHP Refactor {{{
Plug 'vim-php/vim-php-refactoring'
let g:php_refactor_command='php /usr/local/bin/refactor.phar'
" }}}
" Ruby {{{
Plug 'vim-ruby/vim-ruby'
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
" }}}
" Twig Templates {{{
Plug 'evidens/vim-twig'
" }}}
" Slim Templates {{{
Plug 'slim-template/vim-slim'
" }}}
" Vdebug {{{
Plug 'joonty/vdebug'
if !exists("g:vdebug_options")
    let g:vdebug_options={}
endif
let g:vdebug_options['break_on_open'] = 0
let g:vdebug_options['timeout'] = 40
let g:vdebug_options['server'] = "0.0.0.0"
" }}}
" Tests Runner {{{
Plug 'janko-m/vim-test'
let g:test#strategy = 'vimux'
nmap <silent> <leader>tt :TestNearest<CR>
nmap <silent> <leader>tT :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
" }}}
" BufOnly {{{
Plug 'duff/vim-bufonly'
" }}}
" Solarized Colors {{{
Plug 'altercation/vim-colors-solarized'
" }}}
" Tmux {{{
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'
let g:VimuxUseNearest = 1 "use nearest pane for output
let g:VimuxOrientation = 'h'
let g:VimuxHeight = "30"
" }}}
" Css - less {{{
Plug 'groenewege/vim-less'
" }}}
" Local Vimrc {{{
Plug 'embear/vim-localvimrc'
let g:localvimrc_persistent=2
" }}}
" Local Escape Ansi Colors {{{
Plug 'Improved-AnsiEsc'
" }}}
" Convert from/to snake and camel case {{{
Plug 'tpope/vim-abolish'
" }}}

" End Setup Plugins {{{
" Add plugins to &runtimepath
call plug#end()
" }}}
" }}}

" StartUp {{{
" FileTypes Config {{{
" Yaml {{{
autocmd FileType yaml setlocal autoindent shiftwidth=4 tabstop=4 expandtab
" }}}
" CoffeeScript {{{
autocmd BufRead,BufNewFile *.coffee setfiletype coffee
autocmd FileType coffee setlocal shiftwidth=2 tabstop=2 expandtab foldmethod=indent nofoldenable
" }}}
" Javascript {{{
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 expandtab foldmethod=indent nofoldenable
" }}}
" }}}
" Solarized Colors {{{
let g:solarized_termcolors=256
set background=dark
silent! colorscheme solarized
" }}}
" }}}

" vim:foldmethod=marker:foldlevel=1
