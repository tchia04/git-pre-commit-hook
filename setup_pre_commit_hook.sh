#!/bin/sh


echo "Enable git templates"
git config --global init.templatedir '~/.git-templates'

echo "Create a directory to hold the global hoooks"
mkdir -p ~/.git-templates/hooks
cp pre-commit  ~/.git-templates/hooks
cp pre-push ~/.git-templates/hooks

echo "Find all the git repos under your home directory"
ALL_GIT_REPOS=$(find ~/ -name .git  | sed 's/\.git//g')

for repo in $ALL_GIT_REPOS; do
  echo "running git init on $repo to copy the global hook";
  cd $repo; git init;
done;


# one liner
#for repo in `find ~/ -name .git  | sed 's/\.git//g'`; do cd $repo; git init; done

echo "For more information, see https://coderwall.com/p/jp7d5q/create-a-global-git-commit-hook"
