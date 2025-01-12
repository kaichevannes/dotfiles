" Enable search highlighting by default
set hlsearch

" enable relative line numbers
set number
set relativenumber

" increase ex command history length
set history=20

" make tabs work consistently
set ts=4 sts=4 sw=4 noexpandtab

" treat all numbers as decimals
set nrformats=

" tab (buffer) navigation
nnoremap <silent> [b :bprevious<cr>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" Select all
nnoremap <leader>a ggVG

" Global replace word
nnoremap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" Centre screen after motion
nnoremap <silent> n nzzzv
nnoremap <silent> N Nzzzv
nnoremap <silent> J mzJ`z
nnoremap <silent> <C-d> <C-d>zz
nnoremap <silent> <C-u> <C-u>zz