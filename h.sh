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
                ;;
        esac
        [ -d "$HSH_ROOT/bin" ] mkdir -p "$HSH_ROOT/bin"
        ln -s "$HSH_ROOT/.local/share/pk/pk" "bin/pk"
        ;;
esac
