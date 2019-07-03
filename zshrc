fpath=(~/.zsh/functions/ $fpath)

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

setopt hist_ignore_dups
setopt share_history

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

[[ -f ~/.localrc.zsh ]] && . ~/.localrc.zsh
