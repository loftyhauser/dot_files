" vim: foldmethod=marker

" Load vim-plug {{{
" Install vim plug if not installed
let data_dir = has('nvim') ? stdpath('config') : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif
" }}}

" VIM standard configuration {{{
syntax on
" We want everything to be utf-8
set encoding=utf-8
" - a: Automatically format paragraphs when typing. This option is off by default.
" - c: Automatically break comments using the textwidth value. This option is on by default.
" - l: Do not break lines that are already long when formatting. This option is off by default.
" - m: Automatically break the current line before inserting a new comment line when typing text
"   beyond textwidth. This option is off by default.
" - n: Recognize numbered lists. When hitting <Enter> in insert mode, the next line will have the
"   same or incremented number. This option is on by default.
" - o: Automatically insert the comment leader when hitting 'o' or 'O' in normal mode. This option
"   is on by default.
" - p: Preserve the existing formatting when using the gq command. This option is off by default.
" - q: Allow the use of gq to format comments. This option is on by default.
" - r: Automatically insert the comment leader when hitting <Enter> in insert mode. This option is
"   on by default.
" - t: Automatically wrap text using textwidth when typing. This option is off by default.
" - v: In visual mode, when using the gq command, break lines at a blank character instead of a
"   blank space. This option is off by default.
" - w: Recognize only whitespace when breaking lines with gq. This option is off by default.
set formatoptions=cronm
" This sets the width of a tab character to 2 spaces.
set tabstop=4
" This sets the number of spaces used when the <Tab> key is pressed in insert mode to 4.
set softtabstop=4
" This sets the number of spaces used for each indentation level when using
" the '>' and '<' commands, as well as the autoindent feature.
set shiftwidth=4
" This setting enables automatic indentation, which will copy the indentation
" of the current line when starting a new line.
set autoindent
" This enables the automatic conversion of tabs to spaces when you press the
" <Tab> key.
set expandtab
" This enables the use of the mouse in all modes (normal, visual, insert,
" command-line, etc.).
set mouse=a
" This displays line numbers in the left margin.
set number
" This disables the creation of backup files.
set nobackup
" This disables the creation of swap files.
set noswapfile
" Automatically reload files when they change
set autoread
" Enable spell checking
set spell
set spelllang=en
" Highlight the current line
set cursorline
" Show white space characters and tab characters
set list
" Configure how nonprintable characters should be displayed
set listchars=tab:>-,trail:•
" Highlight the 100th column
set colorcolumn=80
" Set text width
set textwidth=80
" Set signcolumn to be expandable
set signcolumn=auto:2
" Use system clipboard
set clipboard=unnamedplus

"set smartindent

" This maps the '<' and '>' keys in visual mode to shift the selected text one
" shift width to the left or right and reselect the shifted text.
vnoremap < <gv
vnoremap > >gv

" The next four lines define key mappings for switching between windows using
" Ctrl + hjkl keys
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" The next four lines define key mappings for resizing windows using Alt +
" hjkl keys:
map <a-l> :vertical res -5<CR>
map <a-h> :vertical res +5<CR>
map <a-j> :res -5<CR>
map <a-k> :res +5<CR>

" These lines define key mappings for moving the cursor vertically more quickly
nnoremap <S-h> 5h
vnoremap <S-h> 5h
nnoremap <S-l> 5l
vnoremap <S-l> 5l
nnoremap <S-j> 5j
vnoremap <S-j> 5j
nnoremap <S-k> 5k
vnoremap <S-k> 5k

" Map r to redo
nmap r :redo<CR>

" Enable folding
set foldenable
" Configure fold method
" - indent (bigger the indent is - larger the fold level; works quite well for many programming
"   languages)
" - syntax (folding is defined in the syntax files)
" - marker (looks for markers in the text; everything within comments foldable block {{{ and }}} is
"   a fold)
" - expr (fold level is calculated for each line by providing a special function)
set foldmethod=marker
" Set the fold level to start with all folds open
set foldlevelstart=99
" Set the fold nesting level (default is 20)
set foldnestmax=10
" Automatically close folds when the cursor leaves them
set foldclose=
" Open folds upon all motion events
set foldopen=
" Do not automatically adjust width of vertical splits
set noequalalways
" Our default format for compiler errors is gcc
compiler gcc
" }}}

" Load vim plugins {{{
call plug#begin()
    Plug 'olimorris/onedarkpro.nvim'
    Plug 'nvim-tree/nvim-web-devicons'
    Plug 'akinsho/bufferline.nvim', { 'tag': 'v4.9.1' } " plugin for tab line at the top
    Plug 'catppuccin/nvim', { 'as': 'catppuccin' } " a beautiful color scheme
call plug#end()
" }}}
colorscheme onedark
