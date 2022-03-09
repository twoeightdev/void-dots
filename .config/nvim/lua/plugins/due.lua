local status_ok, due_nvim = pcall(require, "due_nvim")
if not status_ok then
	return
end

due_nvim.setup {
    draw = 0,
    clean = 0,
    redraw = 0,
    async_update = 0,
    prescript = "due: ",
    prescript_hi = "Comment",
    due_hi = "String",
    ft = "*.md",
    today = "TODAY",
    today_hi = "Character",
    overdue = "OVERDUE",
    overdue_hi = "Error",
    date_hi = "Conceal",
    pattern_start = "(",
    pattern_end = ")",
    update_rate = 1000,
    use_clock_time = true,
    use_clock_today = false,
    use_seconds = true,
    default_due_time = "noon"   -- midnight(24hr) and noon(12hr)
}
