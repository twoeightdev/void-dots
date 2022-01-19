" palette
let g:dark = {}
let g:dark.black    =  [0,  '#1d2021']
let g:dark.red      =  [1,  '#cc241d']
let g:dark.green    =  [2,  '#98971a']
let g:dark.yellow   =  [3,  '#d79921']
let g:dark.blue     =  [4,  '#458588']
let g:dark.magenta  =  [5,  '#b16286']
let g:dark.cyan     =  [6,  '#689d6a']
let g:dark.white    =  [7,  '#a89984']

let g:light = {}
let g:light.black   =  [8,  '#928374']
let g:light.red     =  [9,  '#fb4934']
let g:light.green   =  [10, '#b8bb26']
let g:light.yellow  =  [11, '#fabd2f']
let g:light.blue    =  [12, '#83a598']
let g:light.magenta =  [13, '#d3869b']
let g:light.cyan    =  [14, '#8ec07c']
let g:light.white   =  [15, '#ebdbb2']

let g:none          = ["none", "none"]

" comment line italic
highlight Comment cterm=italic gui=italic

function! g:C(scope, bg, fg, attr)
  exec "hi ".a:scope "ctermbg=".a:bg[0] "ctermfg=".a:fg[0] "cterm=".a:attr "guibg=".a:bg[1] "guifg=".a:fg[1] "gui=".a:attr
endfunction

" color depending on mode
function! RedrawModeColors(mode)
  " normal mode
  if a:mode ==# 'n'
    call g:C("Mode", g:dark.black, g:dark.blue, "none")
    " insert mode
  elseif a:mode ==# 'i'
    call g:C("Mode", g:dark.black, g:dark.yellow, "none")
    " replace mode
  elseif a:mode ==# 'R'
    call g:C("Mode", g:dark.black, g:dark.red, "none")
    " visual mode
  elseif a:mode ==# 'v' || a:mode ==# 'V' || a:mode ==# '^V'
    call g:C("Mode", g:dark.black, g:dark.magenta, "none")
    " command mode
  elseif a:mode ==# 'c'
    call g:C("Mode", g:dark.black, g:dark.green, "none")
    " terminal mode
  elseif a:mode ==# 't'
    call g:C("Mode", g:dark.black, g:dark.red, "none")
  endif
  " return empty string so as not to display anything in the statusline
  return ''
endfunction

" nice mode name
function! ModeName(mode)
  if a:mode ==# 'n'
    return 'NORMAL'
    " insert mode
  elseif a:mode ==# 'i'
    return 'INSERT'
    " replace mode
  elseif a:mode ==# 'R'
    return 'REPLACE'
    " visual mode
  elseif a:mode ==# 'v'
    return 'VISUAL'
  elseif a:mode ==# 'V'
    return 'V-LINE'
  elseif a:mode ==# '^V'
    return 'V-BLOCK'
    " command mode
  elseif a:mode ==# 'c'
    return 'COMMAND'
    " terminal mode
  elseif a:mode ==# 't'
    return 'TERMINAL'
  endif
endfunction

" git
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

" modification mark
function! SetModifiedSymbol(modified)
  if a:modified == 1
    hi ModifiedBody ctermbg=NONE cterm=NONE ctermfg=7
    return '+'
  else
    hi ModifiedBody ctermbg=NONE cterm=bold ctermfg=7
    return ''
  endif
endfunction

" filetype
function! SetFiletype(filetype)
  if a:filetype ==# ''
    return '-'
  else
    return a:filetype
  endif
endfunction

" statusbar
"================
" statusbar items
"================
" this will not be displayed, but the function RedrawModeColors will be
" called every time the mode changes, thus updating the colors used for the
" components
set statusline=%{RedrawModeColors(mode())}

"================
" left side items
"================
" mode
"set statusline+=%#Separator#▒░
"set statusline+=%#Mode#%{ModeName(mode())}
"set statusline+=%#Separator#░▒

" filename
set statusline+=%#Separator#▒
set statusline+=%#Mode#%t

" git branch
let branch = GitBranch()
if !empty(branch)
  set statusline+=%#Separator#▓▒░
  set statusline+=%#Separator#░▒▓
  set statusline+=%#Git#%{FugitiveHead()}
  set statusline+=%#Separator#█▓▒░
else
  set statusline+=%#Separator#█▓▒░
endif

" modified status
set statusline+=%#ModifiedBody#%{SetModifiedSymbol(&modified)}%#Reset#

"=================
" right side items
"=================
" current scroll percentage
set statusline+=%=
set statusline+=%#Separator#░▒▓█
set statusline+=\%#LinePerc#%2p%%
set statusline+=%#Separator#▓▒░

" line and column
set statusline+=%#Separator#░▒▓
set statusline+=%#LineCol#%2l
set statusline+=\/%#LineCol#%2c
set statusline+=%#Separator#▓▒░

" filetype
set statusline+=%#Separator#░▒▓
set statusline+=\%#Filetype#%{SetFiletype(&filetype)}
set statusline+=\ \%#Separator#▒

" tabline colors; disable plugin/tabline.vim last 3 lines to use this
call g:C("TabLine",     g:none, g:dark.magenta, "none")
call g:C("TabLineSel",  g:none, g:dark.blue,    "none")
call g:C("TabLineFill", g:none, g:dark.yellow,  "none")

" statusline colors
call g:C("Reset",       g:none,         g:dark.black,   "none")
call g:C("Separator",   g:none,         g:dark.black,   "none")
call g:C("Git",         g:dark.black,   g:dark.white,   "none")
call g:C("Modified",    g:dark.black,   g:dark.black,   "none")
call g:C("LineCol",     g:dark.black,   g:dark.yellow,  "none")
call g:C("LinePerc",    g:dark.black,   g:dark.green,   "none")
call g:C("Filetype",    g:dark.black,   g:dark.magenta, "italic")
