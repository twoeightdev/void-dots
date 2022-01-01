" Set to 0 to disable auto indentline
let g:indentLine_enabled = 1

" Set this to exclude indentline
let g:vim_markdown_conceal = 0
let g:indentLine_fileTypeExclude = ['markdown']
let g:indentLine_bufNameExclude = ["\[vifm\]*"]
let g:indentLine_bufNameExclude = ["\[nnn\]*"]

autocmd FileType csv let g:indentLine_enabled=0

" Character used for indentline
let g:indentLine_char_list = ['▏']

" Set to 0 to use colorscheme colors
"let g:indentLine_setColors = 0
