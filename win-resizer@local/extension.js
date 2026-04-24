import Meta from 'gi://Meta';
import Shell from 'gi://Shell';
import * as Main from 'resource:///org/gnome/shell/ui/main.js';
import { Extension } from 'resource:///org/gnome/shell/extensions/extension.js';

// ─── Configure your presets here ──────────────────────────────────────────────
//
// Each entry needs:
//   key      : the keyboard shortcut string
//   width    : target window width in pixels
//   height   : target window height in pixels
//   x, y     : position to move the window to (optional — omit to keep current position)
//              use 'center' to auto-center on screen, or a pixel value e.g. x: 100, y: 50
//
// Key string format examples:
//   '<Super><Alt>1'   '<Control><Alt>c'   '<Super>F1'
//

const PRESETS = [
    // Super + [ and Super + ]
    { key: '<Super>bracketleft', width: 1520, height: 1020, x: 'center', y: 'center' },
    { key: '<Super>bracketright', width: 1720, height: 1020, x: 'center', y: 'center' },

    // Super + { and Super + } (Note the added <Shift>)
    { key: '<Super><Shift>bracketleft', width: 1080, height: 800, x: '', y: '' },
    { key: '<Super><Shift>bracketright', width: 1400, height: 960, x: '', y: '' },
];



export default class WindowResizerExtension extends Extension {
    enable() {
        this._settings = this.getSettings('org.gnome.shell.extensions.win-resizer');
        const mode = Shell.ActionMode.NORMAL;

        PRESETS.forEach((preset, i) => {
            const keyName = `preset-${i + 1}`;
            Main.wm.addKeybinding(
                keyName,
                this._settings,
                Meta.KeyBindingFlags.NONE,
                mode,
                () => this._applyPreset(preset)
            );
        });

        console.log('[win-resizer] enabled');
    }

    disable() {
        PRESETS.forEach((_, i) => {
            Main.wm.removeKeybinding(`preset-${i + 1}`);
        });

        this._settings = null;
        console.log('[win-resizer] disabled');
    }

    _applyPreset(preset) {
        const win = global.display.get_focus_window();
        if (!win || win.get_window_type() !== Meta.WindowType.NORMAL) return;

        if (win.get_maximized())
            win.unmaximize(Meta.MaximizeFlags.BOTH);

        const monitor = win.get_monitor();
        const workArea = Main.layoutManager.getWorkAreaForMonitor(monitor);
        const frame = win.get_frame_rect();

        const width = Math.min(preset.width, workArea.width);
        const height = Math.min(preset.height, workArea.height);

        let x = frame.x;
        let y = frame.y;

        if (preset.x === 'center') {
            x = workArea.x + Math.round((workArea.width - width) / 2);
        } else if (typeof preset.x === 'number') {
            x = workArea.x + preset.x;
        }

        if (preset.y === 'center') {
            y = workArea.y + Math.round((workArea.height - height) / 2);
        } else if (typeof preset.y === 'number') {
            y = workArea.y + preset.y;
        }

        // move_resize_frame(user_op, x, y, width, height)
        // user_op = true means it's a user-initiated operation (usually preferred)
        win.move_resize_frame(true, x, y, width, height);
    }
}
