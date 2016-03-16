export PS1="[\H:`echo $YROOT_NAME`:\w\$(git branch 2>/dev/null | grep -e '\* ' | sed 's/^..\(.*\)/{\1}/') ]\$ "
export TERM=linux
alias urldecode='sed "s@+@ @g;s@%@\\\\x@g" | xargs -0 printf "%b"'

export TZ=America/Los_Angeles
