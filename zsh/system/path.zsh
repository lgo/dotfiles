# User system binaries
export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$DOTFILES/bin:$PATH"
# Installed maven on macOS to a specific location
export PATH="/opt/apache-maven/bin:$PATH"

# FIXME(joey): Deal with python setup.
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

export PATH="/usr/local/opt/node@18/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/node@18/lib"

export CPPFLAGS="-I/usr/local/opt/node@18/include"

# GCloud
source /Users/joey/google-cloud-sdk/path.zsh.inc