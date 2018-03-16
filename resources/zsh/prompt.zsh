autoload -Uz colors && colors

autoload -Uz add-zsh-hook
add-zsh-hook precmd _set_prompt

_set_prompt() {
    _prompt_random_256
}

# Get the status if in git repository {{{
_prompt_git_status() {
    local prompt
    local branch_name staged modified untracked conflicts

    branch_name="$( git rev-parse --abbrev-ref HEAD 2>/dev/null )"
    # Not in git repository
    if [[ -z $branch_name ]]; then
        return
    fi

    # Clean repository?
    if [[ -z $( git status --short 2>/dev/null ) ]]; then
        echo "%F{046}$branch_name%f"
        return
    fi

    staged="$( git diff --cached --numstat | command wc -l | tr -d ' ' )"
    if [[ $staged -ne 0 ]]; then
        prompt+="%F{010}S%f$staged "
    fi

    modified="$( git diff --numstat | command wc -l | tr -d ' ' )"
    if [[ $modified -ne 0 ]]; then
        prompt+="%F{009}M%f$modified "
    fi

    untracked="$( git status --short | command grep '^\s*??' | command wc -l | tr -d ' ' )"
    if [[ $untracked -ne 0 ]]; then
        prompt+="%F{099}U%f$untracked "
    fi

    conflicts="$( git status --short | command grep '^\s*UU' | command wc -l | tr -d ' ' )"
    if [[ $conflicts -ne 0 ]]; then
        prompt+="%F{190}C%f$conflicts "
    fi

    if [[ -n $( git status | grep '^rebase in progress' ) ]]; then
        # Rebase is in progress
        prompt+="%F{039}REBASE%f"
    else
        prompt+="%F{197}$branch_name%f"
    fi

    echo $prompt
}
# }}}

_prompt_dollar() {
    local rnd=$1
    shift
    local -a valid_colors
    valid_colors=($@)
    local ind=$(( $rnd % ${#valid_colors[@]} + 1))
    local dollar="%F{${valid_colors[$ind]}}%%%f"

    echo $dollar
}

# Randomly selects a 256 color to use for the dollar {{{
_prompt_random_256() {
    local front percent rnd username l_prompt
    local -a valid_colors


    # Change hostname on remote login
    if [[ -n $REMOTEHOST ]] || [[ -n $SSH_CONNECTION ]]; then
        front="%n@%m"
    else
        front="%n@%F{222}%m%f"
    fi

    valid_colors=({001..015} {022..051} {058..087} {094..159} {161..231} {242..255})
    sign='%%'
    percent="%0(?,%F{046}$sign%f,%20(?,%F{046}$sign%f,%F{009}$sign%f))"

    PROMPT="$front:%~$percent "
}
# }}}
# }}}
