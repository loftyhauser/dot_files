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
" This disables the automatic conversion of tabs to spaces when you press the
" <Tab> key.
set noexpandtab
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
" Set the fold level to start with all folds close
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
    "Plug 'olimorris/onedarkpro.nvim'
    "Plug 'nvim-tree/nvim-web-devicons'
    "Plug 'jreybert/vimagit'
    "Plug 'tpope/vim-rhubarb'
	" Plug 'airblade/vim-gitgutter'
	Plug 'akinsho/bufferline.nvim', { 'tag': 'v4.9.0' } " plugin for tab line at the top
	Plug 'catppuccin/nvim', { 'as': 'catppuccin' } " a beautiful color scheme
	Plug 'dense-analysis/ale' " linting and fixing code.
	Plug 'lewis6991/gitsigns.nvim' " text buffer Git integration.
	Plug 'neovim/nvim-lspconfig' " Language Server Protocol Config
	Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' } " File explorer
	Plug 'tpope/vim-fugitive' " Git integration
call plug#end()
" }}}

" Update all plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
	\| :PlugInstall --sync
\| endif

" Plugin: olimorris/onedarkpro.nvim {{{
"colorscheme onedark
"set background=dark " Optional: change to 'light' for the light version
" }}}

" Plugin: catppuccin/nvim {{{
"colorscheme catppuccin
set background=dark " Optional: change to 'light' for the light version
" }}}

" Plugin: lewis6991/gitsigns.nvim {{{
if has_key(plugs, 'gitsigns.nvim')
	lua << EOF
		require("gitsigns").setup{
			signs = {
				add          = { text = '│' },
				change       = { text = '│' },
				delete       = { text = '_' },
				topdelete    = { text = '‾' },
				changedelete = { text = '~' },
				untracked    = { text = '┆' },
			},
			attach_to_untracked = true,
			current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
				delay = 1000,
				ignore_whitespace = false,
			},
		}
EOF
	" Popup what's changed in a hunk under cursor
	nnoremap <Leader>gp :Gitsigns preview_hunk<CR>
	" Stage/reset individual hunks under cursor in a file
	nnoremap <Leader>gs	:Gitsigns stage_hunk<CR>
	nnoremap <Leader>gr :Gitsigns reset_hunk<CR>
	nnoremap <Leader>gu :Gitsigns undo_stage_hunk<CR>

	" Stage/reset all hunks in a file
	nnoremap <Leader>gS :Gitsigns stage_buffer<CR>
	nnoremap <Leader>gU :Gitsigns reset_buffer_index<CR>
	nnoremap <Leader>gR :Gitsigns reset_buffer<CR>

	" Git blame
	nnoremap <Leader>gB :Gitsigns toggle_current_line_blame<CR>
endif
" }}}

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
" These settings come from https://jakobgm.com/posts/vim/git-integration/index.html
"let g:gitgutter_override_sign_column_highlight = 1
"highlight SignColumn guibg=bg
"highlight SignColumn ctermbg=bg
" Update sign column every quarter second
"set updatetime=250
endif
" }}}

" Plugin: jreybert/vimagit {{{
if has_key(plugs, 'vimagit')
" Open vimagit pane
nnoremap <leader>gs :Magit<CR>  " git status
" Push to remote
nnoremap <leader>gP :! git push<CR> " git push
" Enable deletion of untracked files in Magit
" let g:magit_discard_untracked_do_delete=1
endif
" }}}

" Plugin: dense-analysis/ale {{{
if has_key(plugs, 'ale')
	" Ignore git commit when linting (highly annoying)
	let g:ale_pattern_options = {
	\		'COMMIT_EDITMSG$': {'ale_linters': [], 'ale_fixers': []}
	\	}
	let g:ale_linters = {
	\	'yaml': ['yamllint'],
	\	'cpp': ['clangd', 'clangtidy'],
	\	'c': ['clangd', 'clangtidy'],
	\	'asciidoc': ['cspell'],
	\	'markdown': ['cspell']
	\	}
	let g:ale_linter_aliases = {
	\	'asciidoctor': 'asciidoc'
	\}
	let g:ale_fixers = {
	\	'cpp': ['clang-format'],
	\	'c': ['clang-format']}
	let g:ale_linters_explicit = 0
	let g:ale_completion_enabled = 1
	let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
	let g:ale_set_balloons=1
	let g:ale_hover_to_floating_preview=1
	let g:ale_use_global_executables = 1
	let g:ale_sign_column_always = 1
	let g:ale_disable_lsp = 1

	" Cspell options
	let g:ale_cspell_use_global = 1
	let g:ale_cspell_options = '-c cspell.json'

	" Clang Tidy configuration
	let g:ale_cpp_clangtidy_options = '-checks=-*,cppcoreguidelines-*'
	let g:ale_cpp_clangtidy_checks = ['readability-*,performance-*,bugprone-*,misc-*']
	let g:ale_cpp_clangtidy_checks += ['clang-analyzer-cplusplus-doc-comments']

	let g:ale_c_clangtidy_options = '-checks=-*,cppcoreguidelines-*'
	let g:ale_c_clangtidy_checks = ['readability-*,performance-*,bugprone-*,misc-*']
	let g:ale_c_clangtidy_checks += ['-readability-function-cognitive-complexity']
	let g:ale_c_clangtidy_checks += ['-readability-identifier-length']
	let g:ale_c_clangtidy_checks += ['-misc-redundant-expression']
	let g:ale_c_build_dir_names = ['build', 'release', 'debug']
	let g:ale_set_balloons=1
	let g:ale_hover_to_floating_preview=1

	" Automatic fixing
	autocmd FileType c nnoremap <leader>f <Plug>(ale_fix)

	" This function searches for the first clang-tidy config in parent directories and sets it
	function! SetClangTidyConfig()
		let l:config_file = findfile('.clang-tidy', expand('%:p:h').';')
		if !empty(l:config_file)
			let g:ale_c_clangtidy_options = '--config=' . l:config_file
			let g:ale_cpp_clangtidy_options = '--config=' . l:config_file
		endif
	endfunction

	" Run this for c and c++ files
	autocmd BufRead,BufNewFile *.c,*.cpp,*.h,*.hpp call SetClangTidyConfig()

	" Diagnostics
	let g:ale_use_neovim_diagnostics_api = 1
	let g:airline#extensions#ale#enabled = 1
	" let g:ale_sign_error = '>>'
	" let g:ale_sign_warning = '!!'
endif
" }}}

" Plugin: tpope/vim-fugitive {{{
if has_key(plugs, 'vim-fugitive')
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
"nnoremap <Leader>gaf :Gw<CR>    "git add file
endif
" }}}

" Plugin: preservim/nerdtree {{{
autocmd FileType nerdtree setlocal nolist
let g:NERDTreeWinSize = 40
nnoremap <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.o$', '\.obj$', '\.a$', '\.so$', '\.out$', '\.git$']
let NERDTreeShowHidden = 1
let g:NERDTreeGitStatusIndicatorMapCustom = {
\ 'Modified'  :'✹',
\ 'Staged'    :'✚',
\ 'Untracked' :'✭',
\ 'Renamed'   :'➜',
\ 'Unmerged'  :'═',
\ 'Deleted'   :'✖',
\ 'Dirty'     :'✗',
\ 'Ignored'   :'☒',
\ 'Clean'     :'✔︎',
\ 'Unknown'   :'?',
\ }
" }}}

