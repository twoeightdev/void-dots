local fn = vim.fn

-- Automatically installer packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocmd plugins.lua
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't get error on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "single" }
        end,
    },
}

-- Plugins
return packer.startup(function(use)
    use "wbthomason/packer.nvim"                        -- Have packer manage itself
    --use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"                         -- Lua functions used by plugins
    use "windwp/nvim-autopairs"                         -- Integrates with both cmp & treesitter
    use "lewis6991/gitsigns.nvim"                       -- Required by feline
    use "feline-nvim/feline.nvim"                       -- Statusline
    use "~/.config/fzf"                                 -- Fzf path
    use "junegunn/fzf.vim"                              -- Fuzzy finder
    use "lukas-reineke/indent-blankline.nvim"           -- Indent guidelines
    use "kyazdani42/nvim-tree.lua"                      -- File explorer
    use "folke/which-key.nvim"                          -- Shows command like emacs
    use "norcalli/nvim-colorizer.lua"                   -- Color highlighter
    use "terrortylor/nvim-comment"                      -- Commenter
    use "eddyekofo94/gruvbox-flat.nvim"                 -- Main theme

    -- Cmp
    use "hrsh7th/nvim-cmp"                              -- Completion plugin
    use "hrsh7th/cmp-path"                              -- Path completions
    use "saadparwaiz1/cmp_luasnip"                      -- Snippet completions

    -- Snippet
    use "L3MON4D3/LuaSnip"
    use "rafamadriz/friendly-snippets"

    -- Note taking
    use "vimwiki/vimwiki"                               -- Note taking
    use "tools-life/taskwiki"                           -- Taskwarrior
    use "mattn/calendar-vim"                            -- Calendar for vimwiki

    -- Automatically setup your configuration after cloning packer.nvim
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
