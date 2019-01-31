#!/usr/bin/env zsh

lns() {
    ln -sv "$PWD/$1" "$HOME/$1"
}

for f in $(git ls-files); do
case "$C" in
".gitignore" | "install.sh")
    continue
    ;;
esac
    lns "$f"
done
