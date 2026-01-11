HOSTNAME := env('HOSTNAME', `echo $HOSTNAME`)
HOMECONF := env('HOMECONF', `echo $USER@$HOSTNAME`)

default:
    @just --list

alias b := build
alias m := manage

build hostname=HOSTNAME:
    #!/usr/bin/env bash
    set -euo pipefail
    [[ -d .git ]] && git add .
    sudo nixos-rebuild switch --flake ".#{{hostname}}" --show-trace

manage homeconf=HOMECONF:
    #!/usr/bin/env bash
    set -euo pipefail
    [[ -d .git ]] && git add .
    home-manager switch --flake ".#{{homeconf}}"
