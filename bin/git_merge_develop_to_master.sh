#!/bin/bash

# check if it is in develop branch
CURRENT_BRANCH=`git branch | grep "*" | cut -b 3-`
if [[ $CURRENT_BRANCH != 'develop' ]]; then
    echo 'Run the script in develop branch please!!!'
    exit
fi

# check if the branch is up-to-date
NOTHING_TO_COMMIT=`git status | grep -o 'nothing to commit'`
if [[ $NOTHING_TO_COMMIT == '' ]]; then
    git status
    exit
fi

echo '============================================================'
echo 'git push origin develop'
git push origin develop

echo '============================================================'
echo 'git checkout master'
git checkout master

echo '============================================================'
echo 'git merge develop'
git merge --no-ff develop

echo '============================================================'
echo 'git push origin master'
git push origin master

echo '============================================================'
echo 'git checkout develop'
git checkout develop


