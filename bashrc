function parse_git_branch {
  branch=$(git branch 2> /dev/null | awk '$1 ~ /\*/ {print $NF}' 2> /dev/null) || return
  echo $branch
}

function review {
    branch=$(git branch 2> /dev/null | awk '$1 ~ /\*/ {print $NF}' 2> /dev/null) || return
    post-review --parent=$branch --branch=$branch
}

function git_prompt {
    branch=$(git branch 2> /dev/null | awk '$1 ~ /\*/ {print $NF}' 2> /dev/null) || return
    export PS1="%n ($branch) %~ >"
}

function gpush {
    branch=$(git branch 2> /dev/null | awk '$1 ~ /\*/ {print $NF}' 2> /dev/null) || return
    /usr/bin/git push origin $branch
}

function gpull {
    branch=$(git branch 2> /dev/null | awk '$1 ~ /\*/ {print $NF}' 2> /dev/null) || return
    /usr/bin/git pull origin $branch
}

function p {
    cd ~/code/perforce/$1
}

function g {
    cd ~/code/git/$1
}

function git_conflicts {
    g $1
    grep -ir '< HEAD' *
    cd -
}
export PATH=$PATH:/opt/local/bin
export P4EDITOR=/usr/bin/vi
export PS1="[\\u@\h \\W] (\$(parse_git_branch))\$ "

#Aliases
if [ $(uname) == 'Darwin' ]; then
    alias ls='ls -G'
    alias ll='ls -lG'
    alias lla='ls -laG'
else
    alias ls='ls --color'
    alias ll='ls -l --color'
    alias lla='ls -la --color'
fi
    
alias grep='grep --color'
alias ln='ln -sin'
alias gco='git checkout'
