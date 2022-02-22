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
let g:which_key_sep = '->'

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0

" Single leader mappings
let g:which_key_map['.'] = [':e $MYVIMRC',                  'open init']
let g:which_key_map['x'] = [':x',                           'exit save']
let g:which_key_map['s'] = [':w',                           'save']
let g:which_key_map['q'] = [':q!',                          'exit without save']
let g:which_key_map['c'] = [':let @/ = ""',                 'clear hlsearch']
let g:which_key_map['t'] = [':retab',                       'retab']
let g:which_key_map['h'] = [':ColorToggle',                 'Colorizer']
let g:which_key_map['i'] = [':IndentLinesToggle',           'Toggle Indentguide']
let g:which_key_map['e'] = [':FZF ~',                       'FZF Home']
let g:which_key_map['d'] = [':bd!',                         'delete buffer']
let g:which_key_map[';'] = ['q:',                           'commands history']
let g:which_key_map['z'] = [':FZF',                         'FZF']
let g:which_key_map['1'] = ['1gt',                          'tab1']
let g:which_key_map['2'] = ['2gt',                          'tab2']
let g:which_key_map['3'] = ['3gt',                          'tab3']
let g:which_key_map['4'] = ['4gt',                          'tab4']
let g:which_key_map['5'] = ['5gt',                          'tab5']

" Actions is for a
let g:which_key_map.a = {
            \ 'name' : '+actions',
            \ 'n' : [':set nonumber!',                      'line-numbers'],
            \ 'r' : [':set norelativenumber!',              'relative line nums'],
            \ 's' : [':setlocal spell! spelllang=en_us',    'spell check'],
            \ 'h' : [':new',                                'horizontal split'],
            \ 'v' : [':vnew',                               'vertical split'],
            \ 'c' : [':CalendarH',                          'Calendar'],
            \ 't' : [':r!date "+\%I:\%M\%p"',               'Time'],
            \ 'd' : [':r!date "+<\%Y-\%B>"',                'Date'],
            \ 'e' : [':^R=strftime("%FT%T%z")',             'exDate'],
            \}

" Resize
let g:which_key_map.r = {
            \ 'name' : '+resize-window',
            \ 'l' : [':vertical resize -2',                 'vsplit decrease'],
            \ 'h' : [':vertical resize +2',                 'vsplit increase'],
            \ 'k' : [':resize +2',                          'hsplit increase'],
            \ 'j' : [':resize -2',                          'hsplit decrease'],
            \ '=' : ['<C-W>=',                              'equalize width and height'],
            \ 'w' : ['<C-W>|',                              'set max width'],
            \ 'e' : ['<C-W>_',                              'set max height'],
            \ 'm' : [':MaximizerToggle',                    'toggle maximize'],
            \}

" Fugitive is for g
let g:which_key_map.g = {
            \ 'name' : '+git',
            \ 'c' : [':Git commit -a',                      'commit'],
            \ 'p' : [':Git! push -u origin main',           'push'],
            \ 's' : [':Git',                                'status'],
            \ 'o' : [':Git! checkout -- %',                 'checkout'],
            \ 'd' : [':Git diff',                           'diff'],
            \}

" Register dictionary
call which_key#register('<Space>', "g:which_key_map")
