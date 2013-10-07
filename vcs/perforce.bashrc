function p {
  cd ~/code/perforce/$1
}

function pendlists {
  for list in "$(p4 changes | grep pending | grep atayarani)";do
    echo "$list"
  done
}

export P4EDITOR=/usr/bin/vim

#Aliases

