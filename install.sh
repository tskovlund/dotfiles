#!/usr/bin/env zsh

cd "$(dirname $0)"

lns() {
    mkdir -p "$(dirname "$HOME/$1")"
    if [[ $(readlink "$HOME/$1") = "$PWD/$1" ]]; then
        echo $1 already symlinked
        return
    fi
    ln -isv "$PWD/$1" "$HOME/$1"
}

for f in $(git ls-files); do
case "$f" in
".gitignore" | "install.sh")
    continue
    ;;
esac
    lns "$f"
done
