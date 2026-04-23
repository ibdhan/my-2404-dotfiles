# 🔲 Window Resizer GNOME Extension

A lightweight, local GNOME Shell extension that allows you to instantly resize and reposition the focused window using custom keyboard presets.

## ✨ Features
- **Instant Resizing**: Snap windows to common sizes (720p, 1080p, etc.).
- **Auto-Centering**: Move windows to the exact center of the monitor.
- **Custom Presets**: Easily add your own dimensions in the configuration.

---

## 🛠️ Installation

1.  **Run the install script**:
    ```bash
    chmod +x install.sh
    ./install.sh
    ```
    This script will symlink the extension to your local GNOME folder and compile the necessary schemas.

2.  **Restart GNOME Shell**:
    - On X11: Press `Alt+F2`, type `r`, and hit `Enter`.
    - On Wayland: Log out and log back in.

3.  **Enable the extension**:
    ```bash
    gnome-extensions enable win-resizer@local
    ```

---

## ⚙️ Configuration

You can customize the presets directly in `extension.js`. Look for the `PRESETS` constant at the top of the file:

```javascript
const PRESETS = [
    { key: '<Super><Alt>1', width: 1280, height: 720, x: 'center', y: 'center' },
    { key: '<Super><Alt>2', width: 1920, height: 1080, x: 'center', y: 'center' },
    { key: '<Super><Alt>3', width: 800, height: 600 },
];
```

- **key**: The keyboard shortcut (e.g., `<Super><Alt>1`).
- **width/height**: Target dimensions in pixels.
- **x/y**: (Optional) Position. Use `'center'` for auto-centering.

---

## 📋 Default Shortcuts
- `Super + Alt + 1`: 720p (Centered)
- `Super + Alt + 2`: 1080p (Centered)
- `Super + Alt + 3`: 800x600 (Current position)
