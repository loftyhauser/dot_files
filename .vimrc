" Load vim-plug {{{
" Install vim plug if not installed
let data_dir = has('nvim') ? stdpath('config') : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif
" }}}

" VIM standard configuration {{{
" set nocompatible        "Don't limit to vi
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
" This sets the width of a tab character to 4 spaces.
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
" set spell
" set spelllang=en
" Highlight the current line
set cursorline
" Show white space characters and tab characters
set list
" Configure how nonprintable characters should be displayed
set listchars=tab:>-,trail:•
" Highlight the 100th column
set colorcolumn=100
" Set text width
set textwidth=100
" Set signcolumn to be expandable
set signcolumn=auto
" Use system clipboard
set clipboard=unnamedplus
" Set the command height to 1
set cmdheight=1
" Save last 100 marks but not highlighted search pattersn
set viminfo='1,h
" Show line and column number
set ruler
" Show the type of mode
set showmode
" Show command in last line of screen
set showcmd
" Highlight search matches
set hlsearch
" Incrementally highlight search patterns
set incsearch
" Ignore case for search patterns
set ignorecase
" Override ignore case if the search pattern contains upper case chars
set smartcase
" Show matching brackets
set showmatch
" " --------------------------------------------------------------------------------
" " How to do 90% of What Plugins Do (With Just Vim)
" " --------------------------------------------------------------------------------
" 
" set exrc                    " Execute a vimrc in project folder
" set secure                  " Don't execute dangerous commands
" set path+=**                " Search through subfolders
" 
set wildmenu
" set autoindent
set smartindent
" set nowrap
" if exists('+termwinsize')
" set termwinsize=12x0        " Set terminal size
" endif
" set splitbelow              " Always split below
set updatetime=100          " Updates every 100ms
set background=dark
" set foldmethod=syntax
" au BufRead,BufNewFile *.bdf set filetype=nastran
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

" Map rd to redo
nmap rd :redo<CR>

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
set foldlevelstart=0
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
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'jiangmiao/auto-pairs'
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
call plug#end()
" }}}

" Update all plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
	\| :PlugInstall --sync
\| endif

" Plugin: airblade/vim-gitgutter {{{
if has_key(plugs, 'vim-gitgutter')
    let g:gitgutter_enabled = 1
    let g:gitgutter_sign_added = '+'
    let g:gitgutter_sign_modified = '>'
    let g:gitgutter_sign_removed = '-'
    let g:gitgutter_sign_removed_first_line = '^'
    let g:gitgutter_sign_modified_removed = '<'
    nmap <Leader>gs <Plug>(GitGutterStageHunk)
    nmap <Leader>gu <Plug>(GitGutterUndoHunk)
    nmap <Leader>gn <Plug>(GitGutterNextHunk)
    nmap <Leader>gp <Plug>(GitGutterPrevHunk)
    nmap <Leader>gh <Plug>(GitGutterPreviewHunk)
    function! GitStatus()
        let [a,m,r] = GitGutterGetHunkSummary()
        return printf('+%d ~%d -%d', a, m, r)
    endfunction
    set statusline+=%{GitStatus()}
endif
" }}}

" Plugin: tpope/vim-fugitive {{{
" Open git status in interative window (similar to lazygit)
nnoremap <Leader>gg :Git<CR>

" Show `git status output`
nnoremap <Leader>gi :Git status<CR>

" Open commit window (creates commit after writing and saving commit msg)
nnoremap <Leader>gc :Git commit<CR>

" See who committed a particular line of code
nnoremap <Leader>gb :Git blame<CR>

" Other tools from fugitive
nnoremap <Leader>gd :Git difftool<CR>
nnoremap <Leader>gm :Git mergetool<CR>
nnoremap <Leader>gdv :Gvdiffsplit<CR>
nnoremap <Leader>gdh :Gdiffsplit<CR>

" Add the entire file to the staging area
nnoremap <Leader>gaf :Gw<CR> " git add file
" }}}

