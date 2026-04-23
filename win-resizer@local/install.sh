#!/bin/bash

UUID="win-resizer@local"
EXTENSION_DIR="$HOME/.local/share/gnome-shell/extensions"
DEST="$EXTENSION_DIR/$UUID"
SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing Window Resizer extension..."

# Create extension directory if it doesn't exist
mkdir -p "$EXTENSION_DIR"

# Symlink the folder
if [ -d "$DEST" ] || [ -L "$DEST" ]; then
    echo "Removing existing installation/symlink at $DEST..."
    rm -rf "$DEST"
fi

echo "Creating symlink from $SRC to $DEST..."
ln -s "$SRC" "$DEST"

# Compile schemas
echo "Compiling schemas..."
glib-compile-schemas "$SRC/schemas/"

echo ""
echo "Installation complete!"
echo "--------------------------------------------------------"
echo "To activate the extension:"
echo "1. Restart GNOME Shell (Alt+F2, type 'r' and Enter, or log out/in)."
echo "2. Enable the extension:"
echo "   gnome-extensions enable $UUID"
echo "--------------------------------------------------------"
