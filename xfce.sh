#!/bin/bash

set -e

main() {
    xfconf-query --channel xfce4-panel --propery /panels/panel-1/size --set 26
}

main
