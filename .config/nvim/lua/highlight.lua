-- Only use this if you don't have colorscheme
-- Autocommands
local cmd = vim.cmd

-- Visual syntax
cmd("hi Visual cterm=reverse ctermbg=NONE")
-- Fold colors
cmd("hi Folded ctermbg=NONE")
-- Spell check colors
cmd("hi SpellBad cterm=reverse ctermbg=NONE")
-- Packer popup
cmd("hi Pmenu ctermbg=black ctermfg=white")
-- WhichKey
cmd("hi WhichKeyFloat guibg=#1d2021 ctermfg=white")
cmd("hi FloatBorder guibg=#1d2021 guifg=#32302f ctermfg=black")
-- Gitsigns
cmd("hi GitSignsAdd guibg=NONE ctermfg=green")
cmd("hi GitSignsChange guibg=NONE ctermfg=yellow")
cmd("hi GitSignsDelete guibg=NONE ctermfg=red")
cmd("hi clear SignColumn")
-- Blankline
cmd("hi IndentBlanklineChar ctermfg=237")
