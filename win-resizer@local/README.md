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
    // Super + [ and Super + ]
    { key: '<Super>bracketleft', width: 1520, height: 1020, x: 'center', y: 'center' },
    { key: '<Super>bracketright', width: 1720, height: 1020, x: 'center', y: 'center' },

    // Super + { and Super + } (Note the added <Shift>)
    { key: '<Super><Shift>bracketleft', width: 1080, height: 800, x: '', y: '' },
    { key: '<Super><Shift>bracketright', width: 1400, height: 960, x: '', y: '' },
];
```

- **key**: The keyboard shortcut (e.g., `<Super>bracketleft`).
- **width/height**: Target dimensions in pixels.
- **x/y**: (Optional) Position. Use `'center'` for auto-centering, or a pixel value. Leave as `''` or omit to keep current position.

---

## 📋 Default Shortcuts
- `Super + [`: 1520x1020 (Centered)
- `Super + ]`: 1720x1020 (Centered)
- `Super + {`: 1080x800 (Maintain position)
- `Super + }`: 1400x960 (Maintain position)

---

## 🔧 Troubleshooting

### "Expected type string for argument 'schema_id' but got type undefined"
If you encounter this error when enabling the extension, it means GNOME cannot find the settings schema. Ensure that:
1. `metadata.json` contains `"settings-schema": "org.gnome.shell.extensions.win-resizer"`.
2. The schema has been compiled using `glib-compile-schemas schemas/`.
3. The `extension.js` calls `this.getSettings('org.gnome.shell.extensions.win-resizer')`.

The included `install.sh` handles the compilation automatically.
