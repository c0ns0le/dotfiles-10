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

export PATH=$PATH:/opt/local/bin
export P4EDITOR=/usr/bin/vi
