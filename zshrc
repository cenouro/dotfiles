# vim: foldmethod=marker :

export DOTFILES=$HOME/.dotfiles
export INCLUDES=$HOME/

# Aliases.
#{{{
alias ls='ls --color=always -F'
alias grep='grep --color=always -Hn --exclude-dir="\.git/"'

alias zz='vim ~/.zshrc'
alias vv='vim ~/.vimrc'

alias cc='git commit'
alias ca='git commit --amend'
alias ll='git log'
#}}}

source $INCLUDES/zsh-completions/zsh-completions.plugin.zsh
source $INCLUDES/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $INCLUDES/zsh-history-substring-search/zsh-history-substring-search.zsh

# Completion configuration.
#{{{
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

autoload -U compinit && compinit
zmodload -i zsh/complist
#}}}

# Options.
#{{{
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

unsetopt menu_complete
unsetopt flowcontrol

setopt autocd
setopt prompt_subst
setopt always_to_end
setopt auto_menu
setopt complete_in_word
setopt append_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt share_history
setopt interactivecomments
#}}}

# Bindings.
#{{{
# Fix Home, Del and End keys. See man terminfo.
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
bindkey "${terminfo[kdch1]}" delete-char

# Map Up and Down arrow. Check plugin page for more info.
# tl/dr: run cat -v and type some stuff.
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey ' ' magic-space
#}}}

# Prompt (with git).
#{{{
function git_has_staged_changes() {
  git diff --cached --no-patch --no-color --quiet --
}

function git_branch_color() {
  $(git diff --cached --no-patch --no-color --quiet --)
  local has_staged_changes=$?

  $(git diff --no-patch --no-color --quiet --)
  local has_unstaged_changes=$?

  if (( has_unstaged_changes || has_staged_changes )); then
    echo 'red'
  else
    local untracked_files=$(git ls-files --other --exclude-standard)
    if [[ -n "${untracked_files}" ]]; then
      echo 'red'
    else
      echo 'green'
    fi
  fi
}

autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats ' :: [%F{$(git_branch_color)}%b%f]'
precmd(){
  vcs_info
}
PROMPT='%n@%m :: %~${vcs_info_msg_0_} %# '
#}}}

# Prevent C-S from freezing the screen (see Vim help for splits).
stty -ixon -ixoff

eval "$(dircolors ~/.dircolors)"

# PATH-related exports.
#{{{
export PATH="${HOME}/.npm-packages/bin:${PATH}"
# See manpath(1). tl;dr: system config will be appended after the colon.
export MANPATH="${HOME}/.npm-packages/share/man:"

# pip
export PATH="${HOME}/.local/bin:${PATH}"

export PATH="${HOME}/.rbenv/bin:${PATH}"
eval "$(rbenv init -)"
#}}}
