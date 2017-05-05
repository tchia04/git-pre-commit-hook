#!/bin/bash 


echo "Enable git templates"
git config --global init.templatedir '~/.git-templates'

echo -e "\nCreate a directory (~/.git-templates/hooks) to hold the global hoooks"
mkdir -p ~/.git-templates/hooks
cp pre-commit  ~/.git-templates/hooks
cp pre-push ~/.git-templates/hooks
cp check_file_size ~/.git-templates/hooks
cp protect_default_branch ~/.git-templates/hooks

#DIR="~/" # for production
#DIR="/tmp/" # for testing
echo -e "\nFind all the git repos under $DIR directory"
#ALL_GIT_REPOS=$(find ~/ -name .git  | sed 's/\.git//g')
ALL_GIT_REPOS=$(find /tmp/ -name .git  | sed 's/\.git//g')

for repo in $ALL_GIT_REPOS; do
  echo -e "\nRunning git init on $repo under $DIR to copy the global hook";
  cd $repo; git init;
done;


# one liner
#for repo in `find ~/ -name .git  | sed 's/\.git//g'`; do cd $repo; git init; done

echo -e "\n\nFor more information, see https://coderwall.com/p/jp7d5q/create-a-global-git-commit-hook"
