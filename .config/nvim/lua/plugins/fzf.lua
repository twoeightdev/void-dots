local status_ok, fzf = pcall(require, "fzf")
if not status_ok then
    return
end

vim.g.fzf_layout = {
    down = '40%',
}

vim.g.fzf_action = {
    enter = 'tab split',
}
