# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`

# FIXME(joey): Increased startup speed, assume gls is loaded.
# if $(gls &>/dev/null)
# then
  alias ls="gls -F --color"
  alias l="gls -lAh --color"
  alias ll="gls -l --color"
  alias la='gls -A --color'
# fi

# Full RC-file reload.
alias reload!='. ~/.zshrc'
# get ip
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
# Always fill create directors recursively.
alias mkdir='mkdir -p'

targz() { tar -zcvf $1.tar.gz $1; }

untargz() { tar -zxvf $1; }