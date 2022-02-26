local options = {
    --conceallevel = 2,
    --concealcursor = 'nc',
    background = 'light',
    termguicolors = true,
    clipboard = 'unnamedplus',              -- System clipboard
    ignorecase = true,                      -- Ignore case in search patterns
    mouse = 'a',                            -- Allow the mouse to use
    wrap = false,                           -- Wrap long lines
    --cursorline = true,                      -- Highlight the current line
    hlsearch = true,                        -- Highlight all match in search patterns
    showmode = false,                       -- Stop showing INSERT
    smartindent = true,                     -- Make indenting smart
    showcmd = false,                        -- Command in the last line
    splitbelow = true,                      -- Split horizontal to bottom
    splitright = true,                      -- Split vertical to right
    backup = false,                         -- Creates backup
    writebackup = false,                    -- Writes backup
    expandtab = true,                       -- Convert tabs to spaces
    shiftwidth = 4,                         -- Indention space
    softtabstop = 4,                        -- Tabs space in insert mode
    swapfile = false,                       -- Creates swapfile
    tabstop = 4,                            -- Insert 4 spaces for a tab
    laststatus = 2,                         -- Show status line
    number = true,                          -- Show line number
    relativenumber = true,                  -- Show relative number
    shortmess = vim.opt.shortmess + 'icw',  -- Avoid hit-enter prompt
    timeoutlen = 300,                       -- Time to wait for mapped sequence
    fillchars = {                           -- Remove annoying ~
        eob = ' ',
        vert = '│',
        msgsep = '‾',
        fold = ' '
    },
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

-- Disable builtin plugins
local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

-- Autocommands
local cmd = vim.cmd

cmd [[au BufWritePost dunstrc !pkill dunst; dunst &]]
cmd [[au BufWritePost *Xresources,Xdefaults,xresources,xcolor !xrdb %]]
cmd [[au BufWritePost *sxhkdrc !pkill -USR1 sxhkd]]
cmd [[au BufWritePost bm-files,bm-dirs !shortcuts]]
cmd [[au BufEnter * setlocal formatoptions-=c formatoptions-=r formatoptions-=o]]
cmd [[au BufWritePre * let currPos = getpos(".")]]
cmd [[au BufWritePre * %s/\s\+$//e]]
cmd [[au BufWritePre * %s/\n\+\%$//e]]
cmd [[au BufWritePre * cal cursor(currPos[1], currPos[2])]]

-- Autocommands
--local au = require('autocmd')
--au.addListeners({
--    -- Reload when configuration is updated
--    ['user-binary'] = {
--        [[BufWritePost dunstrc !pkill dunst; dunst &]],
--        [[BufWritePost *Xresources,Xdefaults,xresources,xcolor !xrdb %]],
--        [[BufWritePost *sxhkdrc !pkill -USR1 sxhkd]],
--        [[BufWritePost bm-files,bm-dirs !shortcuts]],
--    },
--    -- Disable auto commenting on newline
--    ['user-newline'] = {
--        [[BufEnter * setlocal formatoptions-=c formatoptions-=r formatoptions-=o]]
--    },
--    -- Automatically deletes all trailing white space and newlines
--    -- at the end of file on save. & reset cursor position
--    ['user-whitespace'] = {
--        [[BufWritePre * let currPos = getpos(".")]],
--        [[BufWritePre * %s/\s\+$//e]],
--        [[BufWritePre * %s/\n\+\%$//e]],
--        [[BufWritePre *.[ch] %s/\%$/\r/e]],
--        [[BufWritePre * cal cursor(currPos[1], currPos[2])]],
--    },
--})
