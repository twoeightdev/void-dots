" Autoinstall
if ! filereadable(system('echo -n "$XDG_CONFIG_HOME/nvim/autoload/plug.vim"'))
        echo "Downloading junegunn/vim-plug to manage plugins..."
        silent !mkdir -p $XDG_CONFIG_HOME/nvim/autoload/
        silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > $XDG_CONFIG_HOME/nvim/autoload/plug.vim
        autocmd VimEnter * PlugInstall
endif

" General settings
set nocompatible
filetype plugin on
syntax on
set encoding=utf-8
let mapleader=' '                           " Map <space> as leader key
set bg=light                                " Set to dark if using colorscheme
set clipboard+=unnamedplus                  " Enable pasting
set mouse=a                                 " Enable mouse scrolling
set hidden                                  " This is recommended by coc
set nobackup                                " This is recommended by coc
set nowritebackup                           " This is recommended by coc
set shortmess+=icw                          " Avoid message and prompts
set noswapfile                              " Disable swaps
set nohlsearch                              " Highlighted search
set noshowmode                              " Disable INSERT mode showing up
set noruler                                 " Disable ruler
set laststatus=2                            " Needed to show custom statusline
set noshowcmd                               " Disable line or column number
set nowrap                                  " Display long lines as just one line
set tabstop=4                               " Insert 4 spaces for tab
set shiftwidth=4                            " Change number of space characters inserted for indention
set softtabstop=4
set expandtab                               " Convert tabs to spaces
set splitbelow                              " Horizontal splits will automatically set below
set splitright                              " Vertical splits will automaticall set to the right
set number relativenumber                   " Show line numbers
set nolist
set wildmenu                                " Enable wildmenu
set wildmode=longest:list,full              " Wildmenu style
set listchars=tab:>\ ,trail:-,nbsp:+,eol:$
set rtp+=~/.config/fzf

" Show invisibles
"set list
"set listchars=
"set listchars+=tab:.\
"set listchars+=trail:.
"set listchars+=extends:»
"set listchars+=precedes:«
"set listchars+=nbsp:░

" Load plugins
call plug#begin(system('echo -n "~/.config/nvim/plugged"'))

Plug 'liuchengxu/vim-which-key'     " Shows keybindings in popup
Plug 'tpope/vim-fugitive'           " Git integration
Plug 'lukelbd/vim-tabline'          " Simple buffer tabline
Plug 'Yggdroot/indentLine'          " Indent guidelines
Plug 'chrisbra/Colorizer'           " Color highlighter
Plug 'junegunn/fzf.vim'             " Fuzzy finder

call plug#end()

" Reload programs when configuration is updated
    autocmd BufWritePost *Xresources,Xdefaults,xresources,xcolor !xrdb %
    autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd
    autocmd BufWritePost dunstrc !pkill dunst; dunst &
    autocmd BufWritePost init.vim,statusline.vim source $MYVIMRC
    autocmd BufWritePost bm-files,bm-dirs !shortcuts

" Disables automatic commenting on newline:
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Automatically deletes all trailing whitespace and newlines at end of file on save. & reset cursor position
    autocmd BufWritePre * let currPos = getpos(".")
    autocmd BufWritePre * %s/\s\+$//e
    autocmd BufWritePre * %s/\n\+\%$//e
    autocmd BufWritePre *.[ch] %s/\%$/\r/e
    autocmd BufWritePre * cal cursor(currPos[1], currPos[2])

" Source and load plugins configurations
source $HOME/.config/nvim/cfg/statusline.vim
source $HOME/.config/nvim/cfg/visualcolors.vim
source $HOME/.config/nvim/cfg/colorizer.vim
source $HOME/.config/nvim/cfg/fzf.vim
source $HOME/.config/nvim/cfg/keymaps.vim
source $HOME/.config/nvim/cfg/whichkey.vim
source $HOME/.config/nvim/cfg/indentline.vim
