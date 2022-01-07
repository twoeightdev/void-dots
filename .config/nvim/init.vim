" autoinstall
if ! filereadable(system('echo -n "$XDG_CONFIG_HOME/nvim/autoload/plug.vim"'))
        echo "Downloading junegunn/vim-plug to manage plugins..."
        silent !mkdir -p $XDG_CONFIG_HOME/nvim/autoload/
        silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > $XDG_CONFIG_HOME/nvim/autoload/plug.vim
        autocmd VimEnter * PlugInstall
endif

" general settings
set nocompatible
filetype plugin on
syntax on
set encoding=utf-8
let mapleader=' '              " map <space> as leader key
set bg=light                   " set to dark if using colorscheme
"colorscheme gruvbox           " sets colorscheme
set clipboard+=unnamedplus     " enable pasting
set mouse=a                    " enable mouse scrolling
set hidden                     " this is recommended by coc
set nobackup                   " this is recommended by coc
set nowritebackup              " this is recommended by coc
set shortmess+=icw             " avoid message and prompts
set noswapfile                 " disable swaps
set nohlsearch                 " highlighted search
set noshowmode                 " disable INSERT mode showing up
set noruler                    " disable ruler
set laststatus=2               " needed to show custom statusline
set noshowcmd                  " disable line or column number
set nowrap                     " display long lines as just one line
set tabstop=4                  " insert 4 spaces for tab
set shiftwidth=4               " change number of space characters inserted for indention
set softtabstop=4
set expandtab                  " convert tabs to spaces
set splitbelow                 " horizontal splits will automatically set below
set splitright                 " vertical splits will automaticall set to the right
set number relativenumber      " show line numbers
set nolist
set wildmenu                   " enable wildmenu
set wildmode=longest:list,full " wildmenu style

set listchars=tab:>\ ,trail:-,nbsp:+,eol:$

" show invisibles
"set list
"set listchars=
"set listchars+=tab:.\
"set listchars+=trail:.
"set listchars+=extends:»
"set listchars+=precedes:«
"set listchars+=nbsp:░

" load plugins
call plug#begin(system('echo -n "~/.config/nvim/plugged"'))

Plug 'liuchengxu/vim-which-key'     " shows keybindings in popup
Plug 'tpope/vim-fugitive'           " git integration
Plug 'lukelbd/vim-tabline'          " simple buffer tabline
Plug 'Yggdroot/indentLine'          " indent guidelines
Plug 'ellisonleao/glow.nvim'        " preview directly in buffer
Plug 'ptzz/lf.vim'                  " lf file integration
 Plug 'voldikss/vim-floaterm'       " lf.vim dependency

call plug#end()

" reload programs when configuration is updated
    autocmd BufWritePost *Xresources,Xdefaults !xrdb %
    autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd
    autocmd BufWritePost init.vim,statusline.vim source $MYVIMRC
    autocmd BufWritePost bm-files,bm-dirs !shortcuts

" disables automatic commenting on newline:
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Automatically deletes all trailing whitespace and newlines at end of file on save. & reset cursor position
    autocmd BufWritePre * let currPos = getpos(".")
    autocmd BufWritePre * %s/\s\+$//e
    autocmd BufWritePre * %s/\n\+\%$//e
    autocmd BufWritePre *.[ch] %s/\%$/\r/e
    autocmd BufWritePre * cal cursor(currPos[1], currPos[2])

" source and load plugins configurations
source $HOME/.config/nvim/cfg/statusline.vim
source $HOME/.config/nvim/cfg/keymaps.vim
source $HOME/.config/nvim/cfg/whichkey.vim
source $HOME/.config/nvim/cfg/indentline.vim
source $HOME/.config/nvim/cfg/glow.vim
source $HOME/.config/nvim/cfg/filemanager.vim
