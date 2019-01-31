#!/usr/bin/env zsh

lns() {
    mkdir -p "$(dirname "$HOME/$1")"
    ln -sv "$PWD/$1" "$HOME/$1"
}

for f in $(git ls-files); do
case "$f" in
".gitignore" | "install.sh")
    continue
    ;;
esac
    lns "$f"
done
