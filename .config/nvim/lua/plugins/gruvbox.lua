vim.o.background = "dark" -- dark or light
vim.g.gruvbox_flat_style = "hard" -- dark or hard
vim.g.gruvbox_italic_comments = false
vim.g.showmode = false
--vim.g.gruvbox_transparent = true
vim.g.gruvbox_dark_sidebar = false
--vim.g.gruvbox_sidebars = { "qf", "vista_kind", "terminal", "packer" }
--vim.cmd([[colorscheme gruvbox-flat]])
vim.g.gruvbox_theme = {     -- Fix colors in neorg
    TSNote = {
        bg = "none",
        fg = "none"
    },
    TSDanger = {
        bg = "none",
        fg = "none"
    }
}

vim.cmd [[
try
  colorscheme gruvbox-flat
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
endtry
]]
