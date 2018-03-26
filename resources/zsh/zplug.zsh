local os="${(L)$( uname -s )}"
if [[ $os =~ cygwin ]]; then
    os=cygwin
fi

zplug 'zplug/zplug'

zplug 'NigoroJr/mkmv', \
    as:command, \
    use:'mkmv'

zplug "junegunn/fzf-bin", \
    from:gh-r, \
    as:command, \
    use:"*${(L)$(uname -s)}*amd64*", \
    rename-to:fzf

zplug 'plugins/pip', \
    from:oh-my-zsh, \
    ignore:'{oh-my-zsh.sh,plugins/pip/pip.plugin.zsh}', \
    defer:2

zplug 'Valodim/zsh-curl-completion', \
    defer:2

zplug 'zsh-users/zsh-syntax-highlighting', \
    defer:3

zplug 'b4b4r07/enhancd', use:init.sh

zplug 'knu/z', \
    use:'z.sh', \
    defer:1
zplug 'zsh-users/zaw', defer:2
zplug 'NigoroJr/zaw-z', defer:3
