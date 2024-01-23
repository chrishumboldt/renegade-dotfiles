# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme.
ZSH_THEME="robbyrussell"

# Plugins.
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration.
# Commands.
alias do-git-thing="git fetch --all && git pull"
alias edit-aws='cd ~/.aws; vim'
alias edit-nvim='cd ~/.config/nvim; vim'
alias edit-starship='cd ~/.config; vim starship.toml'
alias edit-tmux='cd /home/[USER]; vim .tmux.conf'
alias edit-zsh-profile='cd /home/[USER]; vim .zshrc'
alias increase-node-memory="export NODE_OPTIONS=--max_old_space_size=8192"
alias ll='ls -la'
alias vim='nvim'

# Go to folders.
alias goto-dev='cd ~/Development'
alias goto-docs='cd ~/Documents'
alias goto-downloads='cd ~/Downloads'
alias goto-home='cd ~'
alias goto-notes='cd ~/Document/Notes'

# Some application exports.
export PATH=$PATH:/usr/local/go/bin

# NVM stuff.
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

autoload -U add-zsh-hook

load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

eval "$(starship init zsh)"
