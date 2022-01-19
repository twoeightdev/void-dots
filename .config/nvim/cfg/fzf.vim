"nmap ; :tabnew<Cr>:Files<Cr>

" Function to open newtab when using FZF
"function! NewTab()
"    if bufname('%') == '' && getbufvar('%', "&modified") == 0
"        FZF
"    else
"        tabnew
"        FZF
"        " Close the new tab if the find was cancelled.
"        if bufname('%') == ''
"            tabclose
"        endif
"    endif
"endfunction
"nnoremap ; :call NewTab()<cr>

" Enter to open file in new tab in fzf instead of ctrl+t
let g:fzf_action = {'enter': 'tab split'}

" Set fzf below instead of floating
let g:fzf_layout = { 'down': '40%' }
