local status_ok, todo_comments = pcall(require, "todo-comments.config")
if not status_ok then
	return
end

todo_comments.setup {
    signs = false,
    keywords = {
        FIX = {
            icon = " ",
            color = "error",
            alt = {
                "FIXME",
                "BUG",
                "FIX",
                "ISSUE",
                "SHIT",
                "BAD",
                "FUCK"
            }
        },
        TODO = {
            icon = " ",
            color = "info"
        },
        HACK = {
            icon = " ",
            color = "warning",
            alt = {
                "WORKAROUND",
                "TEMPFIX"
            }
        },
        WARN = {
            icon = " ",
            color = "warning",
            alt = {
                "WARNING",
                "XXX"
            }
        },
        PERF = {
            icon = " ",
            color = "default",
            alt = {
                "OPTIM",
                "PERFORMANCE",
                "OPTIMIZE"
            }
        },
        NOTE = {
            icon = " ",
            color = "hint",
            alt = {
                "INFO",
                "NOTES",
                "ANIME",
                "PERSONAL"
            }
        },
    },
}
