
# git-pre-commit-hook 
This repo contains two client side pre-commit scripts that help you do the following:

* Block you from commiting to the default branch directly which usually it's the master. 
  This make check make sure you uses the best practice of commit/push to a separate branch and 
  opening a pull request to get peer review before it can be merged to default_branch/master

It also prevent you from pushing your default branch to the origin repo.

It forces you to get into the good habit of always work on a branch and open a pull request to merge into default branch which allows code reviews to happend.

If the default branch changes, the script will automatically switch to the new default branch without any script changes

This script setups the pre-commit and pre-push hook for both the existing git repo under your home directory and any future new repo you clone


* Block you from commiting a file that is too big that would prevent git push to work
  If you had committed a large file which is defined as over 100 MB and you want to push to github, the push will fail.
  Then it become very difficult to clean up since it's embedded in the history.

  One option is to use "git filter-branch" like described at https://help.github.com/articles/removing-sensitive-data-from-a-repository/
  Another option is https://rtyley.github.io/bfg-repo-cleaner/
  
  If the large file is blocked from being commited in the first place, then you will save you couple hours of time

## Configuration
If you would like to use one check but not the other, you can comment it out in the pre-commit script before running setup_pre_commit_hook.sh

pre-commit
<code>
fucntion Protect_Default_Branch
fucntion Check_File_Size
....
...
...
....
# Comment / Uncomment the following to suit your need
Check_Default_Branch
Check_File_Size

</code>

## Sample Run from protect_default_branch

tonychia@blueapple /tmp/CodeDeploy_Test (master) $ git commit -m "commit to master is a bad idea"
Direct push to the master branch is not allowed
tonychia@blueapple /tmp/CodeDeploy_Test (master) $


## Sample Run from check_file_size

### When added file is smaller than 50mb
tonychia@blueapple /tmp/git-pre-commit-hook (check_file_size) $ ls -l all_keys.txt
-rw-r--r--  1 tonychia  staff  48316613 May  4 17:24 all_keys.txt
tonychia@blueapple /tmp/git-pre-commit-hook (check_file_size) $ git add all_keys.txt
tonychia@blueapple /tmp/git-pre-commit-hook (check_file_size) $ git status
On branch check_file_size
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	new file:   all_keys.txt

tonychia@blueapple /tmp/git-pre-commit-hook (check_file_size) $ git commit -m "adding. smaller than 50mb"
+ bash ./check_file_size

Checking to see if any of the changed files exceed the 50 MB limit
Checking all_keys.txt
  47188 kb is less than 50 mb.safe for git commit
[check_file_size 082cfa2] adding. smaller than 50mb
git pus 1 file changed, 2438585 insertions(+)
 create mode 100644 all_keys.txt
htonychia@blueapple /tmp/git-pre-commit-hook (check_file_size) $ git status
On branch check_file_size
nothing to commit, working tree clean

### When changed file(delete) is smaller than 50 MB
tonychia@blueapple /tmp/git-pre-commit-hook (check_file_size) $ git commit -m "remove all_keys.txt less than 50mb"
+ bash ./check_file_size

Checking to see if any of the changed files exceed the 50 MB limit
Checking all_keys.txt
du: all_keys.txt: No such file or directory
   kb is less than 50 mb.safe for git commit
[check_file_size 3c61438] remove all_keys.txt less than 50mb
 1 file changed, 2438585 deletions(-)
 delete mode 100644 all_keys.txt
 tonychia@blueapple /tmp/git-pre-commit-hook (check_file_size) $ git status
 On branch check_file_size
 nothing to commit, working tree clean

### When changed file is bigger than 50 MB 
tonychia@blueapple /tmp/git-pre-commit-hook (check_file_size) $ ls -l application-check-app-2.0.3-macos.tar
-rw-r--r--@ 1 tonychia  staff  57207232 May  4 16:48 application-check-app-2.0.3-macos.tar
tonychia@blueapple /tmp/git-pre-commit-hook (check_file_size) $
tonychia@blueapple /tmp/git-pre-commit-hook (check_file_size) $ git status
On branch check_file_size
Untracked files:
  (use "git add <file>..." to include in what will be committed)

	application-check-app-2.0.3-macos.tar

nothing added to commit but untracked files present (use "git add" to track)
tonychia@blueapple /tmp/git-pre-commit-hook (check_file_size) $ git add application-check-app-2.0.3-macos.tar
tonychia@blueapple /tmp/git-pre-commit-hook (check_file_size) $ git commit -m "this should not be commited"
+ bash ./check_file_size

Checking to see if any of the changed files exceed the 50 MB limit
Checking application-check-app-2.0.3-macos.tar
  55868 kb is greater than 50 mb. not safe for git commit
tonychia@blueapple /tmp/git-pre-commit-hook (check_file_size) $ git status
On branch check_file_size
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	new file:   application-check-app-2.0.3-macos.tar

