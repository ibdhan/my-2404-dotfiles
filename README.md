# My 2404 Dotfiles

A comprehensive dotfiles configuration for **GNOME Linux** keyboard shortcuts and key remapping. This repo organizes keybindings across multiple layers to create a conflict-free, efficient shortcut setup.

## Overview

This repo contains three complementary tools that work together to manage keyboard shortcuts:

| Layer | Tool | Modifier | Purpose |
|---|---|---|---|
| **App-level shortcuts** | xremap | `Alt+key` | Application-specific remapping (X11 & Wayland) |
| **Window management** | GNOME | `Super+key` | Native GNOME window operations |
| **Key remapping** | keyd | Various | System-level key remapping |

## Folder Structure

### 📁 [xremap/](xremap/)
**X11/Wayland key remapper written in Rust**

Handles app-level shortcuts using `Alt+key` bindings. Includes configuration for common applications and a systemd service to run xremap automatically.

- `config.yml` — Main configuration with app-specific keybindings
- `xremap.service` — Systemd user service for automatic startup
- `README.md` — Detailed installation and setup guide

👉 **Quick start:** See [xremap/README.md](xremap/README.md) for installation and usage.

### 📁 [gnome-script/](gnome-script/)
**GNOME keybindings manager script**

Bash script to apply and reset custom GNOME window management shortcuts using `Super+key` and `Super+Shift+key` bindings.

- `my-gnome-shortcut.sh` — Main script (apply or reset keybindings)
- `command-list.txt` — Reference list of GNOME keybinding commands
- `README.md` — Full keybinding reference table

👉 **Quick start:**
```bash
chmod +x gnome-script/my-gnome-shortcut.sh
gnome-script/my-gnome-shortcut.sh        # Apply keybindings
gnome-script/my-gnome-shortcut.sh --reset  # Reset to defaults
```

### 📁 [keyd/](keyd/)
**keyd key remapper configuration**

System-level key remapping configuration file for keyd, supporting features like key overloading and remapping.

- `default.conf` — Main keyd configuration with modifier and key mappings

👉 **Quick start:** Copy or symlink `keyd/default.conf` to `/etc/keyd/default.conf` and restart keyd.

## Setup Guide

### 1. Install Dependencies

```bash
# xremap (choose one method from xremap/README.md)
cargo install xremap --features gnome
# or download prebuilt binary

# keyd (optional, for system-level remapping)
# Follow your distro's package manager
```

### 2. Apply Shortcuts

```bash
# Apply GNOME keybindings
./gnome-script/my-gnome-shortcut.sh

# Install and start xremap
# See xremap/README.md for detailed instructions
```

### 3. Configure

- Edit `xremap/config.yml` for app-specific shortcuts
- Edit `keyd/default.conf` for system-level remapping
- Edit `gnome-script/my-gnome-shortcut.sh` for window management bindings

## Key Design Philosophy

This setup avoids modifier conflicts by separating concerns:

- **xremap** handles `Alt+key` for app-level navigation
- **GNOME** handles `Super+key` and `Super+Shift+key` for window management
- **keyd** handles global system-level key remapping

This layered approach prevents shortcut collisions and ensures each tool operates in its own namespace.

## Reset to Defaults

To remove all custom keybindings:

```bash
./gnome-script/my-gnome-shortcut.sh --reset
```

Then stop/uninstall xremap and keyd services.

## More Information

Each folder has detailed documentation:
- [xremap/README.md](xremap/README.md) — Full setup, GNOME shell extension, systemd service
- [gnome-script/README.md](gnome-script/README.md) — Complete keybinding reference table
- [keyd/default.conf](keyd/default.conf) — Inline configuration comments

## License

Feel free to use and adapt these configurations for your own setup.
