" markdownWikiLink is a new region
syn region markdownWikiLink matchgroup=markdownLinkDelimiter start="\[\[" end="\]\]" contains=markdownUrl keepend oneline concealends

" markdownLinkText is copied from runtime files with 'concealends' appended
syn region markdownLinkText matchgroup=markdownLinkTextDelimiter start="!\=\[\%(\%(\_[^][]\|\[\_[^][]*\]\)*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" nextgroup=markdownLink,markdownId skipwhite contains=@markdownInline,markdownLineStart concealends

" markdownLink is copied from runtime files with 'conceal' appended
syn region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")" contains=markdownUrl keepend contained conceal

" markdown checkbox no indention
"syntax match todoCheckbox '\v(\s+)?-\s\[\s\]'hs=e-4 conceal cchar=
"syntax match todoCheckbox '\v(\s+)?-\s\[X\]'hs=e-4 conceal cchar=

" markdown checkbox with indention
"call matchadd('Conceal', '\[\ \]', 0, 11, {'conceal': ''})
"call matchadd('Conceal', '\[x\]', 0, 12, {'conceal': ''})
"hi Conceal guibg=NONE
"hi clear Conceal
