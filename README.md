# ⌨️ My 2404 Dotfiles: The Layered Linux Setup

A high-performance, conflict-free keyboard configuration for **GNOME on Linux**. This setup is designed for users who want **Vim-style navigation** and efficient window management across the entire OS.

---

## 🚀 The Philosophy: Conflict-Free Layering

Most Linux shortcut conflicts happen because different tools fight over the same modifiers (`Alt`, `Super`, `Ctrl`). This setup solves that by strictly separating concerns into three distinct layers:

| Layer | Modifier | Managed By | Purpose |
| :--- | :--- | :--- | :--- |
| **Key remapping** | keyd | Various | *[Unmaintained]* System-level key remapping |
| **Window Layer** | `Super` | **GNOME** | Window snapping, workspace switching, and tiling |
| **App Layer** | `Alt` | **xremap** | Cross-app consistency (e.g., `Alt+T` for new tabs everywhere) |

---

## 📂 Repository Structure

### 🛠️ [xremap/](xremap/)
**Dynamic App-Level Remapping**  
Uses a Rust-based remapper to provide consistent shortcuts across different applications (Browsers, Terminals, VSCode, etc.).
*   `config.yml`: Core remapping logic.
*   `xremap.service`: Systemd user service for "set it and forget it" background operation.

### 🐧 [gnome-script/](gnome-script/)
**Native GNOME Management**  
A precise Bash script that configures GNOME's internal window manager (`mutter`) via `gsettings`.
*   `my-gnome-shortcut.sh`: One-click setup for window snapping and workspace navigation.
* Resolves common conflicts (like `Super+W` hijacking or corner-snapping).

### 🔲 [win-resizer@local/](win-resizer@local/)
**Custom Window Presets**  
A lightweight GNOME Shell extension to instantly resize windows to specific dimensions (e.g., 720p, 1080p) or center them on screen.

### 📁 [keyd/](keyd/)
> [!NOTE]
> **Status: Unmaintained.** This component is kept for reference only. Its features have been migrated to the **xremap** layer to keep the configuration unified.

**System-level remapping configuration**  
Low-level configuration for the `keyd` daemon. Handles hardware-level remapping like the "Dual-role CapsLock" (Esc when tapped, Ctrl when held).

---

## 🛠️ Quick Start Guide

### 1. Prerequisite: Install the Engines
Ensure you have the core tools installed:
```bash
# Install keyd (low-level remapping)
# Follow your distro's package manager (e.g., sudo pacman -S keyd)

# Install xremap (app-level remapping)
cargo install xremap --features gnome
```

### 2. Apply the GNOME Layer
Configure your window management shortcuts instantly:
```bash
chmod +x gnome-script/my-gnome-shortcut.sh
./gnome-script/my-gnome-shortcut.sh
```

### 3. Activate the App Layer
Link your config and start the background service:
```bash
mkdir -p ~/.config/xremap
ln -s $(pwd)/xremap/config.yml ~/.config/xremap/config.yml
systemctl --user enable --now $(pwd)/xremap/xremap.service
```

### 4. Install the Extension
```bash
chmod +x win-resizer@local/install.sh
./win-resizer@local/install.sh
```

---

## 🔄 Reset to Defaults
Need to revert everything? We've got you covered:
```bash
./gnome-script/my-gnome-shortcut.sh --reset
systemctl --user disable --now xremap.service
```

---

## 📄 License
This setup is open-source and free to use. Feel free to fork and adapt it to your own workflow!
