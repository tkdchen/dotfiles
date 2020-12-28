# vim: foldmethod=marker ts=4 sw=4 autoindent
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

alias vim=nvim

powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/share/powerline/bash/powerline.sh

# User specific environment
PATH="$HOME/.local/bin:$HOME/bin:$HOME/node_modules/.bin:$HOME/.cargo/bin:$HOME/go/bin:$PATH"
export PATH

export GOPATH=$HOME/go
export GO111MODULE=on

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

export REQUESTS_CA_BUNDLE=/etc/pki/tls/certs/ca-bundle.crt
export GIT_EDITOR=nvim

alias ff='firefox'

alias grep='grep --exclude=*.pyc --exclude=.git --exclude=.venv --color'

#alias docker=podman

# {{{ Git alias
alias gita='git add'
alias gitd='git diff'
alias gits='git status'
alias git-stats-commit-count-by-author='git log --format="%an" | sort | uniq -c | sort -k1 -n --reverse'
alias git-show-top-patch='git log -p -1'
alias git-sync-with-upstream='git checkout master && git fetch upstream && git merge upstream/master'
# }}}

alias pacup='sudo dnf update'
alias paci='sudo dnf install'
alias pacq='sudo dnf repoquery'

# {{{ Git alias
alias di='docker images'
# }}}

alias tox='tox --workdir /tmp/tox-$(basename $PWD)'

alias my-bodhi-updates='bodhi updates query --user cqi'

alias venvnew='${pybin:-python3} -m venv .venv'
alias venvdrop='[ -e ".venv" ] && rm -r .venv'
alias venvon='source ./.venv/bin/activate'
alias venvoff='deactivate'
alias venvi='python3 -m pip install'

alias login-aliyun-vm='ssh root@123.57.27.187'
alias dmenu_go='dmenu -fn "DejaVu Sans Mono-14"'

alias st='st -f "FuraCode Nerd Font Mono-14"'

function g-sync-up-with-upstream
{
    local -r branch=${1:-master}
    git fetch upstream
    git checkout "$branch"
    git merge "upstream/$branch"
}

function q-connect-network
{
    local -r networkname=$(nmcli --fields name c show | sed '1 d' | sed -e 's/ \+$//' | dmenu_go)
    [[ -n "$networkname" ]] && nmcli --ask c up "$networkname"
}

function q-notes-open
{
    local -r notefile=$(find $HOME/Documents/My/notes/ -name "*.org" -exec basename '{}' \; | dmenu_go)
    [[ -n "$notefile" ]] && emacs "$HOME/Documents/My/notes/$notefile" &
}

function pypi-mirrors-list
{
    declare -a fast_pypi_mirros
    fast_pypi_mirros=(
        https://pypi.tuna.tsinghua.edu.cn/simple
        https://mirrors.aliyun.com/pypi/simple/
        https://pypi.doubanio.com/simple
        https://mirrors.cloud.tencent.com/pypi/simple
    )
    echo "${fast_pypi_mirros[@]}" | dmenu_go
}
