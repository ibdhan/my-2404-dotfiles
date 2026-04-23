# 🛠️ xremap: The App-Level Engine

This component handles the **App Layer** of your configuration. It ensures that common shortcuts (like "New Tab", "Close Tab", or "Reload") work identically across all your applications, regardless of their native defaults.

## 🚀 Why xremap?
GNOME's native shortcuts are limited. `xremap` allows for:
- **Application-specific rules**: Send `Ctrl+T` in a browser but `Ctrl+Shift+T` in a terminal when you press `Alt+T`.
- **Dual-role keys**: Use a single key for two different purposes (e.g., CapsLock).
- **Wayland Support**: Works perfectly on modern GNOME Wayland sessions.

---

## 📦 Installation

### 1. Install the Binary
```bash
cargo install xremap --features gnome
```

### 2. Permissions (Crucial)
Grant your user access to the input devices so you don't have to run as root:
```bash
sudo gpasswd -a $USER input
echo 'KERNEL=="uinput", GROUP="input", MODE="0660"' | sudo tee /etc/udev/rules.d/99-input.rules
sudo udevadm control --reload-rules && sudo udevadm trigger
```
*Note: You must logout and log back in for these changes to take effect.*

### 3. GNOME Shell Extension
Install the [xremap GNOME extension](https://extensions.gnome.org/extension/5060/xremap/) to allow the remapper to detect which window is currently focused.

---

## ⚙️ Configuration

### Symlinking to your system
Keep your config in this dotfiles repo and link it to the default xremap location:
```bash
mkdir -p ~/.config/xremap
ln -s $(pwd)/config.yml ~/.config/xremap/config.yml
```

### Managing the Service
Run xremap in the background automatically via systemd:
```bash
# Enable and start the service
systemctl --user enable --now $(pwd)/xremap.service

# Check logs if something isn't working
journalctl --user -u xremap -f
```

---

## ⌨️ Common Shortcuts Applied
| Your Key | App Type | Actual Key Sent |
| :--- | :--- | :--- |
| `Alt + T` | Browser | `Ctrl + T` |
| `Alt + T` | Terminal | `Ctrl + Shift + T` |
| `Alt + W` | Browser | `Ctrl + W` |
| `Alt + J` | Browser | `Ctrl + Shift + Tab` (Previous) |
| `Alt + K` | Browser | `Ctrl + Tab` (Next) |

---

## 🧪 Debugging
To see which window classes are being detected and how keys are being remapped:
```bash
RUST_LOG=debug xremap ~/.config/xremap/config.yml
```
