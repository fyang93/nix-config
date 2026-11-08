HOSTNAME := env('HOSTNAME', `echo $HOSTNAME`)
HOMECONF := env('HOMECONF', `echo $USER@$HOSTNAME`)

default:
    @just --list

alias b := build
alias s := switch
alias c := clean
alias u := update

build hostname=HOSTNAME:
    #!/usr/bin/env bash
    set -euo pipefail
    [[ -d .git ]] && git add .
    sudo nixos-rebuild switch --flake ".#{{hostname}}" --show-trace

switch homeconf=HOMECONF:
    #!/usr/bin/env bash
    set -euo pipefail
    [[ -d .git ]] && git add .
    if command -v home-manager >/dev/null 2>&1; then
        home-manager switch --flake ".#{{homeconf}}" -L
    else
        nix run nixpkgs#home-manager -- switch --flake ".#{{homeconf}}" -L
    fi

clean:
    #!/usr/bin/env bash
    home-manager expire-generations "-7 days"
    nix-collect-garbage -d

update message="update":
    #!/usr/bin/env bash
    set -euo pipefail
    git add .
    if git status --porcelain | grep -q "^[AM]. secrets.toml"; then
        echo "Unstaging secrets.toml..."
        git restore --staged secrets.toml
    fi
    git commit -m "{{message}}"
    git push
