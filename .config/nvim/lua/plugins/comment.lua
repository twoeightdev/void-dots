local status_ok, comment = pcall(require, "nvim_comment")
if not status_ok then
    return
end

comment.setup {
    mark_padding = true,
    comment_empty = true,
    create_mappings = true,
    line_mapping = "gcc",
    operator_mapping = "gc",
    hook = nil,
}
