# Configuration
alias zshconfig="vim ~/.zshrc && source ~/.zshrc"
alias zshalias="vim ~/.oh-my-zsh/custom/aliases.zsh && source ~/.zshrc"
alias vimconfig="vim ~/.vimrc"
alias kattisconfig="vim ~/.kattisrc"
alias ackconfig="vim ~/.ackrc"

# Binaries
alias py="python3"
alias py2="python"
alias py3="python3"
alias ipy="ipython"
alias ipy3="ipython"
alias sml="rlwrap sml"

latexmake() {
    latexmk -pdf $1
    latexmk -c
}

gitall() {
    git add .
    if [[ $1 == "" ]]; then
        git commit
    else
        git commit -m
    fi
    git push
}
