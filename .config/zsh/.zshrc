# Colors
setopt extended_history         # Record timestamp of command in HISTFILE
setopt hist_expire_dups_first   # Delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_all_dups     # Ignore all duplicates in history
setopt share_history            # Shares all history
stty stop undef                 # Disable ctrl-s to freeze terminal

# Automaticly escape urls special characters
autoload -Uz url-quote-magic bracketed-paste-magic
zle -N self-insert url-quote-magic
zle -N bracketed-paste bracketed-paste-magic

# Git prompt with branch name
function precmd {
    if [[ "$NEW_LINE" = true ]] then
        print ""
    else
        NEW_LINE=true
    fi
    vcs_info
}

autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats 'on %F{white} %F{red}%b'

setopt PROMPT_SUBST
PROMPT='%F{yellow}%1d %F{white} %F{green}${vcs_info_msg_0_}%f '

# Exclude garbage in history
function hist() {
  [[ "$#1" -lt 7 \
    || "$1" = "run-help "* \
    || "$1" = "cd "* \
    || "$1" = "man "* \
    || "$1" = "h "* \
    || "$1" = "~ "* ]]
  return $(( 1 - $? ))
}

#setopt correct_all      # Autocorrect commands
setopt completealiases
setopt auto_menu         # Automatically use menu completion
setopt always_to_end     # Move cursor to end if word had one match
setopt complete_in_word  # Completion from both ends
autoload -Uz compinit && compinit -u
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' ignored-patterns '.'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
_comp_options+=(globdots) # Include hidden files

# Vi mode
bindkey -v
export KEYTIMEOUT=1
local cursor_insert="\e[4 q"
local cursor_normal="\e[2 q"

# Change cursor shape for different vi modes
function zle-keymap-select() {
  if [[ $KEYMAP == vicmd || $1 == 'block' ]]; then
    print -n $cursor_normal
  elif [[ $KEYMAP == main || $KEYMAP == viins || -z $KEYMAP || $1 == 'beam' ]]; then
    print -n $cursor_insert
  fi
}

function zle-line-init() {
  zle -K viins # Initiate `vi insert` as keymap (can be removed if `bindkey -v` has been set elsewhere)
  print -n $cursor_insert
}

zle -N zle-keymap-select
zle -N zle-line-init

print -n $cursor_insert # Use beam shape cursor on startup
function preexec() { print -n $cursor_insert; } # Use beam shape cursor for each new prompt

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Use vim keys in tab complete menu:
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Misc
set -k               # Allows comments in interactive shell
setopt auto_cd       # Type directory name to cd
setopt extendedglob  # Additional syntax for filename generation

# Load aliases and shortcuts if existent
[ -f "$XDG_CONFIG_HOME/shell/shrc" ] && source "$XDG_CONFIG_HOME/shell/shrc"
[ -f "$XDG_CONFIG_HOME/shell/aliasrc" ] && source "$XDG_CONFIG_HOME/shell/aliasrc"
[ -f "$XDG_CONFIG_HOME/shell/zshdirrc" ] && source "$XDG_CONFIG_HOME/shell/zshdirrc"

function command_not_found_handler() {
  print -P "not found: %F{red}$0%f" >&2
  return 127
}

# Fzf
if [ ! -d ~/.config/fzf ]; then
  git clone --depth 1 https://github.com/junegunn/fzf ~/.config/fzf
  ~/.config/fzf/install --no-bash --no-fish --xdg --all
fi

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

# Rebind fzf alt+c to alt+x
bindkey '\ex' fzf-cd-widget

# Rebind fzf ctrl+t to alt+z
bindkey '\ez' fzf-file-widget

# Editor + fzf
e() { fzf | xargs -r $EDITOR ;}

# cd to any directory in $HOME
q() { cd "$(find $HOME -type d 2>/dev/null | fzf)" && ls -a ;}

# cd to any directory in /media
qm() { cd "$(find "/media/" -type d 2>/dev/null | fzf)" && ls -a ;}

# Syntax highlighting
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
