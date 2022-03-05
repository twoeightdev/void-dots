local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local colors = {
  black        = '#32302f',
  white        = '#d4be98',
  red          = '#ea6962',
  green        = '#a9b665',
  blue         = '#7daea3',
  yellow       = '#e78a4e',
  orange       = '#b47109',
  darkgray     = '#3c3836',
}

local theme = {
    normal = {
        a = {bg = colors.orange, fg = colors.black, gui = 'bold'},
        b = {bg = colors.darkgray, fg = colors.white},
        c = {bg = colors.black, fg = colors.white}
    },
    insert = {
        a = {bg = colors.blue, fg = colors.black, gui = 'bold'},
        b = {bg = colors.darkgray, fg = colors.white},
        c = {bg = colors.black, fg = colors.white}
    },
    visual = {
        a = {bg = colors.yellow, fg = colors.black, gui = 'bold'},
        b = {bg = colors.darkgray, fg = colors.white},
        c = {bg = colors.black, fg = colors.white}
    },
    replace = {
        a = {bg = colors.red, fg = colors.black, gui = 'bold'},
        b = {bg = colors.darkgray, fg = colors.white},
        c = {bg = colors.black, fg = colors.white}
    },
    command = {
        a = {bg = colors.green, fg = colors.black, gui = 'bold'},
        b = {bg = colors.darkgray, fg = colors.white},
        c = {bg = colors.black, fg = colors.white}
    },
    inactive = {
        a = {bg = colors.black, fg = colors.white, gui = 'bold'},
        b = {bg = colors.black, fg = colors.white},
        c = {bg = colors.black, fg = colors.white}
    }
}

local diff = {
    "diff",
    colored = false,
    symbols = { added = " ", modified = " ", removed = " " },
    cond = hide_in_width
}

local filetype = {
    "filetype",
    icons_enabled = false,
    icon = nil,
}

local branch = {
    "branch",
    icons_enabled = true,
    icon = "",
}

local location = {
    "location",
    padding = 0,
}

local spaces = function()
    return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end


lualine.setup {
    options = {
        icons_enabled = true,
        theme = theme,
        component_separators = '|',
        --section_separators = { left = '', right = ''},
        section_separators = {},
        disabled_filetypes = {},
        always_divide_middle = true,
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {branch, diff, 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {spaces, 'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {location}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {location},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
}
