#For PS1
function parse_git_branch {
    branch=$(git branch 2> /dev/null | awk '$1 ~ /\*/ {print $NF}' 2> /dev/null) || return
          echo $branch
}

function source_dotfiles {
    for script in $1/*; do

        # skip non-executable snippets
        [ -x "$script" ] || continue
        [ -f "$script" ] || continue

        # execute $script in the context of the current shell
        echo "Sourcing $script"
        . $script
    done
}

export PATH=$PATH:/opt/local/bin

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