" 
" " Other
" Plug 'preservim/NERDTree'
" Plug 'preservim/NERDcommenter'
" Plug 'preservim/tagbar'
" Plug 'tpope/vim-dispatch'
" Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-unimpaired'
" Plug 'igankevich/mesonic'
" Plug 'sheerun/vim-polyglot'
" Plug 'dyng/ctrlsf.vim'
" Plug 'kien/ctrlp.vim'
" "Plug 'derekwyatt/vim-fswitch'
" "Plug 'derekwyatt/vim-protodef'
" "Plug 'Yggdroot/indentLine'
" "Plug 'matze/vim-move'
" "Plug 'junegunn/fzf.vim'
" "Plug 'ycm-core/YouCompleteMe'
" Plug 'cdelledonne/vim-cmake'
" "Plug 'ilyachur/cmake4vim'
" call plug#end()
" filetype indent plugin on
" 
" " ------------------------------------------------------------
" " THEME CONFIGURATION
" " ------------------------------------------------------------
" 
" set background=dark     " Set background 
" "set t_Co=256
" "colorscheme colorful256
" set colorcolumn=120
" highlight ColorColumn ctermbg=darkgray
" set cursorline
" highlight CursorLine cterm=NONE ctermbg=8 ctermfg=NONE
" 
" " ------------------------------------------------------------
" " AUTO-PAIRS
" " ------------------------------------------------------------
" 
" let g:AutoPairsShortcutToggle = '<C-P>' " Toggle autopairs with CTRL-P
" 
" " ------------------------------------------------------------
" " NERDTREE
" " ------------------------------------------------------------
" 
" let NERDTreeShowBookmarks = 1               " Show the bookmarks table
" let NERDTReeShowHidden = 1                  " Show hidden files
" let NERDTreeShowLineNumbers = 0             " Hide line number
" let NERDTreeMinimalMenu = 1                 " Use the minimal menu (m)
" let NERDTreeWinPos = "left"                 " Panel opnes on the left side
" let NERDTreeWinSize = 31                    " Set panel width to 31 columns
" 
" " ------------------------------------------------------------
" " TAGBAR
" " ------------------------------------------------------------
" 
" let g:tagbar_autofocus = 1                  " Focus the panel when opening it
" let g:tagbar_autoshowtag = 1                " Highlight the active tag
" let g:tagbar_position = 'botright vertical' "Make panel vertical and place on right
" 
" " ------------------------------------------------------------
" " CTRLSF
" " Requires ack to be installed
" " ------------------------------------------------------------
" 
" let g:ctrlsf_backend = 'ack'                " Use the ack tool as the backend
" let g:ctrlsf_auto_close = { "normal":0, "compact":0 } " Auto close the results panel when opening a file
" let g:ctrlsf_auto_focus = { "at":"start" }  " Immediately switch focus to the search window
" let g:ctrlsf_auto_preview = 0               " Don't open the preview window automatically
" let g:ctrlsf_case_sensitive = 'smart'       " Use the smart case sensitivity search scheme
" let g:ctrlsf_default_view = 'normal'        " Not compact mode
" let g:ctrlsf_regex_pattern = 0              " Use absolute search by default
" let g:ctrlsf_position = 'right'             " Position the search window
" let g:ctrlsf_winsize = 46                   " Width or height of the search window
" let g:ctrlsf_default_root = 'cwd'           " Search from the current working directory
" 
" " ------------------------------------------------------------
" " mesonic
" " ------------------------------------------------------------
" 
" let b:meson_command = './meson.py'
" let b:meson_ninja_command = './ninja'
" 
" " ------------------------------------------------------------
" " FSWITCH
" " ------------------------------------------------------------
" "
" " Set fswtichdst and fswitchloc variables with BufEnter event takes place
" " on a file whose name matches {*.cpp}.
" "
" " au! BufEnter *.cpp let b:fswitchdst = 'hpp,h' | let b:fswitchlocs = '../inc'
" 
" "au! BufEnter *.cpp let b:fswitchdst = 'hpp,h'
" "au! BufEnter *.hpp let b:fswitchdst = 'cpp,c'
" "au! BufEnter *.c   let b:fswitchdst = 'h'
" "au! BufEnter *.h   let b:fswitchdst = 'c'
" 
" " fswitchdst  - Denotes the files extensions that is the target extension of
" "               the current file's companion file.
" "
" " fswitchlocs - Contains a set of directories that indicate directory names 
" "               that should be formulated when trying to find the alternate
" "               file.
" 
" " ------------------------------------------------------------
" " VIM-PROTODEF
" " ------------------------------------------------------------
" 
" " Pull in prototypes
" "nmap <buffer> <silent> <leader> ,PP
" " Pull in prottypes without namespace definition
" "nmap <buffer> <silent> <leader> ,PN
" 
" " NOTE: This doesn't seem to disable the sorting.
" "let g:disable_protodef_sorting = 1
" 
" " ------------------------------------------------------------
" " YCM
" " ------------------------------------------------------------
" 
" " Mapping to close the completion menu (default <C-y>)
" let g:ycm_key_list_stop_completion = ['<C-x>']
" 
" " Set filetypes where YCM will be turned on
" let g:ycm_filetype_whitelist = { 'cpp':1, 'h':2, 'hpp':3, 'c':4, 'cxx':5 }
" 
" " Close preview window after completing the insertion
" let g:ycm_autoclose_preview_window_after_insertion = 1
" let g:ycm_autoclose_preview_window_after_completion = 1
" 
" let g:ycm_confirm_extra_conf = 0                " Don't confirm python conf
" let g:ycm_always_populate_location_list = 1     " Always populae diagnostics list
" let g:ycm_enable_diagnostic_signs = 1           " Enable line highligting diagnostics
" let g:ycm_open_loclist_on_ycm_diags = 1         " Open location list to view diagnostics
" 
" let g:ycm_max_num_candidates = 20               " Max number of completion suggestions 
" let g:ycm_max_num_identifier_candidates = 10    " Max number of identifier-based suggestions
" let g:ycm_auto_trigger = 1                      " Enable completion menu
" let g:ycm_show_diagnostic_ui = 1                " Show diagnostic display features
" let g:ycm_error_symbol = '>>'                   " The error symbol in Vim gutter
" let g:ycm_enable_diagnostic_signs = 1           " Display icons in Vim's gutter, error, warnings
" let g:ycm_enable_diagnostic_highlighting = 1    " Highlight regions of diagnostic text
" let g:ycm_echo_current_diagnostic = 1           " Echo line's diagnostic that cursor is on
" 
" " ------------------------------------------------------------
" " CMAKE
" " ------------------------------------------------------------
" 
" "let g:cmake_log_file = "/home/alofthou/vim-cmake.log"
" 
" " ------------------------------------------------------------
" " AIRLINE
" " ------------------------------------------------------------
" 
" let g:airline#extensions#tabline#enabled = 1
" 
" " ------------------------------------------------------------
" " FUGITIVE
" " ------------------------------------------------------------
" 
" 
" " ------------------------------------------------------------
" " VIM SETTINGS
" " ------------------------------------------------------------
" 
" 
" " ------------------------------------------------------------
" " MAPPINGS
" " ------------------------------------------------------------
" 
" 
" "General
" let mapleader=" "
" "nnoremap <space> <nop>
" "nmap        <C-B>     :buffers<CR>
" "nmap        <C-J>     :term<CR>
" 
" "NERDTree
" "map <F5> :NERDTreeToggle<CR>
" 
" "tagbar
" map <F8> :TagbarToggle<CR>
" 
" "ctrlfs
" " (Ctrl+F) Open search prompt (normal Mode)
" nmap <C-F>f <Plug>CtrlSFPrompt
" " (Ctrl-F + f) Open search prompt with selection (Visual Mode)
" xmap <C-F>f <Plug>CtrlSFVwordPath
" " (Ctrl-F + F) Perform search with selection (Visual Mode)
" xmap <C-F>F <Plug>CtrlSFVwordExec
" " (Ctrl-F + n) Open search prompt with current work (Normal Mode)
" nmap <C-F>n <Plug>CtrlSFCwordPath
" " (Ctrl-F + o) Open CtrlSF window (Normal Mode)
" nnoremap <C-F>o :CtrlSFOpen<CR>
" " (Ctrl-F + t) Toggle CtrlSF window (Normal Mode)
" nnoremap <C-F>t :CtrlSFToggle<CR>
" " (Ctrl-F + t) Toggle CtrlSF window (Insert Mode)
" inoremap <C-F>t <Esc> :CtrlSFToggle<CR>
" 
" "fswitch
" " split window and add companion file to the right
" "nmap <C-Z> :vsplit <bar> :wincmd l <bar> :FSRight<CR>
" 
" "YCM
" nmap        <C-L>     :lopen<CR>
" nmap        <C-L>l    :lclose<CR>
" 
" " --------------------------------------------------------------------------------
" " BUILD SYSTEM
" " --------------------------------------------------------------------------------
" 
" " Vim settings
" " --------------------------------------
" 
" " Always render sign column so editor doesn't snap when there's a YCM error
" "set signcolumn=yes
" 
" " Mappings
" " --------------------------------------
" 
" " Open vim-dispatch window and scroll to bottom
" "nnoremap    <C-m>m    :Copen<CR> <bar> G
" 
" " Build debug and release targets
" "nnoremap    <C-m>bd   :Dispatch! make -C build/Debug<CR>
" "nnoremap    <C-m>br   :Dispatch! make -C build/Release<CR>
" 
" " Functions
" " ---------------------------------------
" 
" " Map <F6> to the Debug executable with passed filename
" "function SetBinaryDebug(filename)
" "    let bpath = getcwd() . "/bin/Debug/" . a:filename
" "    execute "nnoremap <F6> :Dispatch "
" "            \ bpath
" "            \ . " <CR> <bar> :Copen<CR>"
" "    echo "<F6> will run: " . bpath
" "endfunction
" 
" " Map <F7> to the Release executable with passed filename
" "function SetBinaryRelease(filename)
" "    let bpath = getcwd() . "/bin/Release/" . a:filename 
" "    execute "nnoremap <F7> :Dispatch "
" "                \ bpath 
" "                \ . "<CR> <bar> :Copen<CR>"
" "    echo "<F7> will run: " . bpath
" "endfunction
" 
" 
" " ------------------------------------------------------------
" " NETRW
" " ------------------------------------------------------------
" 
" let g:netrw_banner=0                    " disable annoying banner
" let g:netrw_browse_split=4              " open in prior window
" let g:netrw_altv=1                      " open splits to the right
" let g:netrw_liststyle=3                 " tree view
" 
" " Create 'tags' file
" " Use CTRL-] to jump to tag; g-CTRL-] for list of ambiguous matches, CTRL-t to return
" command! MakeTags !exuberant-ctags -R *
" 
" au BufRead,BufNewFile *.F90         setfiletype fortran
" au BufRead,BufNewFile *.F95         setfiletype fortran
" au BufRead,BufNewFile *.F           setfiletype fortran
" " --------------------------------------------------------------------------------
" " Old stuff
" " --------------------------------------------------------------------------------
" "
" "autocmd bufnewfile *.c so /home/alofthou/git/dot_files/c-header.txt
" "autocmd bufnewfile *.h so /home/alofthou/git/dot_files/h-header.txt
" "autocmd bufnewfile *.[ch] exe "1," . 10 . "g/File Name :.*/s//File Name : " .expand("%")
" "autocmd bufnewfile *.[ch] exe "1," . 10 . "g/Creation Date :.*/s//Creation Date : " .strftime("%Y-%m-%d")
" "autocmd bufwritepre,filewritepre *.[ch] execute "normal ma"
" "autocmd bufwritepre,filewritepre *.[ch] exe "1," . 10 . "g/Last Modified :.*/s/Last Modified :.*/Last Modified : " .strftime("%a, %d %b %Y %H:%M:%S %z")
" "autocmd bufwritepost,filewritepost *.[ch] execute "normal `a"
