local status_ok, feline = pcall(require, "feline")
if not status_ok then
    return
end

local colors = {
    bg = '#1d2021',
    fg = '#d4be98',
    pink = '#c14a4a',
    green = '#a9b665',
    cyan = '#89b482',
    yellow = '#d8a657',
    orange = '#e78a4e',
    purple = '#d3869b',
    red = '#ea6962',
    trans = 'none',
}

local vi_mode_colors = {
    NORMAL = colors.green,
    INSERT = colors.red,
    VISUAL = colors.yellow,
    OP = colors.cyan,
    BLOCK = colors.cyan,
    REPLACE = colors.red,
    ['V-REPLACE'] = colors.red,
    ENTER = colors.orange,
    MORE = colors.orange,
    SELECT = colors.yellow,
    COMMAND = colors.pink,
    SHELL = colors.pink,
    TERM = colors.pink,
    NONE = colors.purple
}

-- Providers
local vi_mode_utils = require 'feline.providers.vi_mode'

local function vimode_hl()
    return {
        name = vi_mode_utils.get_mode_highlight_name(),
        fg = vi_mode_utils.get_mode_color()
    }
end

-- My component
local comps = {
    -- vi_mode
    vi_mode = {
        left = {
            provider = function()
                local label = ' '..vi_mode_utils.get_vim_mode()..' '
                return label
            end,
            hl = vimode_hl,
            right_sep = ' '
        },
        right = {
            provider = function()
                local label = ' '..vi_mode_utils.get_vim_mode()..' '
                return label
            end,
            hl = vimode_hl,
            left_sep = ' '
        }
    },
    -- Parse file information:
    file = {
        -- File name
        info = {
            provider = {
                name = 'file_info',
                opts = {
                    type = 'relative',
                    file_modified_icon = '+'
                }
            },
            hl = {
                fg = colors.yellow
            },
            icon = '',
        },
        -- File type
        type = {
            provider = 'file_type',
            hl = {
                fg = colors.yellow
            },
        },
        -- Line-column
        position = {
            provider = { name = 'position' },
            hl = {
                fg = colors.cyan,
                style = 'bold',
            },
            left_sep = ' ',
            right_sep = ' ',
        },
        -- Cursor position in %
        line_percentage = {
            provider = 'line_percentage',
            left_sep = ' ',
            hl = {
                fg = colors.purple,
                bg = colors.trans,
                style = 'bold',
            }
        },
        -- Scrollbar
        scroll_bar = {
            provider = 'scroll_bar',
            left_sep = ' ',
            hl = {
                fg = colors.fg
            }
        },
    },
    -- Git info
    git = {
        branch = {
            provider = 'git_branch',
            icon = ' ',
            hl = {
                fg = colors.pink
            },
            left_sep = '  ',
        },
        add = {
            provider = 'git_diff_added',
            icon = '  ',
            hl = {
                fg = colors.green
            },
            left_sep = ' ',
        },
        change = {
            provider = 'git_diff_changed',
            icon = '  ',
            hl = {
                fg = colors.orange
            },
            left_sep = ' ',
        },
        remove = {
            provider = 'git_diff_removed',
            icon = '  ',
            hl = {
                fg = colors.red
            },
            left_sep = ' ',
        }
    }
}

-- Get active/inactive components
--- see: https://github.com/famiu/feline.nvim/blob/master/USAGE.md#components
local components = {
    active = {},
    inactive = {},
}

table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})

-- Right section
table.insert(components.active[1], comps.vi_mode.left)
table.insert(components.active[1], comps.file.info)
table.insert(components.active[1], comps.git.branch)
table.insert(components.active[1], comps.git.add)
table.insert(components.active[1], comps.git.change)
table.insert(components.active[1], comps.git.remove)
table.insert(components.inactive[1], comps.file.info)

-- Left Section
table.insert(components.active[2], comps.file.type)
table.insert(components.active[2], comps.file.os)
table.insert(components.active[2], comps.file.position)
table.insert(components.active[2], comps.file.line_percentage)

feline.setup {
    theme = {
        bg = colors.trans,
        fg = colors.fg
    },
    components = components,
    vi_mode_colors = vi_mode_colors,
    force_inactive = {
        filetypes = {
            'packer',
            'NvimTree',
        },
        buftypes = {},
        bufnames = {},
    },
}
