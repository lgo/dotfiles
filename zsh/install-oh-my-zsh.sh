#!/bin/bash

[[ ! -d "$HOME/.oh-my-zsh" ]] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Also install evalcache, used to speed up `eval` for env managers.
[[ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/evalcache" ]] git clone https://github.com/mroth/evalcache ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/evalcache

# Install fzf
/usr/local/opt/fzf/install --no-bash --bin