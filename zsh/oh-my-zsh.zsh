DEFAULT_USER="joey"
## Path to your oh-my-zsh installation.
ZSH=$HOME/.oh-my-zsh

export TERM=xterm-256color

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(colored-man-pages npm bundler rails ruby rvm vagrant gem adb bower gitfast github node pip)


# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# Preferred options: robbyrussell, soliah, kafeitu, gallifrey, nebirhos,
# philips, cypher, dstufft, risto, half-life, jbergantine, norm, essembeh
# fina (should be personalized more), murilasso, nebirhos
ZSH_THEME="agnoster"

if [[ "$(uname)" == "Darwin" ]]; then
  # OS X specific setup
  plugins+=(osx brew)
  export CLICOLOR=YES
else
  # ArchLinux specific setup
  plugins+=(archlinux)
  eval $(dircolors -b $HOME/.dircolors)
  # TODO(joey): Add extra archlinux config bits
fi

# initialize oh my zsh
source $ZSH/oh-my-zsh.sh
if [ -f $ZSH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source $ZSH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
if [ -f $ZSH/zsh-syntax-highlighting-filetypes/zsh-syntax-highlighting-filetypes.zsh ]; then
  source $ZSH/zsh-syntax-highlighting-filetypes/zsh-syntax-highlighting-filetypes.zsh
fi

unsetopt correct_all
setopt correct

