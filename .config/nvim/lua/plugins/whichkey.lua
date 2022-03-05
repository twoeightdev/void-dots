local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local setup = {
    plugins = {
        marks = false,          -- shows a list of your marks on ' and `
        registers = true,       -- shows registers on " in N or <c-r> in I mode
        spelling = {
            enabled = true,     -- show spelling suggestion with <leader>z
            suggestions = 20,   -- suggestions limit
        },
        presets = {
            operators = false,      -- show help for operator d, y, etc
            motions = true,         -- help for motions
            text_objects = true,    -- help for triggered after an operator
            windows = true,         -- default bindings on <c-w>
            nav = true,             -- misc bindings to work with windows
            z = true,               -- for folds, spelling etc with prefix z
            g = true,               -- for prefixed with g
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
        margin = { 1, 0, 1, 0 },    -- [top, right, bottom, left]
        padding = { 2, 0, 2, 0 },   -- [top, right, bottom, left]
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3,                    -- spacing between columns
        align = "left",                 -- align columns left, center or right
    },
    ignore_missing = true,  -- hide mappings without specific label
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
    show_help = true,       -- help message on the command line in popup
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
    ["h"] = { "<cmd>ColorizerToggle<cr>", "colorizer" },
    ["i"] = { "<cmd>WikiIndex<cr>", "notes" },
    ["j"] = { "<cmd>WikiJournal<cr>", "journal" },
    ["e"] = { "<cmd>FZF ~<cr>", "home fzf" },
    ["c"] = { "<cmd>CalendarVR<cr>", "calendar" },

    w = {
        name = "wiki",
        f = { "<cmd>WikiFzfPages<cr>", "fzf pages" },
        e = { "<cmd>WikiExport<cr>", "export pdf" },
        g = { "<cmd>WikiJournalIndex<cr>", "generate journal" },
        n = { "<cmd>WikiJournal<cr>", "make diary" },
        d = { "<cmd>WikiPageDelete<cr>", "delete" },
        r = { "<cmd>WikiPageRename<cr>", "rename" },
        t = { "<cmd>WikiPageToc<cr>", "create toc" },
    },

    a = {
        name = "actions",
        c = { "<cmd>noh<cr>", "clear hlsearch" },
        r = { "<cmd>retab<cr>", "retab" },
        t = { "a<c-r>=strftime('Time:<%I:%M-%p>')<cr>", "diarytime" },
        T = { "a<c-r>=strftime('<%I:%M-%p>')<cr>", "time" },
        d = { "a<c-r>=strftime('%a/%d/%b/%Y')<cr>", "date" },
        D = { "a<c-r>=strftime('[%Y-%m-%d]')<cr>", "tododate" },
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
