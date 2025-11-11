export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true

fpath=($DOTFILES/functions $fpath)

autoload -U $DOTFILES/functions/*(:t)

# Keep history on disk across shells while avoiding secrets and duplicate
# spam. We store history under XDG_STATE_HOME (defaults to ~/.local/state) so
# it stays out of the repo and inside Time Machine backups.
_dotfiles_histdir="${XDG_STATE_HOME:-$HOME/.local/state}/zsh"
mkdir -p "$_dotfiles_histdir"
HISTFILE="$_dotfiles_histdir/history"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY            # always append rather than clobber
setopt SHARE_HISTORY             # share history across tmux / terminal panes
setopt INC_APPEND_HISTORY_TIME   # write history incrementally with timestamps
setopt HIST_IGNORE_ALL_DUPS      # drop duplicate commands anywhere in history
setopt HIST_IGNORE_SPACE         # skip commands that start with a leading space
setopt HIST_REDUCE_BLANKS        # trim superfluous whitespace before saving
setopt HIST_VERIFY               # confirm a recalled command before running
setopt HIST_SAVE_NO_DUPS         # never write the same command twice
setopt HIST_FIND_NO_DUPS         # prevent `history` from showing duplicates
setopt EXTENDED_HISTORY          # store timestamps alongside each command

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

unsetopt beep

setopt autocd extendedglob nomatch notify

setopt NO_BG_NICE # don't nice background tasks
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS # allow functions to have local traps
setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD
setopt IGNORE_EOF

# # don't expand aliases _before_ completion has finished
# #   like: git comm-[tab]
# setopt complete_aliases

bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
bindkey '^[[5D' beginning-of-line
bindkey '^[[5C' end-of-line
bindkey '^[[3~' delete-char
bindkey '^?' backward-delete-char

unset _dotfiles_histdir
