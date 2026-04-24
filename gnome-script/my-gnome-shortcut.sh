#!/bin/bash
# gnome-shortcuts.sh
# Applies custom GNOME keybindings optimized for xremap + vim-style navigation.
# Usage:
#   ./gnome-shortcuts.sh          Apply keybindings
#   ./gnome-shortcuts.sh --reset  Reset all to GNOME defaults

set -e

WM="org.gnome.desktop.wm.keybindings"
SHELL="org.gnome.shell.keybindings"

# ─────────────────────────────────────────
# Reset
# ─────────────────────────────────────────
if [[ "$1" == "--reset" ]]; then
    echo "Resetting keybindings to GNOME defaults..."

    # Window state
    gsettings reset $WM maximize
    gsettings reset $WM unmaximize
    gsettings reset $WM close
    gsettings reset $WM minimize
    gsettings reset $WM show-desktop

    # Window positioning
    gsettings reset $WM move-to-center
    gsettings reset $WM move-to-side-e
    gsettings reset $WM move-to-side-n
    gsettings reset $WM move-to-side-s
    gsettings reset $WM move-to-side-w
    gsettings reset $WM move-to-corner-nw
    gsettings reset $WM move-to-corner-ne
    gsettings reset $WM move-to-corner-sw
    gsettings reset $WM move-to-corner-se

    # Window move/resize
    gsettings reset $WM begin-move
    gsettings reset $WM begin-resize

    # Workspace navigation
    gsettings reset $WM switch-to-workspace-left
    gsettings reset $WM switch-to-workspace-right
    gsettings reset $WM move-to-workspace-left
    gsettings reset $WM move-to-workspace-right

    # Shell
    gsettings reset $SHELL toggle-application-view

    gsettings reset org.gnome.shell.extensions.dash-to-dock shortcut
    gsettings reset org.gnome.shell.extensions.dash-to-dock shortcut-text

    gsettings reset $SHELL toggle-quick-settings
    gsettings reset $WM activate-window-menu

    echo "Done! All keybindings restored to defaults."
    exit 0
fi

# ─────────────────────────────────────────
# Apply
# ─────────────────────────────────────────
echo "Applying custom GNOME keybindings..."

# Window state — Super+key
gsettings set $WM maximize        "['<Super>k']"
gsettings set $WM unmaximize      "['<Super>j']"
gsettings set $WM close           "['<Super>q']"
gsettings set $WM minimize        "['<Super>h']"
gsettings set $WM show-desktop    "['<Super>m']"

# Window positioning — Super+key (vim-style directions)
gsettings set $WM move-to-center  "['<Super>c']"
gsettings set $WM move-to-side-w  "['<Super>a']"
gsettings set $WM move-to-side-e  "['<Super>d']"
gsettings set $WM move-to-side-n  "['<Super>w']"
gsettings set $WM move-to-side-s  "['<Super>s']"

# Clear corner positioning to avoid conflicts (e.g., Super+W hijacking top-right)
gsettings set $WM move-to-corner-nw  "[]"
gsettings set $WM move-to-corner-ne  "[]"
gsettings set $WM move-to-corner-sw  "[]"
gsettings set $WM move-to-corner-se  "[]"

# Window move/resize — Super+Shift+key
gsettings set $WM begin-move      "['<Super><Shift>m']"
gsettings set $WM begin-resize    "['<Super><Shift>r']"

# Workspace navigation — Super+Shift+key
gsettings set $WM switch-to-workspace-left   "['<Super><Shift>j']"
gsettings set $WM switch-to-workspace-right  "['<Super><Shift>k']"

# Move window to workspace — Super+Ctrl+key
gsettings set $WM move-to-workspace-left   "['<Super><Control>j']"
gsettings set $WM move-to-workspace-right  "['<Super><Control>k']"

# Shell — clear conflicts
gsettings set $SHELL toggle-application-view "['<Alt>space']"

gsettings set org.gnome.shell.extensions.dash-to-dock shortcut "[]"
gsettings set org.gnome.shell.extensions.dash-to-dock shortcut-text ""

# Shell — toggle-quick-settings
gsettings set $SHELL toggle-quick-settings "[]"
gsettings set $WM activate-window-menu "[]"

echo "Done! Keybindings applied successfully."
