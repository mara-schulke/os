nix-shell-status() {
    if nix-shell-active; then
        echo "%{$fg[magenta]%}$name:%{$reset_color%} ";
    fi
}

formatted-current-branch() {
    local BRANCH="$(current_branch)"
    local LEN=${#BRANCH}

    if [ $LEN -gt 0 ]; then
        echo " %{$fg[magenta]%}$BRANCH%{$reset_color%} "
    else
        echo " "
    fi
}

zsh-prompt() {
	echo '$(nix-shell-status)$(basename "$PWD")$(formatted-current-branch)λ '
}

setopt PROMPT_SUBST
PROMPT="$(zsh-prompt)"
RPROMPT=""
 RPROMPT=""
