_echo_info() {
    local msg="$1"
    echo "${msg}"
}

_echo_success() {
    local msg="$1"
    echo -e "\033[32m${msg}\033[0m"
}

_echo_warn() {
    local msg="$1"
    echo -e "\033[33m${msg}\033[0m" >&2
}

_echo_error() {
    local msg="$1"
    echo -e "\033[31m${msg}\033[0m" >&2
}

_is_installed() {
    local package="$1"
    [[ -n $( dpkg -l | grep "$package" ) ]]
}

_install() {
    local package="$1"
    echo "Installing $package"
    sudo apt-get install --assume-yes $package
}

_get_from_url() {
    local url="$1"
    local dest="$2"

    if hash curl 2>/dev/null; then
        curl -sL "$url" -o "$dest"
    elif hash wget 2>/dev/null; then
        wget "$url" -O "$dest"
    fi
    local get_status="$?"

    return "$get_status"
}
