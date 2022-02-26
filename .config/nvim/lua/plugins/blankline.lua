local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
    return
end

indent_blankline.setup {
    char = "▏",
    show_first_indent_level = false,
    filetype_exclude = {
        'help',
        'git',
        'NvimTree',
        'text',
        'terminal',
        'packer'
    },
    buftype_exclude = {
        'terminal',
        'nofile'
    },
}
