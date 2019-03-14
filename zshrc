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

# fzf via Homebrew
if [ -e /usr/local/opt/fzf/shell/completion.zsh ]; then
  source /usr/local/opt/fzf/shell/key-bindings.zsh
  source /usr/local/opt/fzf/shell/completion.zsh
fi

_has(){
  command type "$1" > /dev/null 2>&1
}

# fzf + ag configuration
if _has fzf && _has ag; then
  export FZF_DEFAULT_COMMAND='ag --nocolor --hidden -g ""'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_DEFAULT_OPTS='
    --color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
    --color info:108,prompt:109,spinner:108,pointer:168,marker:168
  '
fi

autoload -U compinit
compinit
zstyle ':completion:*' list-colors ''

#------------------------------
# Variables
#
alias ls='ls -G'

# Bundler
alias bi='bundle install'
alias be='bundle exec'

# Git
alias g='git'
alias gd='git diff --color'
alias gds='git diff --color --staged'
alias ga='git add'
alias gap='git add -p'
alias gc='git commit'
alias gca='git commit --amend'
alias gco='git checkout'
alias gcop='git branch -a | peco | xargs git checkout'
alias gs='git status'
alias grm="git status | grep deleted | awk '{print \$2}' | xargs git rm"
alias gg='git grep -i -n'
alias gpsf='git push --force-with-lease'
alias gb='git branch'
alias gbm='git branch --merged'
alias gbd='git branch -d'

[[ -f ~/.localrc.zsh ]] && . ~/.localrc.zsh
