# Mouseless

[Mouseless](https://github.com/jbensmann/mouseless) is a tool that lets you control the mouse using the keyboard.

## Files

| File | Description |
|------|-------------|
| `config.yaml` | Active configuration |
| `backup_config.yaml` | Backup/alternative configuration |
| `mouseless.service` | Systemd user service file |

## Active Config (`config.yaml`)

- **Base mouse speed:** 250.0
- **Base scroll speed:** 20.0

### Key Bindings

Toggle the mouse layer with `CapsLock`.

| Key | Action |
|-----|--------|
| `CapsLock` | Toggle mouse layer on/off |
| `w` | Move up |
| `s` | Move down |
| `a` | Move left |
| `d` | Move right |
| `i` | Left click |
| `o` | Right click |
| `0` | Scroll up |
| `9` | Scroll down |

## Backup Config (`backup_config.yaml`)

Alternative config with higher base speed (750.0) and different activation methods.

### Key Bindings

| Key | Action |
|-----|--------|
| `Tab` (hold) | Toggle mouse layer |
| `a` (hold 300ms) | Toggle mouse layer |
| `q` | Exit mouse layer |
| `Space` | Stay in mouse layer |
| `i` | Move up |
| `k` | Move down |
| `j` | Move left |
| `l` | Move right |
| `f` | Left click |
| `d` | Middle click |
| `s` | Right click |
| `p` | Scroll up |
| `n` | Scroll down |
| `Left Alt` | Speed ×4.0 |
| `e` | Speed ×0.3 |
| `CapsLock` | Speed ×0.1 |

## Setup

### Install the service

Copy the config and enable the systemd user service:

```bash
mkdir -p ~/.config/mouseless
cp config.yaml ~/.config/mouseless/config.yaml

cp mouseless.service ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable --now mouseless
```

### Check service status

```bash
systemctl --user status mouseless
```
