local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable Ex mode
keymap("", "Q", "<Nop>", opts)

-- Disable record
keymap("", "q", "<Nop>", opts)

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Insert --
-- Press jj fast to enter
keymap("i", "jj", "<ESC>", opts)

-- Tab management
keymap("n", "<M-1>", "1gt", opts)
keymap("n", "<M-2>", "2gt", opts)
keymap("n", "<M-3>", "3gt", opts)
keymap("n", "<M-4>", "4gt", opts)
keymap("n", "<M-5>", "5gt", opts)
keymap("n", "<M-6>", "6gt", opts)
keymap("n", "<M-7>", "7gt", opts)
keymap("n", "<M-8>", "8gt", opts)
keymap("n", "<M-9>", "9gt", opts)
keymap("n", "<M-0>", "10gt", opts)

-- Wiki
keymap("n", "<cr>", ":WikiLinkFollow<cr>", opts)
keymap("n", "<bs>", ":WikiLinkReturn<cr>", opts)
