# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`

# Full RC-file reload.
alias reload!='. ~/.zshrc'
# get ip
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
# Modern ls replacement.
alias ls='eza --group-directories-first --icons=auto'
alias ll='eza -l --group-directories-first --icons=auto'
alias la='eza -la --group-directories-first --icons=auto'
alias cat='bat'
# Always fill create directors recursively.
alias mkdir='mkdir -p'
alias grep="${aliases[grep]:-grep} --color=auto"

targz() { tar -zcvf $1.tar.gz $1; }

untargz() { tar -zxvf $1; }
