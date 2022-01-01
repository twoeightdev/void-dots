" Replace escape with jj
  inoremap jj <Esc>

" Tab in general mode will move to text buffer
  nnoremap <silent> <TAB> :bnext<CR>
" Shift-TAB will go back
  nnoremap <silent> <S-TAB> :bprevious<CR>

" When line overflows, it will go
" One _visual_ line and not actual
  nnoremap j gj
  nnoremap k gk
  vnoremap j gj
  vnoremap k gk

" Next / prev command
  cnoremap <C-k> <Up>
  cnoremap <C-j> <Down>

" Move line(s) up / down / right /left
  vnoremap <silent>J :m '>+1<CR>gv=gv
  vnoremap <silent>K :m '<-2<CR>gv=gv

" Tab management
  nnoremap <M-1> 1gt
  nnoremap <M-2> 2gt
  nnoremap <M-3> 3gt
  nnoremap <M-4> 4gt
  nnoremap <M-5> 5gt
  nnoremap <M-6> 6gt
  nnoremap <M-7> 7gt
  nnoremap <M-8> 8gt
  nnoremap <M-9> 9gt
  nnoremap <M-0> 10gt

" Better window navigation
  nnoremap <C-h> <C-w>h
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  nnoremap <C-l> <C-w>l
  nnoremap <C-e> <C-w>q

" Use alt + hjkl to resize windows
  nnoremap <silent> <M-j>    :resize -2<CR>
  nnoremap <silent> <M-k>    :resize +2<CR>
  nnoremap <silent> <M-h>    :vertical resize -2<CR>
  nnoremap <silent> <M-l>    :vertical resize +2<CR>

" Save file as sudo on files that require root permission
  cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
