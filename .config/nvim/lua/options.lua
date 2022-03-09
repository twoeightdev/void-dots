local options = {
    conceallevel = 2,
    concealcursor = 'nc',
    background = 'light',                   -- Set if not using colorscheme
    --signcolumn = 'number',                  -- Move gitsigns in number line
    signcolumn = "yes",
    colorcolumn = "80",
    hidden = true,
    clipboard = 'unnamedplus',              -- System clipboard
    ignorecase = false,                     -- Ignore case in search patterns
    mouse = 'a',                            -- Allow the mouse to use
    wrap = false,                           -- Wrap long lines
    updatetime = 300,                       -- Faster completion
    cursorline = true,                      -- Highlight the current line
    hlsearch = false,                       -- Highlight match in search
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
    scrolloff = 8,
    sidescrolloff = 8,
    shortmess = vim.opt.shortmess + 'icw',  -- Avoid hit-enter prompt
    timeoutlen = 300,                       -- Time to wait for mapped sequence
    fillchars = {
        eob = ' ',                          -- Suppress ~ at end of buffer
        vert = '│',
        msgsep = '‾',
        diff = '╱', -- alternatives = ⣿ ░ ─
        fold = ' ',
        foldopen = '▾',
        foldsep = '│',
        foldclose = '▸'
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

-- Reload programs when configuration is updated
cmd [[
    augroup _progs
        autocmd!
        autocmd BufWritePost *Xresources,Xdefaults,xresources,xcolor !xrdb %
        autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd
        autocmd BufWritePost dunstrc !pkill dunst; dunst &
        autocmd BufWritePost bm-files,bm-dirs !shortcuts
    augroup end
]]
-- Disable auto comment on newline
cmd [[
    augroup _comment
        autocmd!
        autocmd FileType * setlocal fo-=c fo-=r fo-=o
    augroup end
]]
-- Delete all trailing whitespace and newlines
cmd [[
    augroup _whitespace
        autocmd!
        autocmd BufWritePre * let currPos = getpos(".")
        autocmd BufWritePre * %s/\s\+$//e
        autocmd BufWritePre * %s/\n\+\%$//e
        autocmd BufWritePre *.[ch] %s/\%$/\r/e
        autocmd BufWritePre * cal cursor(currPos[1], currPos[2])
    augroup end
]]
