local status_ok, _ = pcall(vim.cmd, "colorscheme gruvbox-flat")
if not status_ok then
    return
end

vim.o.background = "dark" -- dark or light
vim.g.gruvbox_flat_style = "hard" -- dark or hard
vim.g.gruvbox_italic_comments = false
vim.g.showmode = false
vim.g.gruvbox_transparent = true    -- looks good with st opacity
vim.g.gruvbox_dark_sidebar = false
vim.g.gruvbox_theme = {     -- Fix colors in neorg
    TSNote = {
        bg = "none",
        fg = "none"
    },
    TSDanger = {
        bg = "none",
        fg = "none"
    },
    WhichKeyFloat = {
        bg = "none",
    },
    Pmenu = {
        bg = "none",
    }
}

local cmd = vim.cmd

cmd [[
colorscheme gruvbox-flat
]]
