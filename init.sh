#!/bin/bash

set -e

create_directory() {
    mkdir $HOME/$REPONAME
}

initialize_repository() {
    USERNAME=$(git config user.name)
    gh repo create $REPONAME --private
    cd $HOME/$REPONAME
    git init
    git add .
    git commit -m "init"
    git branch -M main
    git remote add origin https://github.com/$USERNAME/$REPONAME.git
    git push -u origin main
}

main() {
    REPONAME=$1
    #create_directory
    initialize_repository
}

main slingshot
