# colors
setopt extended_history         # record timestamp of command in HISTFILE
setopt hist_expire_dups_first   # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_all_dups     # Ignore all duplicates in history
setopt share_history            # Shares all history

# automaticly escape urls special characters
autoload -Uz url-quote-magic bracketed-paste-magic
zle -N self-insert url-quote-magic
zle -N bracketed-paste bracketed-paste-magic

# git prompt with branch name
function precmd {
    if [[ "$NEW_LINE" = true ]] then
        print ""
    else
        NEW_LINE=true
    fi
    vcs_info
}

autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats 'on %F{red} %F{red}%b'

setopt PROMPT_SUBST
PROMPT='%F{yellow}%1d %F{white}≻≻≻ %F{green}${vcs_info_msg_0_}%f '

# exclude garbage in history
function hist() {
  [[ "$#1" -lt 7 \
    || "$1" = "run-help "* \
    || "$1" = "cd "* \
    || "$1" = "man "* \
    || "$1" = "h "* \
    || "$1" = "~ "* ]]
  return $(( 1 - $? ))
}

#setopt correct_all      # autocorrect commands
setopt completealiases
setopt auto_menu         # automatically use menu completion
setopt always_to_end     # move cursor to end if word had one match
setopt complete_in_word  # completion from both ends
autoload -Uz compinit && compinit -u
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' ignored-patterns '.'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
_comp_options+=(globdots) # include hidden files

# vi mode
bindkey -v
export KEYTIMEOUT=1
local cursor_insert="\e[4 q"
local cursor_normal="\e[2 q"

# change cursor shape for different vi modes.
function zle-keymap-select() {
  if [[ $KEYMAP == vicmd || $1 == 'block' ]]; then
    print -n $cursor_normal
  elif [[ $KEYMAP == main || $KEYMAP == viins || -z $KEYMAP || $1 == 'beam' ]]; then
    print -n $cursor_insert
  fi
}

function zle-line-init() {
  zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -v` has been set elsewhere)
  print -n $cursor_insert
}

zle -N zle-keymap-select
zle -N zle-line-init

print -n $cursor_insert # use beam shape cursor on startup.
function preexec() { print -n $cursor_insert; } # use beam shape cursor for each new prompt.

# use vim keys in tab complete menu:
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# misc
set -k               # allows comments in interactive shell
setopt auto_cd       # cd by just typing the directory name
setopt extendedglob  # additional syntax for filename generation
[ ! -f "$ZDOTDIR/sc.sh" ] && shortcuts
source $ZDOTDIR/sc.sh
source $ZDOTDIR/aliasrc 2>/dev/null

function command_not_found_handler() {
  print -P "not found: %F{red}$0%f" >&2
  return 127
}

# pluginz
# fzf
if [ ! -d ~/.config/fzf ]; then
  git clone --depth 1 https://github.com/junegunn/fzf ~/.config/fzf
  ~/.config/fzf/install --no-bash --no-fish --xdg --all
fi

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

# Rebind fzf alt+c to alt+x
bindkey '\ex' fzf-cd-widget

# find file with fzf and open with editor
se() {
  file="$(find "$HOME" -type f,l | fzf)"
  [ "$file" ] && fzfeditor "$file"
}
# cd to directory in home
gdc() {
  cd "$(find -type d | fzf)"
}
# cd to directory in /media/data
gdd() {
  cd "$(find "/media/data/" -type d | fzf)"
}

# syntax highlighting
if [ ! -d ~/.config/zsh/zplug/zsh-syntax-highlighting ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.config/zsh/zplug/zsh-syntax-highlighting
fi
source ~/.config/zsh/zplug/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[alias]='fg=blue'
ZSH_HIGHLIGHT_STYLES[assign]='none'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='none'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=blue'
ZSH_HIGHLIGHT_STYLES[command]='fg=blue'
ZSH_HIGHLIGHT_STYLES[commandseparator]='none'
ZSH_HIGHLIGHT_STYLES[default]='none'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=green'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[function]='fg=blue'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=blue'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=green'
ZSH_HIGHLIGHT_STYLES[links]='none'
ZSH_HIGHLIGHT_STYLES[path]='none'
ZSH_HIGHLIGHT_STYLES[path_approx]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[path_prefix]='none'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=blue'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=blue'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=green'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
