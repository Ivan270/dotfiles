# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
for dir in "$HOME/bin" "$HOME/.local/bin" "$HOME/.opencode/bin"; do
    if [ -d "$dir" ]; then
        case ":$PATH:" in
            *":$dir:"*) ;;
            *) PATH="$dir:$PATH" ;;
        esac
    fi
done
unset dir
export PATH

# El resto de la configuración es exclusivo de shells interactivos.
[[ $- == *i* ]] || return

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
fi
