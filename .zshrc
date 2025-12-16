# ============================================================================
# PATH
# ============================================================================

export PATH="$HOME/.local/bin:$PATH"

# ============================================================================
# History
# ============================================================================

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt HIST_IGNORE_DUPS       # Don't record duplicates
setopt HIST_IGNORE_SPACE      # Don't record commands starting with space
setopt SHARE_HISTORY          # Share history between sessions
setopt APPEND_HISTORY         # Append instead of overwrite
setopt INC_APPEND_HISTORY     # Write immediately, not on exit

# ============================================================================
# Options
# ============================================================================

setopt AUTO_CD                # cd by typing directory name
setopt CORRECT                # Spelling correction for commands
setopt NO_BEEP                # No beeping
setopt INTERACTIVE_COMMENTS   # Allow comments in interactive shell

# ============================================================================
# Completion
# ============================================================================

autoload -Uz compinit && compinit

zstyle ':completion:*' menu select                       # Arrow key menu
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'     # Case insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # Colored completions
zstyle ':completion:*:descriptions' format '%B%d%b'     # Bold descriptions

# ============================================================================
# Key Bindings
# ============================================================================

bindkey -e                           # Emacs key bindings
bindkey '^[[A' history-search-backward    # Up arrow: search history
bindkey '^[[B' history-search-forward     # Down arrow: search history
bindkey '^[[H' beginning-of-line          # Home
bindkey '^[[F' end-of-line                # End
bindkey '^[[3~' delete-char               # Delete

# ============================================================================
# Aliases
# ============================================================================

# ls
alias ls='ls -G'
alias ll='ls -lAh'
alias la='ls -A'
alias l='ls -CF'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Safety
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

# Git
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'
alias glog='git log --oneline --graph --decorate -10'

# Shortcuts
alias v='nvim'
alias c='clear'
alias h='history'
alias t='tmux'

# Grep
alias grep='grep --color=auto'

# ============================================================================
# Prompt (Catppuccin Mocha)
# ============================================================================

autoload -Uz vcs_info
precmd() { vcs_info }

# Colors: lavender=#b4befe, peach=#fab387, green=#a6e3a1, mauve=#cba6f7
zstyle ':vcs_info:git:*' formats ' %F{#fab387}(%b)%f'

setopt PROMPT_SUBST
PROMPT='%F{#b4befe}%~%f${vcs_info_msg_0_} %F{#a6e3a1}>%f '

# ============================================================================
# Local Config (not tracked in dotfiles)
# ============================================================================

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
