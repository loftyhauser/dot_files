set nocompatible
set autoindent
"set t_Co=256
"colorscheme colorful256
set ch=2
set viminfo='1,h
syntax on
set ruler
set showmode
set showcmd
set hlsearch
set incsearch
set showmatch
set number
set wildmenu
"filetype plugin indent on
set background=light
autocmd bufnewfile *.[ch] so /home/alofthou/git-projects/dot_files/c-header.txt
autocmd bufnewfile *.[ch] exe "1," . 10 . "g/File Name :.*/s//File Name : " .expand("%")
autocmd bufnewfile *.[ch] exe "1," . 10 . "g/Creation Date :.*/s//Creation Date : " .strftime("%Y-%m-%d")
autocmd Bufwritepre,filewritepre *.[ch] execute "normal ma"
autocmd Bufwritepre,filewritepre *.[ch] exe "1," . 10 . "g/Last Modified :.*/s/Last Modified :.*/Last Modified : " .strftime("%a, %d %b %Y %H:%M:%S %z")
autocmd bufwritepost,filewritepost *.[ch] execute "normal `a"
