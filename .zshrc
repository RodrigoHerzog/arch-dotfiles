# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Directory to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit if needed
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

# Source/Load Zinit
source "${ZINIT_HOME}/zinit.zsh"

# Setting Catppuccin theme to LS_COLORS
export LS_COLORS="$(vivid generate catppuccin-mocha)"

# Install Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Install Autocompletion
zinit light zsh-users/zsh-completions
# Load completions
autoload -U compinit && compinit
# Enable cache on completions
zinit cdreplay -q
# Make completions case insensitive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# Enable color on completions
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Install fzf on tab completions
zinit light Aloxaf/fzf-tab
# Disable default zsh completion
zstyle ':completion:*' menu no
# Enable fzf when cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
# Enable fzf when zoxide
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
# Enable eza on fzf when cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --group-directories-first --icons=always --color=always $realpath'
# Enable eza on fzf when zoxide
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --group-directories-first --icons=always --color=always $realpath'

# Load Catppuccin Mocha Theme for Zsh Syntax Highlighting
source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh
# Install Syntax Highlighting
zinit light zsh-users/zsh-syntax-highlighting
# Remove underline from paths and path separators
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]='fg=blue'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=blue'
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='fg=magenta'

# Install Autosugestions
zinit light zsh-users/zsh-autosuggestions

# Install snippets from OhMyZsh Plugins URL
zinit snippet OMZP::command-not-found

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Setup fzf shell integration
eval "$(fzf --zsh)"
# Setup zoxide shell integration
eval "$(zoxide init --cmd cd zsh)"

# Setup history
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Keybindings

# Setup EMACS Keybindings
bindkey -e

# Setup search on history with prefix context
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Aliases

alias ls='eza --icons=always --color=always --group-directories-first'
alias lsa='eza -a --icons=always --color=always --group-directories-first'

alias ll='eza -1 --icons=always --color=always --group-directories-first'
alias lla='eza -a -1 --icons=always --color=always --group-directories-first'

alias ld='eza -l --icons=always --color=always --group-directories-first'
alias lda='eza -a -l --icons=always --color=always --group-directories-first'

alias lt='eza -T --icons=always --color=always --group-directories-first'
alias lta='eza -a -T --icons=always --color=always --group-directories-first'


alias cls='clear'

# Add to Shell PATH

#
