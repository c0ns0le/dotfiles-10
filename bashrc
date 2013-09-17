function source_dotfiles {
    for script in $1/*; do

        # skip non-executable snippets
        [ -x "$script" ] || continue
        [ -f "$script" ] || continue

        # execute $script in the context of the current shell
        . $script
    done
}

export PATH=$PATH:/opt/local/bin

#PS1 is dependent on git.bashrc
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


