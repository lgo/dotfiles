# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`

# Full RC-file reload.
alias reload!='. ~/.zshrc'
# get ip
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
# Always fill create directors recursively.
alias mkdir='mkdir -p'
alias grep="${aliases[grep]:-grep} --color=auto"

targz() { tar -zcvf $1.tar.gz $1; }

untargz() { tar -zxvf $1; }