# gnome-shortcuts

A script to apply and reset custom GNOME keybindings, designed to work alongside **xremap** for a clean, conflict-free shortcut setup.

## Design Philosophy

Shortcuts are split across three layers to avoid modifier conflicts:

| Layer | Modifier | Managed by |
|---|---|---|
| App-level navigation | `Alt+key` | xremap |
| Window management | `Super+key` | GNOME (this script) |
| Window move/workspace nav | `Super+Shift+key` | GNOME (this script) |
| Move window to workspace | `Super+Ctrl+key` | GNOME (this script) |

This separation ensures xremap and GNOME never fight over the same modifier namespace.

## Usage

```bash
# Apply custom keybindings
./gnome-shortcuts.sh

# Reset all keybindings to GNOME defaults
./gnome-shortcuts.sh --reset
```

Make it executable first:

```bash
chmod +x gnome-shortcuts.sh
```

## Keybinding Reference

### Window State — `Super+key`

| Shortcut | Action |
|---|---|
| `Super+k` | Maximize window |
| `Super+j` | Unmaximize window |
| `Super+q` | Close window |
| `Super+h` | Minimize window |
| `Super+m` | Show desktop |

### Window Positioning — `Super+key`

| Shortcut | Action |
|---|---|
| `Super+c` | Move to center |
| `Super+a` | Snap to left |
| `Super+d` | Snap to right |
| `Super+w` | Snap to top |
| `Super+s` | Snap to bottom |

### Window Move & Resize — `Super+Shift+key`

| Shortcut | Action |
|---|---|
| `Super+Shift+m` | Begin move (mouse drag) |
| `Super+Shift+r` | Begin resize (mouse drag) |

### Workspace Navigation — `Super+Shift+key`

| Shortcut | Action |
|---|---|
| `Super+Shift+j` | Switch to left workspace |
| `Super+Shift+k` | Switch to right workspace |

### Move Window to Workspace — `Super+Ctrl+key`

| Shortcut | Action |
|---|---|
| `Super+Ctrl+j` | Move window to left workspace |
| `Super+Ctrl+k` | Move window to right workspace |

## Notes

- `toggle-application-view` (default `Super+A`) is explicitly cleared to free up `Super+A` for `move-to-side-w`.
- Run `--reset` before re-applying if you're troubleshooting a conflict.
- To verify active bindings at any time:

```bash
gsettings list-recursively org.gnome.desktop.wm.keybindings
gsettings list-recursively org.gnome.shell.keybindings
```