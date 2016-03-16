
This repo contains a client side pre-commit and pre-push script that prevent you from commiting to the default branch which usually it's the master directly.

It also prevent you from pushing your default branch to the origin repo.

It forces you to get into the good habit of always work on a branch and open a pull request to merge into default branch which allows code reviews to happend.

If the default branch changes, the script will automatically switch to the new default branch without any script changes

This script setups the pre-commit and pre-push hook for both the existing git repo under your home directory and any future new repo you clone
