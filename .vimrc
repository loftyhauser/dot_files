set nocompatible        "Don't limit to vi
syntax on               "Synax highlighting
set ch=1
set viminfo='1,h
set ruler
set showmode
set showcmd
set hlsearch
set incsearch
set smartcase
set showmatch
set number
set wildmenu
filetype indent plugin on
filetype plugin on
set background=dark
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
"set nowrap
set exrc
set secure
set ignorecase smartcase
set termwinsize=12x0        " Set terminal size
set splitbelow              " Always split below
set mouse=a
set signcolumn=yes
"set t_Co=256
"colorscheme colorful256
set colorcolumn=110
highlight ColorColumn ctermbg=darkgray
set cursorline
highlight CursorLine cterm=NONE ctermbg=8 ctermfg=NONE

let mapleader=" "
"nnoremap <space> <nop>

call plug#begin()
Plug 'preservim/NERDTree'
Plug 'preservim/NERDcommenter'
Plug 'preservim/tagbar'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'igankevich/mesonic'
Plug 'sheerun/vim-polyglot'
Plug 'dyng/ctrlsf.vim'
Plug 'derekwyatt/vim-fswitch'
Plug 'derekwyatt/vim-protodef'
"Plug 'Yggdroot/indentLine'
"Plug 'matze/vim-move'
"Plug 'junegunn/fzf.vim'
Plug 'ycm-core/YouCompleteMe'
call plug#end()

map <F5> :NERDTreeToggle<CR>
let NERDTreeShowBookmarks = 1           " Show the bookmarks table
let NERDTReeShowHidden = 1              " Show hidden files
let NERDTreeShowLineNumbers = 0         " Hide line number
let NERDTreeMinimalMenu = 1             " Use the minimal menu (m)
let NERDTreeWinPos = "left"             " Panel opnes on the left side
let NERDTreeWinSize = 31                " Set panel width to 31 columns
let g:tagbar_autofocus = 1              " Focus the panel when opening it
let g:tagbar_autoshowtag = 1            " Highlight the active tag
let g:tagbar_position = 'botright vertical' "Make panel vertical and place on right
map <F8> :TagbarToggle<CR>
let g:AutoPairsShortcutToggle = '<C-P>' " Toggle autopairs with CTRL-P
let g:ctrlsf_backend = 'ack'            " Use the ack tool as the backend
let g:ctrlsf_auto_close = { "normal":0, "compact":0 } " Auto close the results panel when opening a file
let g:ctrlsf_auto_focus = { "at":"start" } " Immediately switch focus to the search window
let g:ctrlsf_auto_preview = 0           " Don't open the preview window automatically
let g:ctrlsf_case_sensitive = 'smart'   " Use the smart case sensitivity search scheme
let g:ctrlsf_default_view = 'normal'    " Not compact mode
let g:ctrlsf_regex_pattern = 0          " Use absolute search by default
let g:ctrlsf_position = 'right'         " Position the search window
let g:ctrlsf_winsize = 46               " Width or height of the search window
let g:ctrlsf_default_root = 'cwd'       " Search from the current working directory
" (Ctrl+F) Open search prompt (normal Mode)
nmap <C-F>f <Plug>CtrlSFPrompt
" (Ctrl-F + f) Open search prompt with selection (Visual Mode)
xmap <C-F>f <Plug>CtrlSFVwordPath
" (Ctrl-F + F) Perform search with selection (Visual Mode)
xmap <C-F>F <Plug>CtrlSFVwordExec
" (Ctrl-F + n) Open search prompt with current work (Normal Mode)
nmap <C-F>n <Plug>CtrlSFCwordPath
" (Ctrl-F + o) Open CtrlSF window (Normal Mode)
nnoremap <C-F>o :CtrlSFOpen<CR>
" (Ctrl-F + t) Toggle CtrlSF window (Normal Mode)
nnoremap <C-F>t :CtrlSFToggle<CR>
" (Ctrl-F + t) Toggle CtrlSF window (Insert Mode)
inoremap <C-F>t <Esc> :CtrlSFToggle<CR>
au! BufEnter *.cpp let b:fswitchdst = 'hpp,h' " Companion file is header
au! BufEnter *.hpp let b:fswitchdst = 'cpp,c' " Companion file is source
" split window and add companion file to the right
nmap <C-Z> :vsplit <bar> :wincmd l <bar> :FSRight<CR>
" Pull in prototypes
nmap <buffer> <silent> <leader> ,PP
" Pull in prottypes without namespace definition
nmap <buffer> <silent> <leader> ,PN
" Open vim-dispatch window and scroll to bottom
nnoremap <C-m>m :Copen<CR> <bar> G
" Build debug and release targets
nnoremap <C-m>bd :Dispatch! make -C build/Debug<CR>
nnoremap <C-m>br :Dispatch! make -C build/Release<CR>
let g:netrw_banner=0                    " disable annoying banner
let g:netrw_browse_split=4              " open in prior window
let g:netrw_altv=1                      " open splits to the right
let g:netrw_liststyle=3                 " tree view

"autocmd bufnewfile *.c so /home/alofthou/git/dot_files/c-header.txt
"autocmd bufnewfile *.h so /home/alofthou/git/dot_files/h-header.txt
"autocmd bufnewfile *.[ch] exe "1," . 10 . "g/File Name :.*/s//File Name : " .expand("%")
"autocmd bufnewfile *.[ch] exe "1," . 10 . "g/Creation Date :.*/s//Creation Date : " .strftime("%Y-%m-%d")
"autocmd bufwritepre,filewritepre *.[ch] execute "normal ma"
"autocmd bufwritepre,filewritepre *.[ch] exe "1," . 10 . "g/Last Modified :.*/s/Last Modified :.*/Last Modified : " .strftime("%a, %d %b %Y %H:%M:%S %z")
"autocmd bufwritepost,filewritepost *.[ch] execute "normal `a"

" From the YouTube video How to Do 90% of What Plugins Do (With Just Vim)
set path+=**               " Search through subfolders
set wildmenu               " Display all matching files when tab complete
" Create 'tags' file
" Use CTRL-] to jump to tag; g-CTRL-] for list of ambiguous matches, CTRL-t to return
command! MakeTags !exuberant-ctags -R *
