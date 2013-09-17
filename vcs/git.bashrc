function parse_git_branch {
    branch=$(git branch 2> /dev/null | awk '$1 ~ /\*/ {print $NF}' 2> /dev/null) || return
      echo $branch
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

function g {
      cd ~/code/git/$1
}

function git_conflicts {
      g $1
          grep -ir '< HEAD' *
              cd -
}

function git_review {
      branch=$(git branch 2> /dev/null | awk '$1 ~ /\*/ {print $NF}' 2> /dev/null) || return
          post-review --parent=$branch --branch=$branch
}

#Aliases
alias gco='git checkout'
