HOSTNAME := env('HOSTNAME', `echo $HOSTNAME`)
HOMECONF := env('HOMECONF', `echo $USER@$HOSTNAME`)

default:
    @just --list

alias b := build
alias s := switch
alias u := update
alias c := clean
alias p := push

build hostname=HOSTNAME:
    #!/usr/bin/env bash
    set -euo pipefail
    [[ -d .git ]] && git add .
    sudo nixos-rebuild switch --flake ".#{{hostname}}" --show-trace

switch homeconf=HOMECONF:
    #!/usr/bin/env bash
    set -euo pipefail
    [[ -d .git ]] && git add .
    home-manager switch --flake ".#{{homeconf}}" -L

update:
    #!/usr/bin/env bash
    nix flake update

clean:
    #!/usr/bin/env bash
    home-manager expire-generations "-7 days"
    nix-collect-garbage -d

push message="update":
    #!/usr/bin/env bash
    set -euo pipefail
    git add .
    if git status --porcelain | grep -q "^[AM]. secrets.toml"; then
        echo "Unstaging secrets.toml..."
        git restore --staged secrets.toml
    fi
    git commit -m "{{message}}"
    git push
