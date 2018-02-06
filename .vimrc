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
set smartcase
set showmatch
set number
set wildmenu
"filetype plugin indent on
"set background=light
set tabstop=4
set shiftwidth=4
set expandtab

autocmd bufnewfile *.c so /home/alofthou/git-projects/dot_files/c-header.txt
autocmd bufnewfile *.h so /home/alofthou/git-projects/dot_files/h-header.txt
autocmd bufnewfile *.[ch] exe "1," . 10 . "g/File Name :.*/s//File Name : " .expand("%")
autocmd bufnewfile *.[ch] exe "1," . 10 . "g/Creation Date :.*/s//Creation Date : " .strftime("%Y-%m-%d")
autocmd bufwritepre,filewritepre *.[ch] execute "normal ma"
autocmd bufwritepre,filewritepre *.[ch] exe "1," . 10 . "g/Last Modified :.*/s/Last Modified :.*/Last Modified : " .strftime("%a, %d %b %Y %H:%M:%S %z")
autocmd bufwritepost,filewritepost *.[ch] execute "normal `a"
