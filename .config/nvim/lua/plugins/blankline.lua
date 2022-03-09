local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
    return
end

indent_blankline.setup {
    char = "▏",
    show_trailing_blankline_indent = true,
    show_first_indent_level = true,
    --show_current_context = true,
    filetype_exclude = {
        'help',
        'git',
        'text',
        'terminal',
        'packer'
    },
    buftype_exclude = {
        'terminal',
        'nofile'
    },
}
