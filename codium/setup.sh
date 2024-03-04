#!/bin/bash

set -e

install_codium_extensions() {
    codium --install-extension ms-python.python
    codium --install-extension GitHub.vscode-pull-request-github
    codium --install-extension PKief.material-icon-theme
    codium --install-extension ritwickdey.LiveServer
    codium --install-extension James-Yu.latex-workshop
    codium --install-extension alexcvzz.vscode-sqlite
    #codium --install-extension qwtel.sqlite-viewer
    codium --install-extension bierner.markdown-mermaid
}

install_codium_extensions
