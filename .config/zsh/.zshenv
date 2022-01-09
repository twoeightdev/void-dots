# Environmental variables sets in here
typeset -U PATH
# Path to scripts
export PATH="$HOME/.local/bin:$PATH"

# XDG Base Directory
export XDG_LOCAL_HOME="$HOME/.local" # This sould be one of defaults

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

# Npm path
export PATH="$HOME/.config/node_modules/bin:$PATH"
export NPM_CONFIG_PREFIX="$HOME/.config/node_modules"
export NPM_CONFIG_USERCONFIG="$HOME/.config/npm/npmrc"
export NPM_CONFIG_CACHE="$HOME/.cache/npm"
export NPM_CONFIG_TMP="$XDG_RUNTIME_DIR/npm"

# Cargo
export CARGO_HOME="$XDG_DATA_HOME"/cargo

# Gradle
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle

# Default programs:
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"
export TERMINAL="st"
export BROWSER="qutebrowser"
export READER="zathura"
export FILE="lf"
export WM="dwm"

# Relocate variables
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"
export INPUTRC="$ZDOTDIR/inputrc"

# Misc
export HISTSIZE=1000
export SAVEHIST=1000
export HISTFILE="${ZDOTDIR}/.history"
export SUDO_ASKPASS="$HOME/.local/bin/dmenu-pass"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export _JAVA_AWT_WM_NONREPARENTING=1
export LESSHISTFILE="-"

# X11
#export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"

# Golang
export GOBIN="$XDG_LOCAL_HOME/bin"
export GOPATH="$XDG_DATA_HOME/go"

export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuchrc"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"

# Shell
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export WINEPREFIX="$XDG_DATA_HOME/wine"

# Fzf
export PATH="$HOME/.config/fzf/bin:$PATH"
export FZF_DEFAULT_OPTS='
--color fg:7,hl:4,fg+:15,bg+:0,hl+:3
--color pointer:1,info:8,spinner:3,header:8,prompt:4,marker:8
--info=inline
--height 60%
--cycle
--reverse
--pointer=" "
'
export FZF_DEFAULT_COMMAND="find . -mindepth 1 2>/dev/null"
export FZF_ALT_C_COMMAND="find . -mindepth 1 -type d 2>/dev/null"
export FZF_ALT_C_OPTS="$FZF_DEFAULT_OPTS --preview 'preview {}'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS --preview 'preview {}'"

# Less
export PAGER='less'
export LESS='-R'
export LESS_TERMCAP_mb=$'\e[1;34m'
export LESS_TERMCAP_md=$'\e[1;34m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[0;44;30m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[0;32m'
#export LESSOPEN="| /usr/bin/highlight -O ansi %s 2>/dev/null"

# Set Qt to use GTK theme
export QT_QPA_PLATFORMTHEME="gtk2"

# Theme
# GTK theme
export GTK_THEME="$(grep gtk-theme-name $GTK2_RC_FILES | cut -d'"' -f 2)"
gtk_theme_rc="$XDG_DATA_HOME/themes/$GTK_THEME/gtk-2.0/gtkrc"
[ -f "$gtk_theme_rc" ] && export GTK2_RC_FILES="$GTK2_RC_FILES:$gtk_theme_rc"; unset gtk_theme_rc

# Shortcuts
[ ! -f $XDG_CONFIG_HOME/shell/shrc ] && shortcuts >/dev/null 2>&1 &
