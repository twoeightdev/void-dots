-- local status_ok, calendar = pcall(require, "calendar-vim")
-- if not status_ok then
-- 	return
-- end

vim.g.calendar_diary = "~/.config/dev/personal/wiki/diary/"

vim.g.calendar_filetype = "markdown"
--vim.g.calendar_diary_path_pattern = "{YYYY}-{MM}-{DD}{EXT}"
vim.g.calendar_diary_extensions = ".md"
vim.g.calendar_no_mappings = 1
vim.g.calendar_monday = 1
vim.g.calendar_datetime = "statusline"
vim.g.calendar_number_of_months = 4
