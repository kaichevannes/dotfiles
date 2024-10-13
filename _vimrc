" Configure vim to use plugins
set nocompatible
filetype plugin on

" Enable the matchit plugin
runtime macros/matchit.vim

" Enable search highlighting by default
set hlsearch

" Enable relative line numbers
set number
set relativenumber

" Increase ex command history length
set history=20

" Make tabs work consistently
set ts=4 sts=4 sw=4 noexpandtab

" Treat all numbers as decimals
set nrformats=

" Tab (Buffer) navigation
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" Select all
nnoremap <leader>a ggVG

" Undo highlighting
1noremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
