#! /bin/sh

# this script is called after each git command, after 
# the 'bundle' and 'remove' command which have no git equivalent, and after the
# extraction of a bundle.
# The following environment variables are set:
#     - HSH_ROOT: current hsh root;
#     - HSH_REPOSITORY: current repository name;
#     - HSH_ACTION: current git or hsh action, for "bundle" command, HSH_ACTION
#       is set to 'bundle-in', when extracting a bundle the action is set to
#       'bundle-out'.
# Additionally, for bundle-in and bundle-out actions the HSH_BUNDLE_ROOT is set
# to the bundle content root.


base_system() {
    if cat /etc/os-release | grep -q "debian"
    then
        echo "debian"
    elif cat /etc/os-release | grep -q "rhel"
    then
        echo "rhel"
    else
        echo "unsupported"
    fi
}

case "$HSH_ACTION" in
    clone|bundle-out)
        case "$(base_system)" in
            "debian")
                sudo apt-get install build-essential curl file git
                ;;
            "rhel")
                sudo dnf groupinstall 'Development Tools'
                sudo dnf install curl file git
                sudo dnf install libxcrypt-compat # needed by Fedora 30 and up
                ;;
        esac
        source "$HSH_ROOT/.config/profile/homebrew"
        HOMEBREW_HOME="$HSH_ROOT/.local/homebrew/homebrew"
        if [ -d "$HOMEBREW_HOME/brew"  ]
        then
            git -C "$HOMEBREW_HOME/brew" pull --rebase
        else
            mkdir -p "$HOMEBREW_HOME"
            git -C "$HOMEBREW_HOME" clone "https://github.com/Homebrew/brew"
        fi
        [ -d "$HSH_ROOT/bin"  ] || mkdir "$HSH_ROOT/bin"
        [ -e "$HSH_ROOT/bin/brew"  ] || ln -s "$HSH_ROOT/.local/homebrew/homebrew/brew/bin/brew" "$HSH_ROOT/bin/brew"
        ;;
esac
