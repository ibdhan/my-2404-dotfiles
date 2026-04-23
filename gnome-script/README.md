# 🐧 GNOME Keybinding Manager

This component handles the **Window Layer** of your configuration. It uses a Bash script to directly manipulate GNOME's `gsettings` database, ensuring that window management is fast, native, and conflict-free.

## 🎯 Key Design Goals
- **Vim-Style Navigation**: Use `H/J/K/L` or `W/A/S/D` logic for window snapping.
- **Modifier Separation**: All window management is strictly bound to the `Super` key.
- **No Corner-Snap Hijacking**: Explicitly clears corner-snapping shortcuts that often conflict with side-snapping.

---

## 🛠️ Usage

### Apply Shortcuts
```bash
chmod +x my-gnome-shortcut.sh
./my-gnome-shortcut.sh
```

### Reset to GNOME Defaults
```bash
./my-gnome-shortcut.sh --reset
```

---

## 📋 Keybinding Reference

### Window Snapping (`Super + key`)
| Shortcut | Action | Note |
| :--- | :--- | :--- |
| `Super + W` | **Snap to Top** | Fixed to avoid North-East corner snap |
| `Super + S` | **Snap to Bottom** | |
| `Super + A` | **Snap to Left** | |
| `Super + D` | **Snap to Right** | |
| `Super + C` | **Move to Center** | |

### Window State (`Super + key`)
| Shortcut | Action |
| :--- | :--- |
| `Super + K` | Maximize window |
| `Super + J` | Unmaximize window |
| `Super + H` | Minimize window |
| `Super + Q` | Close window |
| `Super + M` | Show desktop |

### Workspace & Movement
| Shortcut | Modifier | Action |
| :--- | :--- | :--- |
| `Super + Shift + J` | `Super+Shift` | Switch to Left Workspace |
| `Super + Shift + K` | `Super+Shift` | Switch to Right Workspace |
| `Super + Ctrl + J` | `Super+Ctrl` | Move Window to Left Workspace |
| `Super + Ctrl + K` | `Super+Ctrl` | Move Window to Right Workspace |

---

## 🔍 Troubleshooting
If a shortcut like `Super+W` is still moving windows to a corner, verify your active bindings with:
```bash
gsettings list-recursively org.gnome.desktop.wm.keybindings | grep "<Super>w"
```
The script now explicitly clears `move-to-corner-ne` to ensure `Super+W` only triggers `move-to-side-n`.