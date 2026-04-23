# xremap — Setup & Configuration Guide

> Key remapper for Linux (X11 & Wayland), written in Rust.  
> This guide targets **GNOME on native Linux** with a dotfiles-oriented workflow.

---

## Table of Contents

1. [Installation](#installation)
2. [GNOME Shell Extension](#gnome-shell-extension)
3. [Running Without sudo](#running-without-sudo)
4. [Configuration](#configuration)
5. [Running xremap](#running-xremap)
6. [Running as a systemd User Service](#running-as-a-systemd-user-service)
7. [Dotfiles Integration](#dotfiles-integration)
8. [Debugging](#debugging)

---

## Installation

### Option 1 — Prebuilt Binary

Download the `gnome` variant from the [GitHub Releases page](https://github.com/xremap/xremap/releases):

```bash
curl -LO https://github.com/xremap/xremap/releases/latest/download/xremap-linux-x86_64-gnome.zip
unzip xremap-linux-x86_64-gnome.zip
sudo mv xremap /usr/local/bin/
```

### Option 2 — Build from Source (Recommended)

```bash
cargo install xremap --features gnome
```

The binary is placed at `~/.cargo/bin/xremap`. Make sure it's in your `$PATH`:

```bash
# Add to ~/.bashrc or ~/.zshrc if not already present
export PATH="$HOME/.cargo/bin:$PATH"
```

---

## GNOME Shell Extension

Required for **app-specific remapping** to work. Without it, xremap cannot detect the active window.

1. Visit: https://extensions.gnome.org/extension/5060/xremap/
2. Toggle the extension **OFF → ON**

Global remapping still works without the extension.

---

## Running Without sudo

Grant your user access to `/dev/input/*` and `/dev/uinput`:

```bash
# Add user to input group
sudo gpasswd -a $USER input

# Allow uinput access via udev rule
echo 'KERNEL=="uinput", GROUP="input", MODE="0660"' | sudo tee /etc/udev/rules.d/99-input.rules

# Reload udev rules
sudo udevadm control --reload-rules && sudo udevadm trigger
```

Then **re-login** (or run `newgrp input` for the current session).

---

## Configuration

Default config location: `~/.config/xremap/config.yml`

### Config Structure

There are two main blocks:

- **`modmap`** — simple key-to-key remapping, including dual-role (held vs. alone)
- **`keymap`** — combination/sequence remapping, supports app-specific rules

### Example Config

```yaml
# modmap: key-to-key, including dual-role
modmap:
  - name: CapsLock dual-role
    remap:
      CapsLock:
        held: Control_L
        alone: Esc
        alone_timeout_millis: 200   # ms threshold to distinguish tap vs hold

# keymap: combinations, sequences, app-specific overrides
keymap:
  - name: Emacs-style navigation (terminal only)
    application:
      only: [Alacritty, kitty, Gnome-terminal]
    remap:
      C-b: left
      C-f: right
      C-p: up
      C-n: down

  - name: Vim-style arrow keys (everywhere except browser)
    application:
      not: [Google-chrome, Firefox]
    remap:
      Alt-h: left
      Alt-l: right
      Alt-k: up
      Alt-j: down
```

### Finding Application Names

```bash
# Check window class names (use the part after the dot)
wmctrl -x -l

# Or watch xremap's log output when switching windows
RUST_LOG=debug xremap ~/.config/xremap/config.yml
```

### Key Name Reference

Key names are case-insensitive and the `KEY_` prefix is optional:
- `KEY_CAPSLOCK`, `CAPSLOCK`, and `CapsLock` are all equivalent
- Modifier prefixes: `C-` (Ctrl), `M-` (Alt), `Super-`, `Shift-`
- Left/right variants: `Ctrl_L`, `Ctrl_R`, `Alt_L`, `Alt_R`

---

## Running xremap

### One-shot (for testing)

```bash
xremap ~/.config/xremap/config.yml
```

### With auto-reload

```bash
# Watch for config changes and new input devices
xremap --watch=config,device ~/.config/xremap/config.yml
```

---

## Running as a systemd User Service

create symlink config
```ini
# Instead of editing ~/.config/xremap/config.yml directly,
# symlink it from your dotfiles directory
mkdir -p ~/.config/xremap
ln -s ~/dotfiles/xremap/config.yml ~/.config/xremap/config.yml
```

Create `~/.config/systemd/user/xremap.service`:

```ini
[Unit]
Description=xremap key remapper
After=graphical-session.target
PartOf=graphical-session.target

[Service]
ExecStart=/usr/local/bin/xremap %h/.config/xremap/config.yml
Restart=on-failure
RestartSec=3
Environment=DISPLAY=:0

[Install]
WantedBy=graphical-session.target
```

> `%h` expands to your home directory — no need to hardcode the path.

### Enable and Start

```bash
systemctl --user daemon-reload
systemctl --user enable --now xremap.service
```

### Useful Service Commands

```bash
# Check status
systemctl --user status xremap

# Live logs
journalctl --user -u xremap -f

# Restart after config changes (if not using --watch=config)
systemctl --user restart xremap

# Disable
systemctl --user disable --now xremap.service
```

---

## Dotfiles Integration

Keep both files in a single folder inside your dotfiles repo and symlink them.

### Recommended Structure

```
~/.dotfiles/
└── xremap/
    ├── config.yml
    └── xremap.service
```

### Create Symlinks

```bash
# Config
mkdir -p ~/.config/xremap
ln -s ~/.dotfiles/xremap/config.yml ~/.config/xremap/config.yml

# Service
mkdir -p ~/.config/systemd/user
ln -s ~/.dotfiles/xremap/xremap.service ~/.config/systemd/user/xremap.service

# Reload and enable
systemctl --user daemon-reload
systemctl --user enable --now xremap.service
```

### Resulting Symlink Chain

```
~/.config/systemd/user/graphical-session.target.wants/xremap.service
  → ~/.config/systemd/user/xremap.service
    → ~/.dotfiles/xremap/xremap.service
```

systemd follows the full chain correctly — no issues with symlink-to-symlink.

---

## Debugging

```bash
# See key names as you press them
RUST_LOG=debug xremap ~/.config/xremap/config.yml

# List all detected input devices
xremap --list-devices

# Show detailed device info
xremap --device-details
```

### Common Issues

| Problem | Likely Cause | Fix |
|---|---|---|
| `permission denied` on `/dev/input` | User not in `input` group | `sudo gpasswd -a $USER input`, re-login |
| App-specific rules not working | GNOME extension not enabled | Enable extension at extensions.gnome.org |
| `No protocol specified` when using sudo | Root can't access compositor | Run `xhost +SI:localuser:root` |
| Key events firing twice | Device not grabbed exclusively | Check for conflicting remapping tools |
