local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local setup = {
    plugins = {
        marks = false,          -- shows a list of your marks on ' and `
        registers = true,       -- shows your registers on " in NORMAL or <c-r> in INSERT mode
        spelling = {
            enabled = true,     -- show spelling suggestion with <leader>z
            suggestions = 20,   -- suggestions limit
        },
        presets = {
            operators = false,      -- show help for operator d, y, etc
            motions = true,        -- help for motions
            text_objects = true,    -- help for text objects triggered after entering an operator
            windows = true,         -- default bindings on <c-w>
            nav = true,             -- misc bindings to work with windows
            z = true,               -- bindings for folds, spelling and others prefixed with z
            g = true,               -- bindings for prefixed with g
        },
    },
    key_labels = {},
    icons = {
        breadcrumb = "»",   -- symbol used in the command line area
        separator = "",    -- symbol used in a key
        group = "+",        -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = "<c-d>",  -- binding to scroll down inside the popup
        scroll_up = "<c-u>",    -- binding to scroll up inside the popup
    },
    window = {
        border = "single",          -- none, single, double, shadow
        position = "bottom",        -- bottom, top
        margin = { 1, 0, 1, 0 },    -- extra window margin [top, right, bottom, left]
        padding = { 2, 0, 2, 0 },   -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3,                    -- spacing between columns
        align = "left",                 -- align columns left, center or right
    },
    ignore_missing = true,  -- hide mappings for which you didn't specify a label
    hidden = {              -- hide mapping boilerplate
        "<silent>",
        "<cmd>",
        "<Cmd>",
        "<CR>",
        "call",
        "lua",
        "^:",
        "^ "
    },
    show_help = true,       -- show help message on the command line when the popup is visible
    triggers = "auto",      -- automatically setup triggers
    triggers_blacklist = {  -- prefixes that should never be hooked by whichkey
        i = { "j", "k" },
        v = { "j", "k" },
    },
}

local opts = {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

local mappings = {
    ["s"] = { "<cmd>w!<cr>", "save" },
    ["q"] = { "<cmd>q!<cr>", "quit" },
    ["m"] = { "<cmd>NvimTreeToggle<cr>", "explorer" },
    ["b"] = { "<cmd>bd!<cr>", "close buffer" },
    ["+"] = { "<cmd>TaskWikiStart|<cr>", "start" },
    ["-"] = { "<cmd>TaskWikiStop<cr>", "stop" },
    ["h"] = { "<cmd>ColorizerToggle<cr>", "colorizer" },
    ["i"] = { "<cmd>VimwikiIndex1<cr>", "Notes" },
    ["f"] = { "<cmd>VimwikiIndex2<cr>", "RsyncNotes" },
    ["e"] = { "<cmd>FZF ~<cr>", "home fzf" },
    ["c"] = { "<cmd>noh<cr>", "Clear hlsearch" },

    t = {
        name = "taskwiki",
        a = { "<cmd>TaskWikiAnnotate|<cr>", "annotate" },
        C = { "<cmd>TaskWikiCalendar|<cr>", "calendar" },
        D = { "<cmd>TaskWikiDelete|<cr>", "delete" },
        e = { "<cmd>TaskWikiEdit|<cr>", "edit" },
        i = { "<cmd>TaskWikiInfo|<cr>", "info" },
        S = { "<cmd>TaskWikiStats|<cr>", "stats" },
        R = { "<cmd>TaskWikiStart|<cr>", "start" },
        r = { "<cmd>TaskWikiStop<cr>", "stop" },
    },

    a = {
        name = "actions",
        r = { "<cmd>retab<cr>", "retab" },
        t = { "a<C-r>=strftime('%I:%M:%S%p')<CR>", "Time" },
        d = { "a<C-r>=strftime('%a/%d/%b/%Y')<CR>", "Date" },
        s = { "<cmd>setlocal spell! spelllang=en_us<cr>", "Spell Check" },
        h = { "<cmd>new<cr>", "Hsplit" },
        v = { "<cmd>vnew<cr>", "Vsplit" },
    },

    r = {
        name = "resize",
        l = { "<cmd>vertical resize -2<cr>", "vsplit decrease" },
        h = { "<cmd>vertical resize +2<cr>", "vsplit increase" },
        k = { "<cmd>resize +2<cr>", "hsplit increase" },
        j = { "<cmd>resize -2<cr>", "hsplit decrease" },
        r = { "<c-w>=<cr>", "reset size" },
    },

    p = {
        name = "packer",
        c = { "<cmd>PackerCompile<cr>", "compile" },
        i = { "<cmd>PackerInstall<cr>", "install" },
        s = { "<cmd>PackerSync<cr>", "sync" },
        S = { "<cmd>PackerStatus<cr>", "status" },
        u = { "<cmd>PackerUpdate<cr>", "update" },
    },
}

which_key.setup(setup)
which_key.register(mappings, opts)
