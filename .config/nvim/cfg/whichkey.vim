" Define separator
let g:which_key_sep = '-'

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

" Map leader to which_key
nnoremap <silent> <leader> :silent <c-u> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

" Create map to add keys to
let g:which_key_map = {}
" Define a separator
let g:which_key_sep = '-'

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0

" Single leader mappings
let g:which_key_map['.'] = [ ':e $MYVIMRC',             'open init' ]
let g:which_key_map['w'] = [ ':x',                      'exit save' ]
let g:which_key_map['r'] = [ ':w',                      'save' ]
let g:which_key_map['q'] = [ ':q!',                     'exit without save' ]
let g:which_key_map['c'] = [ ':let @/ = ""',            'clear hlsearch' ]
let g:which_key_map['t'] = [ ':retab',                  'retab' ]
let g:which_key_map['h'] = [ ':ColorToggle',            'Colorizer' ]
let g:which_key_map['m'] = [ ':MarkdownPreviewToggle',  'Markdown Preview' ]
let g:which_key_map['i'] = [ ':IndentLinesToggle',      'Toggle Indentguide' ]
let g:which_key_map['e'] = [ ':FZF ~',                  'FZF Home' ]
let g:which_key_map['d'] = [ ':bd!',                    'delete buffer' ]
let g:which_key_map[';'] = [ 'q:',                      'commands history' ]
let g:which_key_map['z'] = [':FZF',                     'FZF' ]

" Actions is for a
let g:which_key_map.a = {
    \ 'name' : '+actions',
    \ 'n' : [ ':set nonumber!',                         'line-numbers' ],
    \ 'r' : [ ':set norelativenumber!',                 'relative line nums' ],
    \ }

" Buffer is for b
let g:which_key_map.b = {
    \ 'name' : '+buffer',
    \ '1' : [ 'b1',                                     'buffer 1' ],
    \ '2' : [ 'b2',                                     'buffer 2' ],
    \ 'd' : [ 'bd',                                     'delete-buffer' ],
    \ 'f' : [ 'bfirst',                                 'first-buffer' ],
    \ 'l' : [ 'blast',                                  'last-buffer' ],
    \ 'n' : [ 'bnext',                                  'next-buffer' ],
    \ 'p' : [ 'bprevious',                              'previous-buffer' ],
    \ '?' : [ 'Buffers',                                'fzf-buffer' ],
    \ }

" Fugitve is for g
let g:which_key_map.g = {
    \ 'c' : [ ':Git commit -a',                         'commit' ],
    \ 'p' : [ ':Git! push -u origin main',              'push' ],
    \ 's' : [ ':Git',                                   'status' ],
    \ 'o' : [ ':Git! checkout -- %',                    'checkout' ],
    \ 'd' : [ ':Git diff',                              'diff' ],
    \}

" Register dictionary
call which_key#register('<Space>', "g:which_key_map")
