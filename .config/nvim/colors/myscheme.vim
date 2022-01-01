" Setup
hi clear
syntax clear
set background=dark
let g:colors_name='myscheme'

" Palette
let g:dark = {}
let g:dark.black    =  [0,  '#3b4252']
let g:dark.red      =  [1,  '#bf616a']
let g:dark.green    =  [2,  '#a3be8c']
let g:dark.yellow   =  [3,  '#ebcb8b']
let g:dark.blue     =  [4,  '#81a1c1']
let g:dark.magenta  =  [5,  '#b48ead']
let g:dark.cyan     =  [6,  '#88c0d0']
let g:dark.white    =  [7,  '#e5e9f0']

let g:light = {}
let g:light.black   =  [8,  '#4c566a']
let g:light.red     =  [9,  '#bf616a']
let g:light.green   =  [10, '#a3be8c']
let g:light.yellow  =  [11, '#ebcb8b']
let g:light.blue    =  [12, '#81a1c1']
let g:light.magenta =  [13, '#b48ead']
let g:light.cyan    =  [14, '#8fbcbb']
let g:light.white   =  [15, '#eceff4']

let g:none          = ["none", "none"]

function! g:C(scope, bg, fg, attr)
  exec "hi ".a:scope "ctermbg=".a:bg[0] "ctermfg=".a:fg[0] "cterm=".a:attr "guibg=".a:bg[1] "guifg=".a:fg[1] "gui=".a:attr
endfunction

" Editor settings
call g:C("Normal",       g:none,            g:dark.white,     "none")
call g:C("Cursor",       g:none,            g:dark.white,     "none")
call g:C("CursorLine",   g:dark.black,      g:none,           "none")
call g:C("LineNr",       g:none,            g:light.black,    "none")
call g:C("CursorLineNr", g:none,            g:light.white,    "bold")

" Number collumn
call g:C("CursorColumn", g:dark.black,      g:none,           "none")
call g:C("FoldedColumn", g:none,            g:none,           "none")
call g:C("FoldColumn",   g:none,            g:light.black,    "none")
call g:C("SignColumn",   g:none,            g:dark.white,     "none")
call g:C("Folded",       g:dark.black,      g:dark.blue,      "none")

" Window / tab delimeters
call g:C("VertSplit",    g:none,            g:dark.black,     "none")
call g:C("ColorColumn",  g:none,            g:dark.black,     "none")
call g:C("TabLine",      g:none,            g:none,           "none")
call g:C("TabLineFill",  g:none,            g:none,           "none")
call g:C("TabLineSel",   g:dark.black,      g:dark.blue,      "bold")

" File navigation / searching
call g:C("Directory",    g:none,            g:dark.blue,      "none")
call g:C("Search",       g:none,            g:none,           "reverse")
call g:C("IncSearch",    g:none,            g:none,           "reverse")
call g:C("HighlightedyankRegion",  g:dark.black,  g:none,     "none")

" Prompt / status
call g:C("StatusLine",   g:none,            g:none,           "none")
call g:C("StatusLineNC", g:none,            g:light.black,    "none")
call g:C("WildMenu",     g:light.black,     g:dark.black,     "none")
call g:C("Title",        g:none,            g:dark.yellow,    "bold")
call g:C("Question",     g:none,            g:light.blue,     "none")
call g:C("MoreMsg",      g:none,            g:dark.blue,      "none")
call g:C("ModeMsg",      g:none,            g:light.black,    "none")

" Visual aid
call g:C("MatchParen",   g:none,            g:dark.blue,      "underline")
call g:C("Visual",       g:dark.black,      g:none,           "none")
call g:C("VisualNOS",    g:dark.black,      g:none,           "none")
call g:C("NonText",      g:none,            g:dark.black,     "none")

call g:C("Todo",         g:none,            g:dark.yellow,    "bold")
call g:C("Underlined",   g:none,            g:light.blue,     "underline")
call g:C("Error",        g:none ,           g:dark.red,       "none")
call g:C("ErrorMsg",     g:none,            g:dark.red,       "none")
call g:C("WarningMsg",   g:none,            g:light.yellow,   "none")
call g:C("Ignore",       g:none,            g:dark.red,       "none")
call g:C("SpecialKey",   g:none,            g:dark.magenta,   "none")
call g:C("Whitespace",   g:none,            g:light.black,    "none")

" Variable types
call g:C("Constant",     g:none,            g:none,           "none")
call g:C("String",       g:none,            g:dark.cyan,      "none")
call g:C("Character",    g:none,            g:dark.red,       "none")
call g:C("Number",       g:none,            g:dark.magenta,   "none")
call g:C("Boolean",      g:none,            g:light.yellow,   "none")
call g:C("Float",        g:none,            g:dark.magenta,   "none")

call g:C("Identifier",   g:none,            g:dark.cyan,      "none")
call g:C("Function",     g:none,            g:dark.yellow,    "none")


