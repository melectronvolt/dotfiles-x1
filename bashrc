# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

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

# ==================================================
# ENVIRONNEMENT DE DÉVELOPPEMENT — Fedora
# Les symlinks "current" sont gérés par le script
# → Ne jamais modifier ce bloc, il reste valide
#   quelle que soit la version installée.
# ==================================================
export TOOLS_DIR="$HOME/.tools"

# 1. CMake (portable, via symlink)
export PATH="$TOOLS_DIR/cmake/current/bin:$PATH"

# 2. Python (UV)
export PATH="$HOME/.cargo/bin:$PATH"

# 3. C++ (Vcpkg)
export VCPKG_ROOT="$TOOLS_DIR/vcpkg"
export CMAKE_TOOLCHAIN_FILE="$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake"
export PATH="$VCPKG_ROOT:$PATH"

# 4. TeX Live (via symlink)
export PATH="$TOOLS_DIR/texlive/current/bin/x86_64-linux:$PATH"
export MANPATH="$TOOLS_DIR/texlive/current/texmf-dist/doc/man:${MANPATH-}"
export INFOPATH="$TOOLS_DIR/texlive/current/texmf-dist/doc/info:${INFOPATH-}"

# 5. Node.js (NVM)
export NVM_DIR="$TOOLS_DIR/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
source /usr/share/fzf/shell/key-bindings.bash
export PATH="$PATH:$HOME/go/bin"
source ~/.todoist_functions_fzf_bash.sh
eval "$(fzf --bash)"

# Override LS_COLORS pour dossiers en jaune (cohérence avec yazi/sway)
# 33 = jaune ANSI ; 01;33 = jaune gras

# LS_COLORS : base dircolors + overrides theme noir+jaune
eval "$(dircolors -b)"
LS_COLORS="${LS_COLORS}:di=01;33:ln=01;36:ex=01;32:ow=30;43:tw=30;43:st=30;43:su=01;31:sg=01;31:pi=01;35:so=01;35:bd=01;35:cd=01;35"
export LS_COLORS

