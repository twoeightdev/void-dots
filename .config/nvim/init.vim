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
set bg=dark                    " set background
colorscheme gruvbox            " sets colorscheme
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
set tabstop=2                  " insert 4 spaces for tab
set shiftwidth=2               " change number of space characters inserted for indention
set expandtab                  " convert tabs to spaces
set splitbelow                 " horizontal splits will automatically set below
set splitright                 " vertical splits will automaticall set to the right
set number relativenumber      " show line numbers
set wildmenu                   " enable wildmenu
set wildmode=longest:list,full " wildmenu style

" show invisibles
set list
set listchars=
set listchars+=tab:.\
set listchars+=trail:.
set listchars+=extends:»
set listchars+=precedes:«
set listchars+=nbsp:░

" load plugins
call plug#begin(system('echo -n "~/.config/nvim/plugged"'))

Plug 'liuchengxu/vim-which-key'                                         " shows keybindings in popup
Plug 'tpope/vim-fugitive'                                               " git integration
Plug 'lukelbd/vim-tabline'                                              " simple buffer tabline
Plug 'Yggdroot/indentLine'                                              " indent guidelines

call plug#end()

" reload programs when configuration is updated
  autocmd BufWritePost *Xresources !xrdb %
  autocmd BufWritePost dunstrc !pkill dunst; dunst &
  autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd
  autocmd BufWritePost init.vim,statusline.vim source $MYVIMRC
  autocmd BufWritePost sc !shortcuts

" disables automatic commenting on newline:
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" source and load plugins configurations
source $HOME/.config/nvim/pconf/keymaps.vim
source $HOME/.config/nvim/pconf/whichkey.vim
source $HOME/.config/nvim/pconf/indentline.vim
source $HOME/.config/nvim/pconf/statusline.vim
