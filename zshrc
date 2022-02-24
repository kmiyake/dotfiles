export LC_ALL=en_US.UTF-8

autoload colors
colors
setopt prompt_subst

autoload -Uz vcs_info

local fmt_branch="(%b%f%u%c) "
local fmt_action="%a"
local fmt_unstaged="[%F{161}U%f]"
local fmt_staged="[%F{118}S%f]"

zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr   "${fmt_unstaged}"
zstyle ':vcs_info:git:*' stagedstr     "${fmt_staged}"
zstyle ':vcs_info:git:*' actionformats "${fmt_branch}${fmt_action}"
zstyle ':vcs_info:git:*' formats       "${fmt_branch}"
zstyle ':vcs_info:*'     nvcsformats   ""

precmd() {
  LANG=jp_JP.UTF-8 vcs_info
}

function rbenv_prompt_info() {
  local ruby_version version
  ruby_version=$(rbenv version 2> /dev/null) || return
  version=$(echo "$ruby_version" | sed 's/[ \t].*$//')
  echo "[$version]"
}

if [[ -n $SSH_CONNECTION ]]; then
  PROMPT='%m:%~%% '
else
  PROMPT='
%~
%{$fg[red]%}$(rbenv_prompt_info) %{$fg[white]%}${vcs_info_msg_0_}$ '
fi

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

# setopt hist_ignore_dups
# setopt share_history

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey -e
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey '^R' history-incremental-search-backward

autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

autoload -U compinit
compinit
zstyle ':completion:*' list-colors ''

setopt nonomatch

[[ -f ~/.localrc.zsh ]] && . ~/.localrc.zsh
