#!/bin/bash

set -e

main() {
    # https://docs.xfce.org/xfce/xfconf/xfconf-query
    xfconf-query --channel xfce4-panel --propery /panels/panel-1/size --set 26
}

main
