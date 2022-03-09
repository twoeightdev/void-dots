-- Wiki.vim - Minimal wiki
vim.g.wiki_global_load = 0
vim.g.wiki_root = "~/.config/dev/personal/wiki"
vim.g.wiki_filetypes = { "md" }
vim.g.wiki_link_extension = ".md"

vim.g.wiki_link_target_type = 'md'
vim.g.wiki_write_on_nav = 1
vim.g.wiki_list_todo = 1
vim.g.wiki_mappings_use_defaults = 1    -- disable all mappings

-- List.vim - Toggle checkbox for wiki.vim
vim.g.lists_filetypes = { "md", "markdown" }


-- Export
vim.g.wiki_export = {
    args = "--pdf-engine=tectonic",
    from_format = "markdown",
    ext = "pdf",
    output = "pdf/",
}

vim.g.wiki_journal = {
    index_use_journal_scheme = 1,
    name = "diary",
    frequency = "daily",
    date_format = {
        daily = "%Y-%m-%d",
        weekly = "%Y_w%V",
        monthly = "%Y_m%m",
    }
}
