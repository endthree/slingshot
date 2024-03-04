#!/bin/bash

set -e

# .bashrc
vsbackup() {
    sh $HOME/slingshot/codium/backup_config.sh
}

backup_config() {
    cp $HOME/.config/VSCodium/User/$1.json $HOME/slingshot/codium/config
}

backup_config settings
backup_config keybindings
