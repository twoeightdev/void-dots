" markdownWikiLink is a new region
syn region markdownWikiLink matchgroup=markdownLinkDelimiter start="\[\[" end="\]\]" contains=markdownUrl keepend oneline concealends

" markdownLinkText is copied from runtime files with 'concealends' appended
syn region markdownLinkText matchgroup=markdownLinkTextDelimiter start="!\=\[\%(\%(\_[^][]\|\[\_[^][]*\]\)*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" nextgroup=markdownLink,markdownId skipwhite contains=@markdownInline,markdownLineStart concealends

" markdownLink is copied from runtime files with 'conceal' appended
syn region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")" contains=markdownUrl keepend contained conceal

" markdown checkbox no indention
syntax match todoCheckbox '\v(\s+)?-\s\[\s\]'hs=e-4 conceal cchar=
syntax match todoCheckbox '\v(\s+)?-\s\[X\]'hs=e-4 conceal cchar=
hi Conceal guibg=NONE
hi clear Conceal

" https://vi.stackexchange.com/a/4003/16249
" Ignore URL and email address in spell file
 syntax match NoSpellAcronym '\<\(\u\|\d\)\{3,}s\?\>' contains=@NoSpell