" Language constructs
call g:C("Comment",      g:none,            g:light.black,    "none")
call g:C("Statement",    g:none,            g:dark.blue,      "none")
call g:C("Conditional",  g:none,            g:dark.blue,      "none")
call g:C("Repeat",       g:none,            g:dark.blue,      "none")
call g:C("Label",        g:none,            g:dark.blue,      "none")
call g:C("Operator",     g:none,            g:dark.blue,      "none")
call g:C("Keyword",      g:none,            g:dark.blue,      "none")
call g:C("Exception",    g:none,            g:dark.red,       "none")

call g:C("Special",      g:none,            g:dark.green,     "none")
call g:C("SpecialChar",  g:none,            g:dark.magenta,   "none")
call g:C("Tag",          g:none,            g:dark.blue,      "none")
call g:C("Delimiter",    g:none,            g:none,           "none")
call g:C("SpecialComment", g:none,          g:dark.magenta,   "none")
call g:C("Debug",        g:none,            g:dark.magenta,   "none")

" C like
call g:C("PreProc",      g:none,            g:dark.magenta,   "none")
call g:C("Include",      g:none,            g:dark.magenta,   "none")
call g:C("Define",       g:none,            g:dark.yellow,    "none")
call g:C("Macro",        g:none,            g:dark.yellow,    "none")
call g:C("PreCondit",    g:none,            g:dark.yellow,    "none")

call g:C("Type",         g:none,            g:dark.blue,      "none")
call g:C("StorageClass", g:none,            g:light.white,    "none")
call g:C("Structure",    g:none,            g:dark.magenta,   "none")
call g:C("Typedef",      g:none,            g:dark.magenta,   "none")

" Diff
call g:C("DiffAdd",      g:none,            g:dark.green,     "none")
call g:C("DiffDelete",   g:none,            g:dark.red,       "none")
call g:C("DiffChange",   g:none,            g:dark.yellow,    "none")
call g:C("DiffText",     g:none,            g:dark.white,     "none")
hi! link diffSubname     DiffChange
hi! link diffAdded       DiffAdd
hi! link diffRemoved     DiffDelete

" Completion menu
call g:C("Pmenu",        g:none,            g:light.white,    "none")
call g:C("PmenuSel",     g:dark.black,      g:light.blue,     "none")
call g:C("PmenuSbar",    g:none,            g:none,           "none")
call g:C("PmenuThumb",   g:dark.black,      g:dark.black,     "none")

" Quick scope
call g:C("QuickScopePrimary",  g:none,       g:dark.yellow,   "underline")
call g:C("QuickScopeSecondary",g:none,       g:dark.blue,     "underline")

" Spelling
call g:C("SpellBad",     g:none,            g:dark.red,       "underline")
call g:C("SpellCap",     g:none,            g:dark.green,     "underline")
call g:C("SpellLocal",   g:none,            g:dark.yellow,    "underline")
call g:C("SpellRare",    g:none,            g:dark.yellow,    "underline")


" Linting
call g:C("CocErrorSign",        g:none,   g:dark.red,      "none")
call g:C("CocErrorHighlight",   g:none,   g:none,          "underline")
call g:C("CocWarningSign",      g:none,   g:dark.yellow,   "none")
call g:C("CocWarningHighlight", g:none,   g:none,          "underline")


" Startify
hi! link StartifyBracket Comment
hi! link StartifyFile    Identifier
hi! link StartifyFooter  Title
hi! link StartifyHeader  Title
hi! link StartifyNumber  Special
hi! link StartifyPath    Comment
hi! link StartifySection Statement
hi! link StartifySlash   Comment
hi! link StartifySpecial Normal

" Which key
highlight default link WhichKey          Statement
highlight default link WhichKeySeperator Comment
highlight default link WhichKeyGroup     Comment
highlight default link WhichKeyDesc      Function

" Vim wiki
call g:C("VimwikiHeader1",  g:none,   g:dark.yellow,    "bold")
call g:C("VimwikiHeader2",  g:none,   g:dark.green,     "bold")
call g:C("VimwikiHeader3",  g:none,   g:dark.magenta,   "bold")
call g:C("VimwikiHeader4",  g:none,   g:light.cyan,     "bold")
call g:C("VimwikiHeader5",  g:none,   g:dark.blue,      "bold")
call g:C("VimwikiHeader6",  g:none,   g:light.black,    "bold")
call g:C("VimwikiPre",      g:none,   g:light.black,    "italic")

" Sh
call g:C("shStatement",   g:none,            g:none,           "none")
call g:C("shFunction",    g:none,            g:none,           "none")
call g:C("shOption",      g:none,            g:dark.green,     "none")
call g:C("shQuote",       g:none,            g:dark.blue,      "none")
call g:C("shDerefSimple", g:none,            g:dark.magenta,   "none")
call g:C("shFunctionKey", g:none,            g:dark.yellow,    "none")
call g:C("shVariable",    g:none,            g:none,           "none")

" Html
call g:C("htmlTag",     g:none,            g:light.black,      "none")
call g:C("htmlEndTag",  g:none,            g:light.black,      "none")
call g:C("htmlArg",     g:none,            g:light.magenta,    "none")

" Python
call g:C("pythonFunctionCall", g:none,      g:none,            "none")
call g:C("pythonImport",       g:none,      g:dark.blue,       "none")

" vim: fdm=marker
